//
//  BaseService.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/24/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

-(NSDictionary *)parserJSON:(NSData *)data;
-(NSString *)downloadImageFromURL:(NSString *)url andSaveInPath:(NSString *)fileName;

@end
