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
        [self labelDefault];
    }
    return self;
}

/**
 *  默认状态
 */
- (void) labelDefault{
    //默认居中对齐-和系统一致
    self.verticalAlignment=VerticalAlignmentMiddle;
    //默认关闭长按复制
    self.longTouchCopy=NO;
    //开启交互
    self.userInteractionEnabled=YES;
}
#pragma mark-改变文字布局
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
#pragma mark- 类构造方法
+(MCLabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLine:(NSInteger)numberOfLines
{
    MCLabel *label = [[MCLabel alloc] initWithFrame:frame];
    //文字
    if (title) {
        label.text = title;
    }
    //文字颜色
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    if (numberOfLines) {
        label.numberOfLines = numberOfLines;
    }
    
    return label;
    
}

+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByWidth:(CGFloat)width atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment{
    NSDictionary *textfont = @{NSFontAttributeName:[UIFont systemFontOfSize:fontNumber]};
    CGFloat textHeight=[text boundingRectWithSize:CGSizeMake( width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textfont context:nil].size.height;
    MCLabel*label=[[MCLabel alloc]initWithFrame:CGRectMake(point.x, point.y, width, textHeight)];
    label.text=text;
    label.font=[UIFont systemFontOfSize:fontNumber];
    label.numberOfLines=0;
    label.textAlignment=textAlignment;
    return label;
}

+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByHeight:(CGFloat)height atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment{
    NSDictionary *textfont = @{NSFontAttributeName:[UIFont systemFontOfSize:fontNumber]};
    CGFloat textWidth=[text boundingRectWithSize:CGSizeMake( CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:textfont context:nil].size.width;
    MCLabel*label=[[MCLabel alloc]initWithFrame:CGRectMake(point.x, point.y, textWidth, height)];
    label.text=text;
    label.font=[UIFont systemFontOfSize:fontNumber];
    label.numberOfLines=0;
    label.textAlignment=textAlignment;
    return label;
}
#pragma mark-长按弹框复制文字内容
- (void) coayLabelText{
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyText:)];
    [self addGestureRecognizer:longPress];
}
//复制文字内容
- (void) copyText:(UILongPressGestureRecognizer*)longGes{
    if (longGes.state==UIGestureRecognizerStateBegan) {
        if (_longTouchCopy==YES) {
            UIPasteboard*pad=[UIPasteboard generalPasteboard];
            [pad setString:self.text];
            if (pad==nil) {
                NSLog(@"无内容或者复制失败");
            }
            else{
                NSLog(@"复制成功");
            }
        }
    }
}
- (void) setLongTouchCopy:(BOOL)longTouchCopy{
    _longTouchCopy=longTouchCopy;
    [self coayLabelText];
}
@end
