//
//  HttpHelper.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "HttpHelper.h"

@implementation HttpHelper


-(NSData *)doGet:(NSString *)url{
    // Cria request, sem cache e com timeout de 30seg
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:(NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:240];
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = nil;
    
    // Faz a requisição de forma síncrona, que já retorna o NSData
    // Este método vai ficar travado até o servidor retornar
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

    return data;
}

@end
