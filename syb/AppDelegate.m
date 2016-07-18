//
//  AppDelegate.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+KeyboardManager.h"
#import "AppDelegate+Request.h"
#import "AppDelegate+Alibaba.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    [self initAliBBSDK];
     [self InitUserSession];
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    _window.backgroundColor = [UIColor whiteColor];
    
    _window.rootViewController = self.tabBarViewController;
    
    [_window makeKeyAndVisible];


    [self initIQKeyboardManager];
    [self SystemConfiguration];
    [self getShopCatList];
    [self getGoodsCatList];
    
    return YES;
}

-(void)InitUserSession
{

    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    
    if (userSession.userID) {
        userSession.isLogin = YES;
    }else
    {
        userSession.isLogin = NO;
    }
}

//配置主题色
-(void)SystemConfiguration
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
 
}

-(BaseTabBarController*)tabBarViewController;
{
    if (!_tabBarViewController) {
        _tabBarViewController = [BaseTabBarController shareTabBarController];
        
    }
    return _tabBarViewController;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL isHandled = [[ALBBSDK sharedInstance] handleOpenURL:url]; // 如果百川处理过会返回YES
    if (!isHandled) {
        // 其他处理逻辑
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
