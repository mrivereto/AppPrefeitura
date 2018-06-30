//
//  SecretaryServiceViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "SecretaryServiceViewController.h"
#import "TransactionUtil.h"
#import "ContributionsServices.h"
#import "ImageUtils.h"
#import "Alert.h"
#import "ContributionTableViewCell.h"

@interface SecretaryServiceViewController ()

@property (strong) NSMutableArray *contributions;

@end

@implementation SecretaryServiceViewController

@synthesize secretary, progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [secretary name];
    
    [progress startAnimating];
    
    UIImage *background = [UIImage imageNamed:@"menuBg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    [self.tableView setBackgroundView:imageView];
    
    TransactionUtil *tm = [[TransactionUtil alloc] init];
    [tm startTransaction:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.contributions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ContributionCell";
    ContributionTableViewCell *cell = (ContributionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContributionTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *contribution = [self.contributions objectAtIndex:indexPath.row];
    [cell.name setText:[contribution valueForKey:@"name"]];
    [cell.desc setText:[contribution valueForKey:@"desc"]];

    [cell.image setImage:[ImageUtils getImageFromDocument:[contribution valueForKey:@"picture"]]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.desc setNumberOfLines:0];
    [cell.desc sizeToFit];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ContributionSegue" sender:nil];
}

#pragma mark Transacton Delegate
-(void)execute{
    ContributionsServices *service = [[ContributionsServices alloc]init];
    self.contributions = [service getContributionsFromSecretary:[secretary id_remote]];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(self.contributions && ([self.contributions count] > 0)){
        [self.tableView reloadData];
        
    }else{
        [Alert warning:@"Nenhuma contribuição encontrada"];
    }
    
}

#pragma mark ContributionFormDelegate
-(void)sendMessage{
    [self.navigationController popViewControllerAnimated:YES];
    [Alert warning:@"Mesangem enviada com sucesso."];
}



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ContributionSegue"]) {
        ContributionFormViewController *formViewController = segue.destinationViewController;
        formViewController.delegate = self;
    }
}

@end
