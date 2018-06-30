//
//  WeatherTableViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/30/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface WeatherTableViewController : UITableViewController<Transaction>{
    NSMutableIndexSet *expandedSections;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
