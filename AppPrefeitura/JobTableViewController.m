//
//  JobTableViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "JobTableViewController.h"
#import "JobsDetailViewController.h"
#import "JobTableViewCell.h"
#import "TransactionUtil.h"
#import "JobService.h"
#import "Alert.h"
#import "DateUtils.h"

@interface JobTableViewController ()

@property (strong) NSMutableArray *jobs;
@property (strong) NSArray *searchResults;

@end

@implementation JobTableViewController

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
        return [self.jobs count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"JobCell";
    JobTableViewCell *cell = (JobTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobCellView" owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *job = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        job = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        job = [self.jobs objectAtIndex:indexPath.row];
    }
    [cell.cellTitle setText:[job valueForKey:@"title"]];
    
    UIImage *image = [UIImage imageNamed:@"iconJobs.png"];
    [cell.cellImage setImage:image];
    
    NSString *publicationDate = [NSString stringWithFormat:@"Publicado em: %@", [DateUtils formatDate:[job valueForKey:@"publication_date"] withFormat:DATE_PATTERN_DD_MM_YYYY]];
    
    [cell.cellPublicationDate setText:publicationDate];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"jobDetailSegue" sender:[self.jobs objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark Search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    self.searchResults = [self.jobs filteredArrayUsingPredicate:resultPredicate];
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
    JobService *service = [[JobService alloc]init];
    self.jobs = [service getJobs];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(self.jobs && ([self.jobs count] > 0)){
        [self.tableView reloadData];
        
    }else{
        [Alert warning:@"Nenhuma vaga encontrada"];
    }
    
}

#pragma mark Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"jobDetailSegue"]) {
        JobsDetailViewController *jobViewController = segue.destinationViewController;
        jobViewController.job = sender;
    }
    
}

@end
