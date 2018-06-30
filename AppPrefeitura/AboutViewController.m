//
//  AboutViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutService.h"
#import "TransactionUtil.h"

@interface AboutViewController ()

@property (strong) NSDictionary *about;

@end

@implementation AboutViewController

@synthesize progress, webView;



- (void)viewDidLoad {
    [super viewDidLoad];

    [progress startAnimating];
    
    [self.webView setDelegate:self];
    
    TransactionUtil *tm = [[TransactionUtil alloc] init];
    [tm startTransaction:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progress stopAnimating];
}

#pragma mark Transaction Delegate
-(void)execute{
    AboutService *service = [[AboutService alloc] init];
    self.about = [service getAbout];
}

-(void)updateInterface{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *imagePath = [documentsDirectory stringByAppendingPathComponent:
                            [NSString stringWithFormat: [self.about valueForKey:@"picture"]]];
    
    
    NSError* error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource: @"about" ofType: @"html"];
    NSString *html = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
    
    [self.webView loadHTMLString:[NSString stringWithFormat:html,
                                  imagePath,
                                  [self.about valueForKey:@"desc"]] baseURL:nil];
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
