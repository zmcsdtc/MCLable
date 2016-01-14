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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MCLabel*label=[MCLabel createLabelByString:@"asdasdasdsdasdasdsdasdasdsdasdasdsdasdasdsdasdasdsdasdasdasdasdasdasdasd" andByFont:18 andByWidth:100 atOrigin:CGPointMake(0, 20) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label];
    label.longTouchCopy=YES;
    label.backgroundColor=[UIColor redColor];
    
    MCLabel*label1=[MCLabel createLabelByString:@"撒大声地阿达啊" andByFont:18 andByWidth:100 atOrigin:CGPointMake(150, 20) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label1];
    label1.longTouchCopy=YES;
    label1.backgroundColor=[UIColor redColor];
    
    
    UITextView*text=[[UITextView alloc] initWithFrame:CGRectMake(0, 200, 200,200)];
    text.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:text];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
