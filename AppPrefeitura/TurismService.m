//
//  TurismService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/29/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "TurismService.h"
#import "HttpHelper.h"
#import "TurismDB.h"

#define URL_GET_LOCATIONS @"http://www.rivereto.com.br/bisolutions/turism.json"

@interface TurismService()

    -(void)saveFromServer:(NSMutableArray *)locations;


@end

@implementation TurismService


-(NSMutableArray *)getLocations{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_LOCATIONS];
    NSMutableArray *locations = [[self parserJSON:data] objectForKey:@"locations"];
    
    if(locations && ([locations count] > 0)){
        [self saveFromServer:locations];
        
        locations = [TurismDB getAllFromEntity:@"Turism"];
        
    }else{
        locations = [TurismDB getAllFromEntity:@"Turism"];
    }
    
    return locations;
}

-(void)saveFromServer:(NSMutableArray *)locations{

    for (int index = 0; index < [locations count]; index++) {
        
        NSManagedObject *selected = [TurismDB getEntityFrom:@"Turism" andIdRemote:[[locations objectAtIndex:index] objectForKey:@"id_remote"]];
        
        if (selected) {
            [selected setValue:[[locations objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [selected setValue:[[locations objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [selected setValue:[[locations objectAtIndex:index] objectForKey:@"latitude"] forKey:@"latitude"];
            [selected setValue:[[locations objectAtIndex:index] objectForKey:@"longitude"] forKey:@"longitude"];
            
        }else{
            NSManagedObject *entity = [TurismDB getEntity:@"Turism"];
            [entity setValue:[[locations objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            [entity setValue:[[locations objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [entity setValue:[[locations objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [entity setValue:[[locations objectAtIndex:index] objectForKey:@"latitude"] forKey:@"latitude"];
            [entity setValue:[[locations objectAtIndex:index] objectForKey:@"longitude"] forKey:@"longitude"];
        
        }

        [TurismDB save];
        
    }
}

@end

