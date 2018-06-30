//
//  JobsDetailViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobsDetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSDictionary *job;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
