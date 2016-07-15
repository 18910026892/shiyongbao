//
//  ClassifyViewController.m
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ClassifyViewController.h"

@implementation ClassifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setTabBarHide:YES];
    [MobClick beginLogPageView:@"商品分类"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"商品分类"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"商品分类"];
    
}
@end
