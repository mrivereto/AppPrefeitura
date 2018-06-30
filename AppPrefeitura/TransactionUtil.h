//
//  TransactionUtil.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface TransactionUtil : NSObject{

    NSOperationQueue *queue;
}

-(void) startTransaction:(NSObject<Transaction> *)transaction;

@property(nonatomic, retain)NSObject<Transaction> *transaction;

@end
