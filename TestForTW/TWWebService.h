//
//  TWWebService.h
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TopModel;

@interface TWWebService : NSObject
-(TopModel *)loadJSONData:(int)tag;
@end
