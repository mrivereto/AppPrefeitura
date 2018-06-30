//
//  BaseDB.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "BaseDB.h"
#import "AppDelegate.h"

@implementation BaseDB


+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void)save {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save %@ %@", error, [error localizedDescription]);
    }
}

+(void)deleteEntity:(NSManagedObject *)obj{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:obj];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
    }
}

+(NSMutableArray *)getAllFromEntity:(NSString *)entityName{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSMutableArray *allNews = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return allNews;
    
}

+(NSManagedObject *)getEntity:(NSString *)entityName{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *news = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    
    return news;
}

+(NSManagedObject *)getEntityFrom:(NSString *)entity andIdRemote:(NSString *)id_remote{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_remote = %@", id_remote];
    [request setPredicate:predicate];
    
    NSError *error;
    NSMutableArray *array = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    
    if (array && ([array count] == 1)) {
        return [array objectAtIndex:0];
    }
    
    return nil;
}

@end
