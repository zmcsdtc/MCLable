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
    self.mcVerticalAlignment=MCVerticalAlignmentMiddle;
    //默认关闭长按复制
    self.longTouchCopy=NO;
    //开启交互
    self.userInteractionEnabled=YES;
}
#pragma mark-改变文字布局
- (void) setMcVerticalAlignment:(MCVerticalAlignment)mcVerticalAlignment{
    _mcVerticalAlignment=mcVerticalAlignment;
    [self setNeedsDisplay];
}
/**
 *  重写lable上的文字对齐方式
 */
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect=[super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.mcVerticalAlignment) {
        case MCVerticalAlignmentTop:
        {
            textRect.origin.y=bounds.origin.y;
        }
            break;
        case MCVerticalAlignmentButtom:
        {
            textRect.origin.y=bounds.origin.y+bounds.size.height-textRect.size.height;
        }
            break;
        case MCVerticalAlignmentMiddle:
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

+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByHeight:(CGFloat)height atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment{
    MCLabel*label=[[MCLabel alloc]initWithFrame:CGRectMake(point.x, point.y, 1, height)];
    label.mcLabelSizeType=MCLabelHeightNotChange;
    //要先设置字体再赋值
    label.font=[UIFont systemFontOfSize:fontNumber];;
    label.numberOfLines=0;
    label.textAlignment=textAlignment;
    label.text=text;
    
    return label;
}
+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByWidth:(CGFloat)width atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment{
    MCLabel*label=[[MCLabel alloc]initWithFrame:CGRectMake(point.x, point.y, width, 1)];
    label.mcLabelSizeType=MCLabelWidthNotChange;
    //要先设置字体再赋值
    label.font=[UIFont systemFontOfSize:fontNumber];;
    label.numberOfLines=0;
    label.textAlignment=textAlignment;
    label.text=text;
    return label;
}
#pragma mark-重写text
- (void) setText:(NSString *)text{
    [super setText:text];
    
    if (self.mcLabelSizeType==MCLabelHeightNotChange) {
        CGFloat textWidth=[text boundingRectWithSize:CGSizeMake( CGFLOAT_MAX,self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
        CGRect frame=self.frame;
        frame.size.width=textWidth;
        self.frame=frame;
    }
    if (self.mcLabelSizeType==MCLabelWidthNotChange) {
        CGFloat textHeight=[text boundingRectWithSize:CGSizeMake(self.bounds.size.width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
        CGRect frame=self.frame;
        frame.size.height=textHeight;
        self.frame=frame;
    }
    

}

#pragma mark-长按弹框复制文字内容
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copyThisLabelText:));
}
//添加长手势
- (void) addLongPressGestureRecognize{
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyText:)];
    [self addGestureRecognizer:longPress];
}
//长手势方法-menucontroller
- (void) copyText:(UILongPressGestureRecognizer*)longGes{
    if (longGes.state==UIGestureRecognizerStateBegan) {
        if (_longTouchCopy==YES) {
            [self becomeFirstResponder];
            UIMenuController*popMenu=[UIMenuController sharedMenuController];
            UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyThisLabelText:)];
            [popMenu setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
            [popMenu setTargetRect:self.frame inView:self.superview];
            [popMenu setMenuVisible:YES animated:YES];
            [popMenu setArrowDirection:UIMenuControllerArrowDown];
        }
    }
}
//复制内容
- (void)copyThisLabelText:(id)sender{
    UIPasteboard*pas=[UIPasteboard generalPasteboard];
    pas.string=self.text;
}
- (void) setLongTouchCopy:(BOOL)longTouchCopy{
    _longTouchCopy=longTouchCopy;
    [self addLongPressGestureRecognize];
}

#pragma mark-调整大小的方法

@end
