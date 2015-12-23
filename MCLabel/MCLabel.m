//
//  MCLabel.m
//  MCLabel
//
//  Created by ZMC on 15/12/23.
//  Copyright © 2015年 Zmc. All rights reserved.
//

#import "MCLabel.h"

@implementation MCLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        /**
         *  默认居中对齐
         */
        self.verticalAlignment=VerticalAlignmentMiddle;
    }
    return self;
}
- (void) setVerticalAlignment:(VerticalAlignment)verticalAlignment{
    _verticalAlignment=verticalAlignment;
    [self setNeedsDisplay];
}
/**
 *  重写lable上的文字对齐方式
 */
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect=[super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
        {
            textRect.origin.y=bounds.origin.y;
        }
            break;
        case VerticalAlignmentButtom:
        {
            textRect.origin.y=bounds.origin.y+bounds.size.height-textRect.size.height;
        }
            break;
        case VerticalAlignmentMiddle:
        default:{
            textRect.origin.y = bounds.origin.y+(bounds.size.height - textRect.size.height) / 2.0;
        }
            break;
    }
    return textRect;
}
- (void) drawTextInRect:(CGRect)requestRect{
    CGRect actualRect=[self textRectForBounds:requestRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
