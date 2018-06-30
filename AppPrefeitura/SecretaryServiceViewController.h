//
//  SecretaryServiceViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "Menu.h"
#import "ContributionFormViewController.h"

@interface SecretaryServiceViewController : UITableViewController<Transaction, ContributionFormViewControllerDelegate>

@property(nonatomic, strong)Menu *secretary;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
