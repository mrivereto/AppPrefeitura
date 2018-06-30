//
//  BaseService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/24/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "BaseService.h"
#import "DownloadService.h"

@implementation BaseService



-(NSDictionary *)parserJSON:(NSData *)data{
    
    if(data == nil){
        return nil;
    }
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return json;
}

-(NSString *)downloadImageFromURL:(NSString *)url andSaveInPath:(NSString *)fileName{
    DownloadService *dowload = [[DownloadService alloc]init];
    NSString *extension = [url pathExtension];
    
    NSString *fullPath = [dowload saveImage:[dowload getImageFromURL:url] withFileName:fileName ofType:extension];

    return fullPath;
}

@end
