//
//  Transaction.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Transaction <NSObject>

// Este método vai executar em uma Thread separada
-(void) execute;
// Este método vai executar na thread principal - UI Thread
-(void) updateInterface;

@end
