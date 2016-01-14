//
//  MCLabel.h
//  MCLabel
//
//  Created by ZMC on 15/12/23.
//  Copyright © 2015年 Zmc. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 对齐方式
 */
typedef enum
{
    /**
     *  定格对齐
     */
    VerticalAlignmentTop,
    /**
     *  底部对齐
     */
    VerticalAlignmentButtom,
    /**
     *  居中对齐
     */
    VerticalAlignmentMiddle
    
}VerticalAlignment;

@interface MCLabel : UILabel
/**
 *  文字布局
 */
@property(assign,nonatomic)VerticalAlignment verticalAlignment;
/**
 *  长按是否复制,默认状态否
 */
@property(assign,nonatomic)BOOL longTouchCopy;

/**
 *  普通方式创建label
 */
+ (MCLabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLine:(NSInteger)numberOfLines;
/**
 *  根据文字内容和字体以及宽度创建UILabel-atOrigin:起始坐标
 */
+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByWidth:(CGFloat)width atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment;
/**
 *  根据文字内容和字体以及高度创建UILabel-atOrigin:起始坐标
 */
+(MCLabel*)createLabelByString:(NSString*)text andByFont:(NSInteger)fontNumber andByHeight:(CGFloat)height atOrigin:(CGPoint)point textAlignment:(NSTextAlignment)textAlignment;

@end
