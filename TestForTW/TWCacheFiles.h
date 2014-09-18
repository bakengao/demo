//
//  TWCacheFiles.h
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWCacheFiles : NSObject
+ (TWCacheFiles *)sharedHelper;

-(UIImage *)getImageFromDocuments:(NSURL *)url;
-(void)writeDataToFileByURL:(NSURL *)url imageData:(NSData *)imageData;

-(UIImage*)getImageFromCache:(NSURL*)url;
-(void)cacheImage:(UIImage*)image forKey:(NSURL*)url;
@end
