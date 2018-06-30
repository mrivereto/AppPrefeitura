//
//  HistoryService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "HistoryService.h"
#import "HttpHelper.h"
#import "HistoryDB.h"
#import "DateUtils.h"

#define URL_GET_HISTORY @"http://www.rivereto.com.br/bisolutions/history.json"

@interface HistoryService()
-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation HistoryService


-(NSDictionary *)getHistory{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_HISTORY];
    NSMutableArray *history = [[self parserJSON:data] objectForKey:@"history"];

    if(history){
        [self saveFromServer:history];

        history = [HistoryDB getAllFromEntity:@"History"];

    }else{
        history = [HistoryDB getAllFromEntity:@"History"];
    }

    return [history objectAtIndex:0];
}

-(void)saveFromServer:(NSMutableArray *)array{

    for (int index = 0; index < [array count]; index++) {


        NSManagedObject *selected = [HistoryDB getEntityFrom:@"History" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];

        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"picture"]
                                           andSaveInPath:[NSString stringWithFormat:@"history_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];

        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [selected setValue:imagePath forKey:@"picture"];

        }else{
            NSManagedObject *entity = [HistoryDB getEntity:@"History"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];

        }

        [HistoryDB save];

    }

}


@end
