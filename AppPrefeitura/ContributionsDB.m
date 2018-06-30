//
//  ContributionsDB.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "ContributionsDB.h"

@implementation ContributionsDB


-(NSMutableArray *)getContributionFromSecretary:(long)id_secretary{
    NSManagedObjectContext *context = [BaseDB managedObjectContext];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Contribution" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_secretary = %@", id_secretary];
    [request setPredicate:predicate];
    
    NSError *error;
    NSMutableArray *array = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    
    return array;

}

@end
