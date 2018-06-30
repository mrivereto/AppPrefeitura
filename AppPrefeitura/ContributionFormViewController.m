//
//  ContributionFormViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/14/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "ContributionFormViewController.h"
#import "PictureViewController.h"

@interface ContributionFormViewController()

@property (weak, nonatomic) UITextView *activeField;


@end

@implementation ContributionFormViewController

@synthesize btnPicture, btnVideo, text, delegate, selectedImage, scroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PictureView
-(void)setPicture:(UIImage *)picture{

    if(picture){
        self.selectedImage.image = picture;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TextView Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeField = textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.activeField = nil;
}


#pragma mark private methods
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scroll scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
}


#pragma mark Actions
- (IBAction)hideKeyboard:(id)sender {
    [self.text endEditing:YES];
}

-(IBAction)send:(UIButton *)sender{
    [self.delegate sendMessage];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PictureViewController *pictureViewController = segue.destinationViewController;
    pictureViewController.delegate = self;
}

@end
