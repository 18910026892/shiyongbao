//
//  SingleManage.m
//  syb
//
//  Created by GX on 15/8/20.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "SingleManage.h"

static SingleManage * shareManage = nil;
@implementation SingleManage
+(id)shareManage
{
    //同步线程
    @synchronized (self)
    {
        if (!shareManage) {
            shareManage  = [[SingleManage alloc]init];
            shareManage.userID = [UserDefaultsUtils valueWithKey:@"user_id"];
            shareManage.userName = [UserDefaultsUtils valueWithKey:@"user_name"];
            shareManage.imageURL = [UserDefaultsUtils valueWithKey:@"user_photo"];
            shareManage.nickName  = [UserDefaultsUtils valueWithKey:@"nickname"];
            shareManage.birthday = [UserDefaultsUtils valueWithKey:@"birthday"];
            shareManage.userSex = [UserDefaultsUtils valueWithKey:@"sex"];
            shareManage.code  = [UserDefaultsUtils valueWithKey:@"code"];
            shareManage.userToken = [UserDefaultsUtils valueWithKey:@"token"];
            shareManage.passWord = [UserDefaultsUtils valueWithKey:@"password"];
            shareManage.userMoney = [UserDefaultsUtils valueWithKey:@"user_money"];
            shareManage.userdesc = [UserDefaultsUtils valueWithKey:@"user_desc"];
            shareManage.babyName = [UserDefaultsUtils valueWithKey:@"baby_name"];
            shareManage.babySex = [UserDefaultsUtils valueWithKey:@"baby_sex"];
            shareManage.babyBirthday = [UserDefaultsUtils valueWithKey:@"baby_birthday"];
            shareManage.isLogin = YES;
            
        }
    }
    return  shareManage;
}


@end
