//
//  SecretaryService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "SecretaryService.h"
#import "SecretaryDB.h"
#import "HttpHelper.h"

#define URL_GET_SECRETARIES @"http://www.rivereto.com.br/bisolutions/secretary.json"

@interface SecretaryService()

-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation SecretaryService

-(NSMutableArray *)getSecretaries{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_SECRETARIES];
    NSMutableArray *secretaries = [[self parserJSON:data] objectForKey:@"secretaries"];
    
    if(secretaries && ([secretaries count] > 0)){
        [self saveFromServer:secretaries];
        
        secretaries = [SecretaryDB getAllFromEntity:@"Secretary"];
        
    }else{
        secretaries = [SecretaryDB getAllFromEntity:@"Secretary"];
    }
    
    return secretaries;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        NSManagedObject *selected = [SecretaryDB getEntityFrom:@"Secretary" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"img_thumb"]
                                           andSaveInPath:[NSString stringWithFormat:@"secretary_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [selected setValue:imagePath forKey:@"picture"];
            
        }else{
            NSManagedObject *entity = [SecretaryDB getEntity:@"Secretary"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"name"] forKey:@"name"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"desc"] forKey:@"desc"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [SecretaryDB save];
        
    }
    
}

@end
