//
//  EventDetailViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "EventDetailViewController.h"
#import "DateUtils.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

@synthesize event, webView, progress;

- (void)viewDidLoad {
    [super viewDidLoad];

    [progress startAnimating];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *imagePath = [documentsDirectory stringByAppendingPathComponent:
                            [NSString stringWithFormat: [self.event valueForKey:@"picture"]]];
    
    
    NSString *imageMediaPath = [[NSBundle mainBundle] pathForResource:@"socialMedia" ofType:@"png"];
    
    NSError* error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource: @"event" ofType: @"html"];
    NSString *html = [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error: &error];
    
    [self.webView loadHTMLString:[NSString stringWithFormat:html,
                                  imagePath,
                                  [self.event valueForKey:@"title"],
                                  [self.event valueForKey:@"location"],
                                  [DateUtils formatDate:[self.event valueForKey:@"start_date"] withFormat:DATE_PATTERN_DD_MM_YYYY],
                                  [DateUtils formatDate:[self.event valueForKey:@"end_date"] withFormat:DATE_PATTERN_DD_MM_YYYY],
                                  [self.event valueForKey:@"desc"],
                                  imageMediaPath] baseURL:nil];
    
    [self.webView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
