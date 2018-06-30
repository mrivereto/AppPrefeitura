//
//  MenuService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/23/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "MenuService.h"
#import "SecretaryService.h"
#import "ImageUtils.h"
#import "Menu.h"

@interface MenuService()

+(Menu *)buildMenu:(NSString *)name andImage:(UIImage *)image andId:(long)id_remote andDesc:(NSString *)desc;

@end


@implementation MenuService


+(NSMutableArray*)getMenu{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [array addObject:[self buildMenu:@"news" andImage:[ImageUtils getImageFromLocal:@"iconNews.png"] andId:0 andDesc:@"Notícias"]];
    [array addObject:[self buildMenu:@"events" andImage:[ImageUtils getImageFromLocal:@"iconEvent.png"] andId:0 andDesc:@"Eventos"]];
    [array addObject:[self buildMenu:@"jobs" andImage:[ImageUtils getImageFromLocal:@"iconJobs.png"] andId:0 andDesc:@"Empregos"]];
    [array addObject:[self buildMenu:@"phones" andImage:[ImageUtils getImageFromLocal:@"iconPhones.png"] andId:0 andDesc:@"Telefones Úteis"]];
    [array addObject:[self buildMenu:@"weather" andImage:[ImageUtils getImageFromLocal:@"iconWeather.png"] andId:0 andDesc:@"Clima"]];
    [array addObject:[self buildMenu:@"turism" andImage:[ImageUtils getImageFromLocal:@"iconTurism.png"] andId:0 andDesc:@"Turismo"]];
    [array addObject:[self buildMenu:@"history" andImage:[ImageUtils getImageFromLocal:@"iconHistory.png"] andId:0 andDesc:@"Histórico"]];
    [array addObject:[self buildMenu:@"about" andImage:[ImageUtils getImageFromLocal:@"iconAbout.png"] andId:0 andDesc:@"Sobre"]];
    
    SecretaryService *service = [[SecretaryService alloc] init];
    NSMutableArray *secretaries = [service getSecretaries];
    
    if (secretaries) {

        for (int index = 0; index < [secretaries count]; index++) {
            NSDictionary *secretary = [secretaries objectAtIndex:index];         
            
            [array addObject:[self buildMenu:[secretary valueForKey:@"name"] andImage:[ImageUtils getImageFromDocument:[secretary valueForKey:@"picture"]] andId:[secretary valueForKey:@"id_remote"] andDesc:[secretary valueForKey:@"name"]]];
        }
    }


    return array;
}


+(Menu *)buildMenu:(NSString *)name andImage:(UIImage *)image andId:(long)id_remote andDesc:(NSString *)desc{
    Menu *menu = [[Menu alloc] init];
    menu.id_remote = id_remote;
    menu.name = name;
    menu.image = image;
    menu.desc = desc;
    
    return menu;
}

@end
