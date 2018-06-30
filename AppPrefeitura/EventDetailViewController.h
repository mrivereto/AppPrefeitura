//
//  EventDetailViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSDictionary *event;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
