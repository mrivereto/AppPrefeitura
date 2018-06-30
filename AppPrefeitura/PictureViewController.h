//
//  PictureViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/14/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PictureViewController;

@protocol PictureViewControllerDelegate <NSObject>

-(void)setPicture:(UIImage *)picture;

@end

@interface PictureViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, nonatomic)IBOutlet UIImageView *image;
@property(weak, nonatomic)id<PictureViewControllerDelegate> delegate;

-(IBAction)takePicture:(UIButton *)sender;
-(IBAction)galery:(UIButton *)sender;
-(IBAction)save:(UIButton *)sender;

@end
