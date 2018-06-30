//
//  NewsTableViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsTableViewController.h"
#import "NewsDetailViewController.h"
#import "TransactionUtil.h"
#import "NewsService.h"
#import "Alert.h"
#import "DateUtils.h"

@interface NewsTableViewController ()

@property (strong) NSMutableArray *listNews;
@property (strong) NSArray *searchResults;

@end

@implementation NewsTableViewController

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
        return [self.listNews count];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    static NSString *CellIdentifier = @"NewsCell";
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCellView" owner:self options:nil] objectAtIndex:0];
    }
    
    NSDictionary *news = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        news = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        news = [self.listNews objectAtIndex:indexPath.row];
    }
    
    [cell.cellTitle setText:[news valueForKey:@"title"]];
    [cell.cellResume setText:[news valueForKey:@"subtitle"]];
    [cell.cellMonth setText:[DateUtils getVerboseMonthFromDate:[news valueForKey:@"publication_date"]]];
    [cell.cellDay setText:[DateUtils formatDate:[news valueForKey:@"publication_date"] withFormat:DATE_PATTERN_DD]];
    [cell.cellResume setNumberOfLines:0];
    [cell.cellResume sizeToFit];

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"newsDetailSegue" sender:[self.listNews objectAtIndex:indexPath.row]];
}

#pragma mark Search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    self.searchResults = [self.listNews filteredArrayUsingPredicate:resultPredicate];
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
    NewsService *service = [[NewsService alloc]init];
    self.listNews = [service getNews];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(self.listNews && ([self.listNews count] > 0)){
        [self.tableView reloadData];
    
    }else{
        [Alert warning:@"Nenhuma notícia encontrada"];
    }

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newsDetailSegue"]) {
        NewsDetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.news = sender;
    }

}

@end