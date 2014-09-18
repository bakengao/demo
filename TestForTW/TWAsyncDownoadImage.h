//
//  TWAsyncDownoadImage.h
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWAsyncDownoadImage : NSObject

typedef void(^ImageDownloadedBlock)(UIImage *image, NSError *error, NSURL *imageURL);
//@property (nonatomic,copy)void(^ImageDownloadedBlock)(UIImage *image, NSError *error, NSURL *imageURL);
- (void)downloadImageWithURL:(NSURL *)url complete:(ImageDownloadedBlock)completeBlock;

@end
