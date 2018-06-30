//
//  NewsDetailViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "DateUtils.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

@synthesize news, webView, progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [progress startAnimating];

    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *imagePath = [documentsDirectory stringByAppendingPathComponent:
                            [NSString stringWithFormat: [self.news valueForKey:@"picture"]]];
    
    
    NSString *imageMediaPath = [[NSBundle mainBundle] pathForResource:@"socialMedia" ofType:@"png"];

    NSError* error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource: @"news" ofType: @"html"];
    NSString *html = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
    
    [self.webView loadHTMLString:[NSString stringWithFormat:html,
                                  imagePath,
                                  [self.news valueForKey:@"title"],
                                  [self.news valueForKey:@"content"],
                                  imageMediaPath] baseURL:nil];
    
    [self.webView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [progress stopAnimating];
    
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
