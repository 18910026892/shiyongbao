//
//  BaseTabBarController.h
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
#import "ShopsAllViewController.h"
#import "ShiYongBaoViewController.h"
#import "CartViewController.h"
#import "MeViewController.h"

@interface BaseTabBarController : UITabBarController

+(BaseTabBarController*)shareTabBarController;

-(void)setTabBarSelectedIndex:(NSUInteger)selectedIndex;

-(void)hiddenTabBar:(BOOL)hidden;

-(void)showOrderRedDocWithCount:(NSInteger)count;


@end

