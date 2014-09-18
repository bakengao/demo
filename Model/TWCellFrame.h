//
//  TWCellFrame.h
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class factModel;
@interface TWCellFrame : NSObject
@property (nonatomic, strong) factModel *fact;
@property (nonatomic, assign, readonly)CGFloat cellHeight;
@property (nonatomic, assign, readonly)CGRect imageFrame;
@property (nonatomic, assign, readonly)CGRect titleFrame;
@property (nonatomic, assign, readonly)CGRect descriptionFrame;
@end
