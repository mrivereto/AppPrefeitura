//
//  JobService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "JobService.h"
#import "HttpHelper.h"
#import "JobDB.h"
#import "DateUtils.h"

#define URL_GET_JOB @"http://www.rivereto.com.br/bisolutions/jobs.json"


@interface JobService()
-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation JobService


-(NSMutableArray *)getJobs{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_JOB];
    NSMutableArray *jobs = [[self parserJSON:data] objectForKey:@"jobs"];
    
    if(jobs && ([jobs count] > 0)){
        [self saveFromServer:jobs];
        
        jobs = [JobDB getAllFromEntity:@"Job"];
        
    }else{
        jobs = [JobDB getAllFromEntity:@"Job"];
    }
    
    return jobs;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        NSManagedObject *selected = [JobDB getEntityFrom:@"Job" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"img_thumb"]
                                           andSaveInPath:[NSString stringWithFormat:@"job_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [selected setValue:imagePath forKey:@"picture"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [selected setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"publication_date"]] forKey:@"publication_date"];
            
        }else{
            NSManagedObject *entity = [JobDB getEntity:@"Job"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [entity setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"publication_date"]] forKey:@"publication_date"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [JobDB save];
        
    }
    
}


@end
