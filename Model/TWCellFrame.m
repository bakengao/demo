//
//  TWCellFrame.m
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWCellFrame.h"
#import "factModel.h"

@implementation TWCellFrame

-(void)setFact:(factModel *)fact{
    _fact = fact;
    //title
    if ((NSNull *)fact.title != [NSNull null]) {
        NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:fact.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Georgia-Bold" size:17]}];
        CGRect titleSize = [titleString boundingRectWithSize:CGSizeMake(myScreen.size.width - 20, 9999) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGFloat titleX = 5;
        CGFloat titleY = 5;
        _titleFrame = CGRectMake(titleX, titleY, titleSize.size.width, titleSize.size.height);
    }
    else {
        _titleFrame = CGRectZero;
    }
    //content
    if ((NSNull *)fact.description != [NSNull null]) {
        NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:fact.description attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
        CGRect contentSize = [contentString boundingRectWithSize:CGSizeMake(myScreen.size.width *0.6, 9999) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGFloat contentX = 5;
        CGFloat contentY = CGRectGetMaxY(_titleFrame) + 5;
        _descriptionFrame = CGRectMake(contentX, contentY, contentSize.size.width, contentSize.size.height);
    }
    else {
        _descriptionFrame = CGRectZero;
    }
    
    //image
    if ((NSNull *)fact.imageHref != [NSNull null]) {
        CGFloat imageX = myScreen.size.width * 0.7 ;
        CGFloat imageY = CGRectGetMaxY(_titleFrame) + 5;
        CGFloat imageWidth = myScreen.size.width - imageX - 20;
        CGFloat imageHeight = imageWidth;
        _imageFrame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    }
    else {
        _imageFrame = CGRectZero;
    }
    //NSLog(@"_titleFrame.size.height %f / _descriptionFrame.size.height %f / _imageFrame.size.height %f",_titleFrame.size.height,_descriptionFrame.size.height,_imageFrame.size.height);
    if ( _descriptionFrame.size.height == 0 && _imageFrame.size.height == 0) {
        _cellHeight = _titleFrame.size.height + 20.0f;
    }
    else if ( _descriptionFrame.size.height > _imageFrame.size.height) {
        _cellHeight = _descriptionFrame.size.height + _titleFrame.size.height + 20.0f;
    } else {
        _cellHeight = _imageFrame.size.height +_titleFrame.size.height + 20.0f;
    }
}


@end
