//
//  MenuService.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseService.h"

@interface MenuService : BaseService

+(NSMutableArray*)getMenu;

@end
