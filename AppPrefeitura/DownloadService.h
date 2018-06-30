//
//  DownloadService.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadService : NSObject{


}

-(UIImage *) getImageFromURL:(NSString *)fileURL;
-(NSString *) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
-(NSString *) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension;
-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

@end
