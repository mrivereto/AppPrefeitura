//
//  ImageUtils.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/13/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils


+(UIImage *)getImageFromLocal:(NSString *)name{
    return [UIImage imageNamed:name];
}

+(UIImage *)getImageFromDocument:(NSString *)name{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *imagePath = [documentsDirectory stringByAppendingPathComponent:name];
    
    NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:imagePath]];
    
    return [UIImage imageWithData:imgData];
}

@end
