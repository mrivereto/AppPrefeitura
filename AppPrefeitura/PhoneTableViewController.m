//
//  PhoneTableViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "PhoneTableViewController.h"
#import "PhoneTableViewCell.h"
#import "TransactionUtil.h"
#import "PhoneService.h"
#import "Alert.h"
#import "DateUtils.h"

@interface PhoneTableViewController ()

@property (strong) NSMutableArray *phones;
@property (strong) NSArray *searchResults;

@end

@implementation PhoneTableViewController

@synthesize progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *background = [UIImage imageNamed:@"menuBg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    [self.tableView setBackgroundView:imageView];
    
    [progress startAnimating];
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.phones count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = (PhoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *phone = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        phone = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        phone = [self.phones objectAtIndex:indexPath.row];
    }
    [cell.cellTitle setText:[phone valueForKey:@"desc"]];
    [cell.cellPhone setText:[phone valueForKey:@"phone"]];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *phone = [self.phones objectAtIndex:indexPath.row];

    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:[[phone valueForKey:@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

#pragma mark Search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"desc contains[c] %@", searchText];
    self.searchResults = [self.phones filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    UIImage *background = [UIImage imageNamed:@"menuBg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    [self.searchDisplayController.searchResultsTableView setBackgroundView:imageView];
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark Transacton Delegate
-(void)execute{
    PhoneService *service = [[PhoneService alloc]init];
    self.phones = [service getPhones];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(self.phones && ([self.phones count] > 0)){
        [self.tableView reloadData];
        
    }else{
        [Alert warning:@"Nenhum telefone encontrado"];
    }
    
}

@end
