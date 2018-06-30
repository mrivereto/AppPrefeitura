//
//  CityService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/26/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "CityService.h"
#import "HttpHelper.h"
#import "CityDB.h"
#import "DateUtils.h"

#define URL_GET_CITY @"http://www.rivereto.com.br/bisolutions/city.json"


@interface CityService()
-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation CityService


-(NSDictionary *)getCity{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_CITY];
    NSMutableArray *cities = [[self parserJSON:data] objectForKey:@"cities"];
    
    if(cities && ([cities count] > 0)){
        [self saveFromServer:cities];
        
        cities = [CityDB getAllFromEntity:@"City"];
        
    }else{
        cities = [CityDB getAllFromEntity:@"City"];
    }
    
    return [cities objectAtIndex:0];
}

-(void)saveFromServer:(NSMutableArray *)cities{
    
    for (int index = 0; index < [cities count]; index++){
        
        NSManagedObject *selected = [CityDB getEntityFrom:@"City" andIdRemote:[[cities objectAtIndex:index] objectForKey:@"id_remote"]];
        
        
        if (selected) {
            [selected setValue:[[cities objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            
        }else{
            NSManagedObject *entity = [CityDB getEntity:@"City"];
            [entity setValue:[[cities objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [entity setValue:[[cities objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [CityDB save];
        
    }
    
}


@end

