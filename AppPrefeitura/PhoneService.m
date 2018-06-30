//
//  PhoneService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "PhoneService.h"
#import "HttpHelper.h"
#import "PhoneDB.h"
#import "DateUtils.h"

#define URL_GET_PHONE @"http://www.rivereto.com.br/bisolutions/phones.json"


@implementation PhoneService


-(NSMutableArray *)getPhones{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_PHONE];
    NSMutableArray *phones = [[self parserJSON:data] objectForKey:@"phones"];
    
    if(phones && ([phones count] > 0)){
        [self saveFromServer:phones];
        
    }
    
    phones = [PhoneDB getAllFromEntity:@"Phone"];

    
    return phones;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        NSManagedObject *selected = [PhoneDB getEntityFrom:@"Phone" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"phone"] forKey:@"phone"];
            
        }else{
            NSManagedObject *entity = [PhoneDB getEntity:@"Phone"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"phone"] forKey:@"phone"];
            
        }
        
        [PhoneDB save];
        
    }
    
}



@end
