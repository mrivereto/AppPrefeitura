//
//  WeatherService.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/30/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "WeatherService.h"
#import "HttpHelper.h"
#import "WeatherDB.h"


#define URL_GET_WEATHER @"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json&units=metric&cnt=7&lang=pt&APPID=eaf4f664bfba2bdb54ca496056ab5c1f"

#define URL_GET_CITY @"http://www.rivereto.com.br/bisolutions/weather.json"

@interface WeatherService()
-(void)saveFromServer:(NSMutableArray *)array;

@end


@implementation WeatherService


-(NSMutableArray *)getWeathers{
    HttpHelper *http = [[HttpHelper alloc] init];
    NSData *data = [http doGet:URL_GET_CITY];
    NSMutableArray *weathers = [[self parserJSON:data] objectForKey:@"weather"];
    
    if(weathers && ([weathers count] > 0)){
        [self saveFromServer:weathers];
        
        weathers = [WeatherDB getAllFromEntity:@"Weather"];
        
    }else{
        weathers = [WeatherDB getAllFromEntity:@"Weather"];
    }
    
    if (weathers) {
        data = [http doGet:[NSString stringWithFormat:URL_GET_WEATHER, [[weathers objectAtIndex:0] valueForKey:@"city"]]];

        weathers = [[self parserJSON:data] objectForKey:@"list"];
    }


    return weathers;
}

-(void)saveFromServer:(NSMutableArray *)array{
    
    for (int index = 0; index < [array count]; index++) {
        
        
        NSManagedObject *selected = [WeatherDB getEntityFrom:@"Weather" andIdRemote:[[array objectAtIndex:index] objectForKey:@"id_remote"]];

        if (selected) {
            [selected setValue:[[array objectAtIndex:index] objectForKey:@"city"] forKey:@"city"];
            
        }else{
            NSManagedObject *entity = [WeatherDB getEntity:@"Weather"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"city"] forKey:@"city"];
            [entity setValue:[[array objectAtIndex:index] objectForKey:@"id_remote"] forKey:@"id_remote"];
            
        }
        
        [WeatherDB save];
        
    }
}
@end
