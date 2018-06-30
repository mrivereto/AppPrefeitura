//
//  ContributionsServices.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "BaseService.h"

@interface ContributionsServices : BaseService


-(NSMutableArray *)getContributionsFromSecretary:(long)id_secretary;

@end
