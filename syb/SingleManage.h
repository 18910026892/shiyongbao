//
//  SingleManage.h
//  syb
//
//  Created by GX on 15/8/20.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleManage : NSObject
+(id)shareManage;
//是否登录
@property (nonatomic,assign) BOOL isLogin;
//用户ID
@property (nonatomic,copy) NSString * userID;
//用户名(用户的手机号)
@property (nonatomic,copy) NSString * userName;
//用户的头像地址
@property (nonatomic,copy) NSString * imageURL;
//用户的昵称
@property (nonatomic,copy) NSString * nickName;
//用户的性别
@property (nonatomic,copy) NSString * userSex;
//用户的TOKEN
@property (nonatomic,copy) NSString * userToken;
//宝贝的姓名
@property (nonatomic,copy) NSString * babyName;
//宝贝的性别
@property (nonatomic,copy) NSString * babySex;
//宝贝的生日
@property (nonatomic,copy) NSString * babyBirthday;
//用户的生日
@property (nonatomic,copy) NSString * birthday;
//用户的邀请码
@property (nonatomic,copy) NSString * code;
//用户的密码
@property (nonatomic,copy) NSString * passWord;
//用户的可提现金额
@property (nonatomic,copy) NSString * userMoney;
//用户的自我描述
@property (nonatomic,copy) NSString * userdesc;

//系统相关

@end
