//
//  TransactionUtil.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "TransactionUtil.h"

@implementation TransactionUtil

@synthesize transaction = _transaction;


-(void) startTransaction:(NSObject<Transaction> *)transaction{
    self.transaction = transaction;
    
    if(!queue){
        queue = [[NSOperationQueue alloc] init];
    }
    
    [queue cancelAllOperations];
    
    // Dispara o download em uma NSOperation
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(executeOnBackground) object:nil];
    
    [queue addOperation:operation];

}

#pragma mark - transaction
//Executa em uma nova thread
-(void)executeOnBackground{
    [self.transaction execute];
    [self performSelectorOnMainThread:@selector(executeOnUIThread) withObject:nil waitUntilDone:YES];

}

//Executa na thread principal
-(void)executeOnUIThread{
    [self.transaction updateInterface];

}

@end
