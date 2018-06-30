//
//  ContributionsDB.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "BaseDB.h"

@interface ContributionsDB : BaseDB

-(NSMutableArray *)getContributionFromSecretary:(long)id_secretary;

@end
