//
//  TWAsyncDownoadImage.m
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWAsyncDownoadImage.h"
#import "TWCacheFiles.h"

@implementation TWAsyncDownoadImage


- (void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock{
    TWCacheFiles *files =[[TWCacheFiles alloc] init];
    UIImage *image = [files getImageFromCache:url];
    if (image) {
        if (completeBlock) {
            completeBlock(image,nil,url);
        }
    }
    image = [files getImageFromDocuments:url];
    if (image) {
        if (completeBlock) {
            completeBlock(image,nil,url);
        }
    }
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSError * error;
        NSData *imgData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                [files cacheImage:image forKey:url];
                [files writeDataToFileByURL:url imageData:imgData];
            }
            if (completeBlock) {
                completeBlock(image,error,url);
            }
        });
    });
}
@end
