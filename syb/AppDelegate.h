//
//  AppDelegate.h
//  syb
//
//  Created by GX on 15/9/17.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *appKey = @"2de77c9b51dc2973206f1751";
static NSString *channel = @"App Store";
static BOOL isProduction = TRUE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    SingleManage * SM;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)NSMutableArray * shopCatList;
@property (nonatomic,strong)NSMutableArray * goodCatList;
@end

