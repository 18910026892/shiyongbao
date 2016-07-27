//
//  SybSession.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "SybSession.h"


static NSString *const kSessionuserID          = @"kSessionuserID";
static NSString *const kSessionuserName        = @"kSessionuserName";
static NSString *const kSessionimageURL        = @"kSessionimageURL";
static NSString *const kSessionnickName        = @"kSessionnickName";
static NSString *const kSessionuserSex         = @"kSessionuserSex";
static NSString *const kSessionuserToken       = @"kSessionuserToken";
static NSString *const kSessionbabyName        = @"kSessionbabyName";
static NSString *const kSessionbabySex         = @"kSessionbabySex";
static NSString *const kSessionbabyBirthday    = @"kSessionbabyBirthday";
static NSString *const kSessionbirthday        = @"kSessionbirthday";
static NSString *const kSessioncode            = @"kSessioncode";
static NSString *const kSessionpassWord        = @"kSessionpassWord";
static NSString *const kSessionuserMoney       = @"kSessionuserMoney";
static NSString *const kSessionuserdesc        = @"kSessionuserdesc";




@implementation SybSession

+ (SybSession *)sharedSession{
    static SybSession *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SybSession alloc] init];
        
        sharedManager.userID = [UserDefaultsUtils valueWithKey:kSessionuserID];

        //用户名(用户的手机号)
        sharedManager.userName =[UserDefaultsUtils valueWithKey:kSessionuserName];
        //用户的头像地址
       sharedManager.imageURL=[UserDefaultsUtils valueWithKey:kSessionimageURL];
        //用户的昵称
        sharedManager.nickName=[UserDefaultsUtils valueWithKey:kSessionnickName];
        //用户的性别
        sharedManager.userSex=[UserDefaultsUtils valueWithKey:kSessionuserSex];
        //用户的TOKEN
        sharedManager.userToken=[UserDefaultsUtils valueWithKey:kSessionuserToken];
        //宝贝的姓名
        sharedManager. babyName=[UserDefaultsUtils valueWithKey:kSessionbabyName];
        //宝贝的性别
       sharedManager.babySex=[UserDefaultsUtils valueWithKey:kSessionbabySex];
        //宝贝的生日
        sharedManager.babyBirthday=[UserDefaultsUtils valueWithKey:kSessionbabyBirthday];
        //用户的生日
        sharedManager.birthday=[UserDefaultsUtils valueWithKey:kSessionbirthday];
        //用户的邀请码
        sharedManager.code=[UserDefaultsUtils valueWithKey:kSessioncode];
        //用户的密码
        sharedManager.passWord=[UserDefaultsUtils valueWithKey:kSessionpassWord];
        //用户的可提现金额
       sharedManager.userMoney=[UserDefaultsUtils valueWithKey:kSessionuserMoney];
        //用户的自我描述
        sharedManager.userdesc=[UserDefaultsUtils valueWithKey:kSessionuserdesc];
        
    });
    
    return sharedManager;
}


-(void)saveWithDictionary:(NSDictionary *)userInfo;

{
    if(self && [userInfo isKindOfClass:[NSDictionary class]]) {
   
        
        
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"user_id"] forKey:kSessionuserID];
        
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"user_name"] forKey:kSessionuserName];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"user_photo"] forKey:kSessionimageURL];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"nickname"] forKey:kSessionnickName];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"birthday"] forKey:kSessionbirthday];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"sex"] forKey:kSessionuserSex];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"code"] forKey:kSessioncode];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"token"] forKey:kSessionuserToken];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"password"] forKey:kSessionpassWord];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"app_money"] forKey:kSessionuserMoney];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"user_desc"] forKey:kSessionuserdesc];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"baby_name"] forKey:kSessionbabyName];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"baby_sex"] forKey:kSessionbabySex];
        [UserDefaultsUtils saveValue:[userInfo valueForKey:@"baby_birthday"] forKey:kSessionbabyBirthday];
        
        
        
        
        
        self.userID = [UserDefaultsUtils valueWithKey:kSessionuserID];
        
        //用户名(用户的手机号)
        self.userName =[UserDefaultsUtils valueWithKey:kSessionuserName];
        //用户的头像地址
        self.imageURL=[UserDefaultsUtils valueWithKey:kSessionimageURL];
        //用户的昵称
        self.nickName=[UserDefaultsUtils valueWithKey:kSessionnickName];
        //用户的性别
        self.userSex=[UserDefaultsUtils valueWithKey:kSessionuserSex];
        //用户的TOKEN
        self.userToken=[UserDefaultsUtils valueWithKey:kSessionuserToken];
        //宝贝的姓名
        self.babyName=[UserDefaultsUtils valueWithKey:kSessionbabyName];
        //宝贝的性别
        self.babySex=[UserDefaultsUtils valueWithKey:kSessionbabySex];
        //宝贝的生日
        self.babyBirthday=[UserDefaultsUtils valueWithKey:kSessionbabyBirthday];
        //用户的生日
        self.birthday=[UserDefaultsUtils valueWithKey:kSessionbirthday];
        //用户的邀请码
        self.code=[UserDefaultsUtils valueWithKey:kSessioncode];
        //用户的密码
        self.passWord=[UserDefaultsUtils valueWithKey:kSessionpassWord];
        //用户的可提现金额
        self.userMoney=[UserDefaultsUtils valueWithKey:kSessionuserMoney];
        //用户的自我描述
        self.userdesc=[UserDefaultsUtils valueWithKey:kSessionuserdesc];
        
        self.isLogin = YES;
    }
}

- (void)removeUserInfo;
{

    
     [UserDefaultsUtils removeValueforKey:kSessionuserID];
     [UserDefaultsUtils removeValueforKey:kSessionuserName];
     [UserDefaultsUtils removeValueforKey:kSessionimageURL];
     [UserDefaultsUtils removeValueforKey:kSessionnickName];
     [UserDefaultsUtils removeValueforKey:kSessionuserSex];
     [UserDefaultsUtils removeValueforKey:kSessionuserToken];
     [UserDefaultsUtils removeValueforKey:kSessionbabyName];
     [UserDefaultsUtils removeValueforKey:kSessionbabySex];
     [UserDefaultsUtils removeValueforKey:kSessionbabyBirthday];
     [UserDefaultsUtils removeValueforKey:kSessioncode];
     [UserDefaultsUtils removeValueforKey:kSessionpassWord];
     [UserDefaultsUtils removeValueforKey:kSessionuserMoney];
     [UserDefaultsUtils removeValueforKey:kSessionuserdesc];
    
    //在清理单例属性
    
    self.userID = nil;
    
    //用户名(用户的手机号)
    self.userName =nil;
    //用户的头像地址
    self.imageURL=nil;
    //用户的昵称
    self.nickName=nil;
    //用户的性别
    self.userSex=nil;
    //用户的TOKEN
    self.userToken=nil;
    //宝贝的姓名
    self.babyName=nil;
    //宝贝的性别
    self.babySex=nil;
    //宝贝的生日
    self.babyBirthday=nil;
    //用户的生日
    self.birthday=nil;
    //用户的邀请码
    self.code=nil;
    //用户的密码
    self.passWord=nil;
    //用户的可提现金额
    self.userMoney=nil;
    //用户的自我描述
    self.userdesc=nil;
    
   self.isLogin = NO;
    
}
@end
