//
//  HttpHelper.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject{

}

-(NSData *) doGet:(NSString *)url;

@end
