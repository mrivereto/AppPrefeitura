//
//  Menu.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Menu : NSObject

@property(nonatomic, assign)long id_remote;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)UIImage *image;

@end
