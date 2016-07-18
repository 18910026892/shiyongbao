//
//  AppDelegate+Alibaba.m
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AppDelegate+Alibaba.h"

@implementation AppDelegate (Alibaba)

-(void)initAliBBSDK;
{
    [[ALBBSDK sharedInstance] setDebugLogOpen:NO]; // 打开debug日志
    [[ALBBSDK sharedInstance] setUseTaobaoNativeDetail:NO]; // 优先使用手淘APP打开商品详情页面，如果没有安装手机淘宝，SDK会使用H5打开
    [[ALBBSDK sharedInstance] setViewType:ALBB_ITEM_VIEWTYPE_TAOBAO];// 使用淘宝H5页面打开商品详情
    [[ALBBSDK sharedInstance] setISVCode:@"my_isv_code"]; //设置全局的app标识，在电商模块里等同于isv_code
    [[ALBBSDK sharedInstance] asyncInit:^{ // 基础SDK初始化
        NSLog(@"init success");
    } failure:^(NSError *error) {
        NSLog(@"init failure, %@", error);
    }];
    
    TBAppLinkSDK * tblinkSdk;
    
    if (!tblinkSdk) {
        tblinkSdk = [TBAppLinkSDK initWithAppkey:@"23264858"];
    }
    
}

@end
