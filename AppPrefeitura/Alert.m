//
//  Alert.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "Alert.h"


@implementation Alert


+(void)warning:(NSString *)msg{
    
    UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Alerta" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [warning show];
    
}

@end
