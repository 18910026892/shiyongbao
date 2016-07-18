//
//  MyAttentionViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "shopAttentionViewController.h"
#import "goodsAttentionViewController.h"
@implementation MyAttentionViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    [MobClick beginLogPageView:@"我的关注"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"我的关注"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"我的关注"];
    [self showBackButton:YES];
    
    
}
@end
