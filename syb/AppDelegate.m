//
//  AppDelegate.m
//  syb
//
//  Created by GX on 15/9/17.
//  Copyright (c) 2015年 GX. All rights reserved.
//
//  试用宝 正品检测检测认证平台
// 提供三项服务
// 1 网店验货
// 2 维权取证，协助维权
// 3 帮助消费者找到更靠谱的网店（核心）

//核心竞争力 科学 严谨 高效的检测方法
//核心价值  让消费者更安心的网络购物环境
//企业使命 成为电商消费的正能量的守护者和传播者




#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "GuideViewController.h"
#import <JPUSHService.h>
//科大讯飞语音识别
#import "iflyMSC/iflySetting.h"
//#import "Definition.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import <UMSocial.h>
#import "RNCachingURLProtocol.h"
#import "Tabbar320ViewController.h"
@interface AppDelegate ()
{
    Tabbar320ViewController * tabbarVC;
    GuideViewController * guideVC;
}

@property float autoSizeScaleX;
@property float autoSizeScaleY;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    // Override point for customization after application launch.
    //缓存机制
  //  [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    //友盟分享
    [UMSocialData setAppKey:@"552f1092fd98c59fbd00227a"];
    
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    NSString * alias = SM.userName;
    [JPUSHService setAlias:alias callbackSelector:nil object:nil];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
    //友盟统计
    [MobClick startWithAppkey:@"552f1092fd98c59fbd00227a" reportPolicy:BATCH   channelId:@"App Store"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:NO];
    

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [UIViewController new];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    
    //系统的状态栏，主题颜色设置
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:  RGBACOLOR(51, 51, 51, 1),NSForegroundColorAttributeName,nil]];



  
    
    //第一次启动时候的判断
    if (![UserDefaultsUtils boolValueWithKey:@"306"]) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        guideVC = [[GuideViewController alloc]init];
        _window.rootViewController = guideVC;
      
    
    }else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        //项目根视图控制器
        tabbarVC = [[Tabbar320ViewController alloc]init];
        _window.rootViewController = tabbarVC;

    }

    //设置第一次开启应用
    [UserDefaultsUtils saveBoolValue:YES withKey:@"320"];
 
    [self InitSingleManage];

    //讯飞语音
    
    [self InitIfly];
    
    [self requestCatData];
    
    return YES;
}
//UMENG
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)requestCatData
{
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GetCatsList pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        
      
        NSDictionary * resultDict = [obj valueForKey:@"result"];
        _goodCatList = [resultDict valueForKey:@"module_1"];
        _shopCatList = [resultDict valueForKey:@"module_0"];
        
        [UserDefaultsUtils saveValue:_goodCatList forKey:@"goodCatList"];
        [UserDefaultsUtils saveValue:_shopCatList forKey:@"shopCatList"];
        
    
    };
    request.failureGetData = ^(void){
        
 
    };
    
}
-(void)InitSingleManage
{
    //初始化单例
    SM = [SingleManage shareManage];
  
    if ([UserDefaultsUtils valueWithKey:@"token"]!=nil) {
        
        SM.userID     = [UserDefaultsUtils valueWithKey:@"user_id"];
        SM.userName   = [UserDefaultsUtils valueWithKey:@"user_name"];
        SM.imageURL   = [UserDefaultsUtils valueWithKey:@"user_photo"];
        SM.nickName   = [UserDefaultsUtils valueWithKey:@"nickname"];
        SM.birthday   = [UserDefaultsUtils valueWithKey:@"birthday"];
        SM.userSex    = [UserDefaultsUtils valueWithKey:@"sex"];
        SM.code       = [UserDefaultsUtils valueWithKey:@"code"];
        SM.userToken  = [UserDefaultsUtils valueWithKey:@"token"];
        SM.passWord   = [UserDefaultsUtils valueWithKey:@"password"];
        SM.userMoney  = [UserDefaultsUtils valueWithKey:@"user_money"];
        SM.userdesc   =  [UserDefaultsUtils valueWithKey:@"user_desc"];
        SM.babyName   =  [UserDefaultsUtils valueWithKey:@"baby_name"];
        SM.babySex   =  [UserDefaultsUtils valueWithKey:@"baby_birthday"];
        SM.babyBirthday   =  [UserDefaultsUtils valueWithKey:@"baby_birthday"];
        SM.isLogin = YES;

    }else
    {
        SM.isLogin  = NO;

    }
}

//讯飞语音
-(void)InitIfly
{
 
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"56274e32"];
    [IFlySpeechUtility createUtility:initString];
    
    
}


//极光推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    
    
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6

     NSLog(@"***%@",userInfo);

    
    [JPUSHService handleRemoteNotification:userInfo];
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
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
