//
//  UIImageView+Async.m
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "UIImageView+Async.h"
#import "TWAsyncDownoadImage.h"

@implementation UIImageView (Async)
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    self.tag = [url absoluteString];
    self.image = placeholder;
    
    if (url) {
        TWAsyncDownoadImage *async = [[TWAsyncDownoadImage alloc] init];
        [async downloadImageWithURL:url complete:^(UIImage *image, NSError *error, NSURL *imageURL) {
            if (image && [self.tag isEqualToString:[imageURL absoluteString]]) {
                self.image = image;
            }else{
                NSLog(@"download error :%@", error);
            }
        }];
    }
}
@end
