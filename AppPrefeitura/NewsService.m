//
//  NewsService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "NewsService.h"
#import "HttpHelper.h"
#import "NewsDB.h"
#import "DateUtils.h"

#define URL_GET_NEWS @"http://www.rivereto.com.br/bisolutions/news.json"

@interface NewsService()

-(void)saveFromServer:(NSMutableArray *)array;

@end

@implementation NewsService



-(NSMutableArray *)getNews{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_NEWS];
    NSMutableArray *listNews = [[self parserJSON:data] objectForKey:@"news"];
    
    if(listNews && ([listNews count] > 0)){
        [self saveFromServer:listNews];
        
        listNews = [NewsDB getAllFromEntity:@"News"];
    
    }else{
        listNews = [NewsDB getAllFromEntity:@"News"];
    }

    return listNews;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        NSManagedObject *selected = [NewsDB getEntityFrom:@"News" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];
        
        NSString *imagePath = [self downloadImageFromURL:[[array objectAtIndex:index] objectForKey:@"img_thumb"]
                                           andSaveInPath:[NSString stringWithFormat:@"news_img_%@", [[array objectAtIndex:index] objectForKey:@"id_remote"]]];
        
        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"subtitle"] forKey:@"subtitle"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"resume"] forKey:@"resume"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"content"];
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"author"] forKey:@"author"];
            [selected setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"publication_date"]] forKey:@"publication_date"];
            [selected setValue:imagePath forKey:@"picture"];
            
        }else{
            NSManagedObject *entity = [NewsDB getEntity:@"News"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"title"] forKey:@"title"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"subtitle"] forKey:@"subtitle"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"resume"] forKey:@"resume"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"content"] forKey:@"content"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"author"] forKey:@"author"];
            [entity setValue:[DateUtils convetToDate:[[array objectAtIndex:index] objectForKey:@"publication_date"]] forKey:@"publication_date"];
            [entity setValue:imagePath forKey:@"picture"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [NewsDB save];
        
    }

}

@end
