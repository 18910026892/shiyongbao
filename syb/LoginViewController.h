//
//  LoginViewController.h
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UIButton * backButton;
    //输入区域
    UIView * TFView;
    //账号密码图标
    UIImageView * userNameImg;
    UIImageView * passWordImg;
    //输入框
    CustomTextField * userNameTF;
    CustomTextField * passWordTF;
    //分界线
    UILabel * line;
    //登录 注册 忘记密码按钮
    UIButton * loginBtn;
    UIButton * registerBtn;
    UIButton * forgetBtn;
    
    SingleManage * SM;
    
}

//用户输入的用户名和密码
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * passWord;

//用户登录 后台返回的字典
@property(nonatomic,strong)NSMutableDictionary * dict;
//用户相关信息的数据
@property(nonatomic,strong)NSMutableDictionary * userDict;


@end
