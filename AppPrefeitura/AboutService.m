//
//  AboutService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "AboutService.h"
#import "HttpHelper.h"
#import "AboutDB.h"
#import "DateUtils.h"

#define URL_GET_ABOUT @"http://www.rivereto.com.br/bisolutions/about.json"

@interface AboutService()
-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation AboutService


-(NSDictionary *)getAbout{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_ABOUT];
    NSMutableArray *about = [[self parserJSON:data] objectForKey:@"about"];

    if(about){
        [self saveFromServer:about];

        about = [AboutDB getAllFromEntity:@"About"];

    }else{
        about = [AboutDB getAllFromEntity:@"About"];
    }

    return [about objectAtIndex:0];
}

-(void)saveFromServer:(NSMutableArray *)array{

    for (int index = 0; index < [array count]; index++) {


        NSManagedObject *selected = [AboutDB getEntityFrom:@"About" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];

        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"picture"]
                                           andSaveInPath:[NSString stringWithFormat:@"about_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];

        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [selected setValue:imagePath forKey:@"picture"];

        }else{
            NSManagedObject *entity = [AboutDB getEntity:@"About"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"desc"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];

        }

        [AboutDB save];

    }

}


@end
