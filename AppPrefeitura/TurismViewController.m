//
//  TurismViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "TurismViewController.h"
#import "TurismService.h"


@interface TurismViewController (){
    NSMutableArray *locations;
}


@end

@implementation TurismViewController

@synthesize map;

- (void)viewDidLoad {
    [super viewDidLoad];

    TurismService *service = [[TurismService alloc]init];
    locations = [service getLocations];
}

-(void)viewWillAppear:(BOOL)animated{

    MKCoordinateRegion coordinate;
    MKPointAnnotation *pin;
    
    for (int index = 0; index < [locations count]; index++) {
        coordinate.center.latitude = [[[locations objectAtIndex:index] valueForKey:@"latitude"] doubleValue];
        coordinate.center.longitude= [[[locations objectAtIndex:index] valueForKey:@"longitude"] doubleValue];
        
        [self.map setRegion:coordinate animated:YES];
        
        pin = [[MKPointAnnotation alloc] init];
        [pin setCoordinate:coordinate.center];
        [pin setTitle:[[locations objectAtIndex:index] valueForKey:@"name"]];
        
        [self.map addAnnotation:pin];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
