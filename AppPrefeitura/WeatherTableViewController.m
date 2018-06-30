//
//  WeatherTableViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/30/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "WeatherService.h"
#import "WeatherTableViewCell.h"
#import "WeatherDetailTableViewCell.h"
#import "TransactionUtil.h"
#import "DateUtils.h"
#import "Alert.h"


@interface WeatherTableViewController (){

    NSMutableArray *weathers;
    BOOL firstLoad;

}

- (void)tableView:(UITableView *)tableView expandCollapseCell:(NSIndexPath *)indexPath;
@end


@implementation WeatherTableViewController

@synthesize progress;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *background = [UIImage imageNamed:@"menuBg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    [self.tableView setBackgroundView:imageView];
    
    if (!expandedSections)
    {
        firstLoad = TRUE;
        expandedSections = [[NSMutableIndexSet alloc] init];
    }

    [progress startAnimating];

    TransactionUtil *tm = [[TransactionUtil alloc] init];
    [tm startTransaction:self];

}

- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{

    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [weathers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            return 2; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *weather = [weathers objectAtIndex:indexPath.section];
    NSDictionary *temp = [weather objectForKey:@"temp"];
    NSDictionary *detail = [[weather objectForKey:@"weather"] objectAtIndex:0];
    
    UIImage *image = [UIImage imageNamed:[detail objectForKey:@"icon"]];
    
    // Configure the cell...
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        
        if (!indexPath.row)
        {
            
            static NSString *CellHeaderIdentifier = @"WeatherCell";
            WeatherTableViewCell *cellHeader = (WeatherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellHeaderIdentifier];
            
            if(cellHeader == nil){
                cellHeader = [[[NSBundle mainBundle] loadNibNamed:@"WeatherTableViewCell" owner:self options:nil] objectAtIndex:0];
            }
            
            NSDate *weatherDate = [DateUtils getDateFrom:[[weather objectForKey:@"dt"]longValue]];
       
            [cellHeader.weekDay setText:[DateUtils getDayOfWeek:weatherDate]];
            [cellHeader.date setText:[DateUtils formatDate:weatherDate withFormat:DATE_PATTERN_DD_MM_YYYY]];
            [cellHeader.temperature setText:[NSString stringWithFormat:@"%.0fº",[[temp objectForKey:@"min"]doubleValue]]];
            
            [cellHeader.image setImage:image];
            
            cellHeader.backgroundColor = [UIColor clearColor];

            return cellHeader;
        }
        else
        {
            
            static NSString *CellHeaderIdentifier = @"WeatherDetailCell";
            WeatherDetailTableViewCell *cellDetail = (WeatherDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellHeaderIdentifier];
            
            if(cellDetail == nil){
                cellDetail = [[[NSBundle mainBundle] loadNibNamed:@"WeatherDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
            }
            
            [cellDetail.desc setText:[detail objectForKey:@"description"]];
            [cellDetail.temperature setText:[NSString stringWithFormat:@"%.0fº",[[temp objectForKey:@"min"]doubleValue]]];
            [cellDetail.image setImage:image];
            
            cellDetail.backgroundColor = [UIColor clearColor];
            
            return cellDetail;
        }
    }

    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (indexPath.row)
        {
            
            return 201;
        }

    }
    return 31;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView expandCollapseCell:indexPath];
}


#pragma mark Private methods
- (void)tableView:(UITableView *)tableView expandCollapseCell:(NSIndexPath *)indexPath{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
            }
        }
    }
}


#pragma mark Transacton Delegate
-(void)execute{
    WeatherService *service = [[WeatherService alloc]init];
    weathers = [service getWeathers];
}

-(void)updateInterface{
    [progress stopAnimating];
    
    if(weathers && ([weathers count] > 0)){
        NSDate *weatherDate;
        NSString *stringDate;
        NSString *dateNow = [DateUtils formatDate:[[NSDate alloc] init] withFormat:DATE_PATTERN_DD_MM_YYYY];

        [self.tableView reloadData];
        
        for (int index = 0; index < [weathers count]; index++) {
            weatherDate = [DateUtils getDateFrom:[[[weathers objectAtIndex:index] objectForKey:@"dt"]longValue]];
            stringDate = [DateUtils formatDate:weatherDate withFormat:DATE_PATTERN_DD_MM_YYYY];
            
            
            if([stringDate isEqualToString:dateNow]){
                [self tableView:self.tableView expandCollapseCell:[NSIndexPath indexPathForRow:0 inSection:index]];
            }

        }


        
    }else{
        [Alert warning:@"Verifique a sua conexão de dados"];
    }
    
}

@end
