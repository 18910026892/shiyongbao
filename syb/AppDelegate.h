//
//  AppDelegate.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
#import "SybSession.h"
#import <ALBBSDK/ALBBSDK.h>
#import "GuideViewController.h"
#import "UserDefaultsUtils.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,GuideViewControllerDelegate>
{
    SybSession * userSession;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)BaseTabBarController * tabBarViewController;



@end

