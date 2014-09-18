//
//  UIImageView+Async.h
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Async)

@property (nonatomic, strong)NSString *tag;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
