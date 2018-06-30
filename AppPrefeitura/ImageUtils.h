//
//  ImageUtils.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/13/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtils : NSObject

+(UIImage *)getImageFromLocal:(NSString *)name;
+(UIImage *)getImageFromDocument:(NSString *)name;

@end
