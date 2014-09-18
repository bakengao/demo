//
//  TWTableViewCell.m
//  TestForTW
//
//  Created by Mac on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWTableViewCell.h"
#import "TWCellFrame.h"
#import "factModel.h"
#import "UIImageView+Async.h"

@interface TWTableViewCell(){
    UIImageView *_image;
    UILabel *_title;
    UILabel *_description;
    
}

@end
@implementation TWTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCellSubCells];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addCellSubCells{
    
    _image = [[UIImageView alloc] init];
    [self.contentView addSubview:_image];
    
    _title = [[UILabel alloc] init];
    _title.lineBreakMode = NSLineBreakByCharWrapping;
    _title.numberOfLines = 0;
    [self.contentView addSubview:_title];
    
    _description = [[UILabel alloc] init];
    _description.lineBreakMode = NSLineBreakByCharWrapping;
    _description.numberOfLines = 0;
    [self.contentView addSubview:_description];
    
}

-(void)setTwCellFrame:(TWCellFrame *)twCellFrame{
    _twCellFrame = twCellFrame;
    factModel *model = twCellFrame.fact;
    if ((NSNull *)model.title != [NSNull null]) {
        _title.frame = twCellFrame.titleFrame;
        _title.text = model.title;
        _title.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
        [_title setTextColor:[UIColor blueColor]];
        
    }
    
    if ((NSNull *)model.description != [NSNull null]) {
        _description.frame = twCellFrame.descriptionFrame;
        _description.text = model.description;
        _description.font = [UIFont systemFontOfSize:12];
        [_description setTextColor:[UIColor blackColor]];
    }
    
    if ((NSNull *)model.imageHref != [NSNull null]) {
        _image.frame = twCellFrame.imageFrame;
        _image.contentMode = UIViewContentModeScaleAspectFit;
        [_image setImageWithURL:[NSURL URLWithString:model.imageHref] placeholderImage:nil];
    }
}


-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.64, 0.64, 0.64, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, self.frame.size.width -10, 55);
    CGContextAddLineToPoint(context, self.frame.size.width -5, 60);
    CGContextAddLineToPoint(context, self.frame.size.width -10, 65);
    CGContextDrawPath(context, kCGPathStroke);
}


@end
