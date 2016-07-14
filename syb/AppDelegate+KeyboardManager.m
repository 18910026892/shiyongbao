//
//  AppDelegate+KeyboardManager.m
//  syb
//
//  Created by GongXin on 16/7/11.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AppDelegate+KeyboardManager.h"

@implementation AppDelegate (KeyboardManager)
-(void)initIQKeyboardManager;
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}
@end
