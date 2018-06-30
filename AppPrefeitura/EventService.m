//
//  EventService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "EventService.h"
#import "HttpHelper.h"
#import "EventDB.h"
#import "DateUtils.h"

#define URL_GET_EVENT @"http://www.rivereto.com.br/bisolutions/events.json"

@interface EventService()
-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation EventService


-(NSMutableArray *)getEvents{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_EVENT];
    NSMutableArray *events = [[self parserJSON:data] objectForKey:@"events"];
    
    if(events && ([events count] > 0)){
        [self saveFromServer:events];
        
        events = [EventDB getAllFromEntity:@"Event"];
        
    }else{
        events = [EventDB getAllFromEntity:@"Event"];
    }
    
    return events;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        
        NSManagedObject *selected = [EventDB getEntityFrom:@"Event" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"img_thumb"]
                                           andSaveInPath:[NSString stringWithFormat:@"event_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"location"] forKey:@"location"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [selected setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"start_date"]] forKey:@"start_date"];
            [selected setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"end_date"]] forKey:@"end_date"];
            [selected setValue:imagePath forKey:@"picture"];
            
        }else{
            NSManagedObject *entity = [EventDB getEntity:@"Event"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"location"] forKey:@"location"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [entity setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"start_date"]] forKey:@"start_date"];
            [entity setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"end_date"]] forKey:@"end_date"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [EventDB save];
        
    }
    
}


@end
