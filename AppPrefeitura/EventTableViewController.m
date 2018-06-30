//
//  EventTableViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "EventTableViewController.h"
#import "EventDetailViewController.h"
#import "EventTableViewCell.h"
#import "TransactionUtil.h"
#import "EventService.h"
#import "Alert.h"
#import "DateUtils.h"

@interface EventTableViewController ()

@property (strong) NSMutableArray *events;
@property (strong) NSArray *searchResults;

@end

@implementation EventTableViewController
@synthesize progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        return [self.events count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"EventCell";
    EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EventCellView" owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *event = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        event = [self.events objectAtIndex:indexPath.row];
    }
    [cell.cellTitle setText:[event valueForKey:@"title"]];
    [cell.cellLocation setText:[event valueForKey:@"location"]];
    
    NSString *startDate = [DateUtils formatDate:[event valueForKey:@"start_date"] withFormat:DATE_PATTERN_DD_MM_YYYY];
    NSString *endDate = [DateUtils formatDate:[event valueForKey:@"end_date"] withFormat:DATE_PATTERN_DD_MM_YYYY];
    
    [cell.cellMonth setText:[DateUtils getVerboseMonthFromDate:[event valueForKey:@"start_date"]]];
    [cell.cellDay setText:[DateUtils formatDate:[event valueForKey:@"start_date"] withFormat:DATE_PATTERN_DD]];
    [cell.cellPeriod setText:[NSString stringWithFormat:@"%@ até %@", startDate, endDate]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"eventDetailSegue" sender:[self.events objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
}

#pragma mark Search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    self.searchResults = [self.events filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark Transacton Delegate
-(void)execute{
    EventService *service = [[EventService alloc]init];
    self.events = [service getEvents];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(self.events && ([self.events count] > 0)){
        [self.tableView reloadData];
        
    }else{
        [Alert warning:@"Nenhum evento encontrado"];
    }
    
}

#pragma mark Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"eventDetailSegue"]) {
        EventDetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.event = sender;
    }
    
}

@end
