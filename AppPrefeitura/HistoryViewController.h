//
//  HistoryViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"

@interface HistoryViewController : UIViewController<UIWebViewDelegate, Transaction>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
