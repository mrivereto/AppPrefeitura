//
//  ContributionsServices.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "ContributionsServices.h"
#import "HttpHelper.h"
#import "ContributionsDB.h"

#define URL_GET_CONTRIBUTIONS @"http://www.rivereto.com.br/bisolutions/contributions.json"

@implementation ContributionsServices


-(NSMutableArray *)getContributionsFromSecretary:(long)id_secretary{

    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_CONTRIBUTIONS];
    NSMutableArray *contributions = [[self parserJSON:data] objectForKey:@"contributions"];
    
    if(contributions && ([contributions count] > 0)){
        [self saveFromServer:contributions];
        
        contributions = [ContributionsDB getAllFromEntity:@"Contribution"];
        
    }else{
        contributions = [ContributionsDB getAllFromEntity:@"Contribution"];
    }
    
    
    ContributionsDB *db = [[ContributionsDB alloc] init];
    contributions = [db getContributionFromSecretary:id_secretary];
    
    return contributions;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        NSManagedObject *selected = [ContributionsDB getEntityFrom:@"Contribution" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"img_thumb"]
                                           andSaveInPath:[NSString stringWithFormat:@"contribution_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"id_secretary"] forKey:@"id_secretary"];
            [selected setValue:imagePath forKey:@"picture"];
            
        }else{
            NSManagedObject *entity = [ContributionsDB getEntity:@"Contribution"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_secretary"] forKey:@"id_secretary"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            [entity setValue:imagePath forKey:@"picture"];
            
        }
        
        [ContributionsDB save];
        
    }
    
}

@end
