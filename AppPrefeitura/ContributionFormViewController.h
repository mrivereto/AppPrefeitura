//
//  ContributionFormViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/14/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureViewController.h"


@class ContributionFormViewController;

@protocol ContributionFormViewControllerDelegate <NSObject>

-(void)sendMessage;

@end


@interface ContributionFormViewController : UIViewController<PictureViewControllerDelegate, UITextViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *btnPicture;
@property (strong, nonatomic) IBOutlet UIButton *btnVideo;
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic) IBOutlet UIImageView *selectedImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

-(IBAction)send:(UIButton *)sender;
-(IBAction)hideKeyboard:(id)sender;

@property(weak, nonatomic)id<ContributionFormViewControllerDelegate>delegate;

@end
