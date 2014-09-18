//
//  TWWebService.m
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWWebService.h"
#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"
#import "factModel.h"
#import "TopModel.h"
@interface TWWebService(){
    BOOL _isWaiting4Tap;
    NSMutableData *_webData;
}

@end

@implementation TWWebService

- (TopModel *)loadJSONData:(int)tag{
    _isWaiting4Tap = YES;
    _webData = [NSMutableData data];
    
    NSURL *url = [NSURL URLWithString:@"http://thoughtworks-ios.herokuapp.com/facts.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    if (tag == 0) {
        [self getSyncData:request];
    }
    else{
        [self getAsyncData:request];
    }
    // NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    deserializer.options |=kJSONDeserializationOptions_AllowFragments;
    NSError *error;
    NSMutableDictionary *jsonData = [deserializer deserialize:_webData error:&error];
    
    TopModel *top = [[TopModel alloc] init];
    top.title = [jsonData objectForKey:@"title"];
    top.factArray = [NSMutableArray array];
    id arrayRows = [jsonData objectForKey:@"rows"];
    for (NSMutableDictionary *dict in arrayRows) {
        factModel *sec = [[factModel alloc] init];
        sec.title = [dict objectForKey:@"title"];
        sec.description = [dict objectForKey:@"description"];
        sec.imageHref = [dict objectForKey:@"imageHref"];
        if ((NSNull *)sec.imageHref != [NSNull null] && (NSNull *)sec.description != [NSNull null] && (NSNull *)sec.imageHref != [NSNull null]) {
            [top.factArray addObject:sec];
        }
    }
    return top;
}

- (void)getSyncData:(NSURLRequest *)request{
    
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil   error:&error];
    if (data != nil) {
        _webData = [NSData dataWithData:data];
    }
    else {
        _webData = nil;
    }
}


- (void)getAsyncData:(NSURLRequest *)request{
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if(error){
            NSLog(@"%@",error);
        }
        else{
            _webData=[NSData dataWithData:data];
        }
        _isWaiting4Tap=NO;
    }];
    
    while (_isWaiting4Tap) {
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
}

@end
