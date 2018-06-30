//
//  PhoneTableViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface PhoneTableViewController : UITableViewController<Transaction>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
