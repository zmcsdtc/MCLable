//
//  ViewController.m
//  MCLabel
//
//  Created by ZMC on 15/12/23.
//  Copyright © 2015年 Zmc. All rights reserved.
//

#import "ViewController.h"
#import "MCLabel.h"
@interface ViewController ()
{
    MCLabel*_label;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MCLabel*label=[MCLabel createLabelByString:@"啊大大啊大s43123沙发阿达" andByFont:45 andByWidth:200 atOrigin:CGPointMake(100, 120) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label];
    label.longTouchCopy=YES;
    label.backgroundColor=[UIColor redColor];
    
    MCLabel*label1=[MCLabel createLabelByString:@"撒声撒大声撒大声" andByFont:18 andByHeight:40 atOrigin:CGPointMake(10, 20) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label1];
    label1.longTouchCopy=YES;
    label1.backgroundColor=[UIColor redColor];
    _label=label;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _label.text=@"123";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
