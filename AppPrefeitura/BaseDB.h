//
//  BaseDB.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseDB : NSObject{

}

+(NSMutableArray *)getAllFromEntity:(NSString *)entityName;
+(NSManagedObject *)getEntity:(NSString *)entityName;
+(NSManagedObject *)getEntityFrom:(NSString *)entity andIdRemote:(NSString *)id_remote;
+(NSManagedObjectContext *)managedObjectContext;
+(void)deleteEntity:(NSManagedObject *)obj;
+(void)save;

@end
