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
@property(assign,nonatomic)VerticalAlignment verticalAlignment;

@end
