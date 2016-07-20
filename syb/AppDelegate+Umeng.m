//
//  AppDelegate+Umeng.m
//  syb
//
//  Created by GongXin on 16/7/20.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AppDelegate+Umeng.h"
@implementation AppDelegate (Umeng)
-(void)initMobClick;
{
    
    //友盟统计

    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"552f1092fd98c59fbd00227a";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];

}
@end
