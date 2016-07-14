//
//  VerifyViewController.h
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface VerifyViewController : UIViewController
{
    UIButton * backButton;
    UILabel * phoneNumberLabel;
    UILabel * verficationCodeLabel;
    UIView * TFView;

    UIButton * againBtn;
    UIBarButtonItem * againBI;
    UIButton * nextBtn;
    
    CustomTextField * tf;
    CustomTextField * Tf;
    
    UILabel * line;
    UILabel * password;
    UIButton * ResetBtn;
    
}
//短信验证码
@property (nonatomic,copy)NSString * sendCode;

//要发送的手机号
@property (nonatomic,copy)NSString * phoneNumber;
//短信验证码返回值
@property (nonatomic,strong)NSMutableDictionary * sendDict;


//密码
@property (nonatomic,copy)NSString * passWord;

@property (nonatomic,strong)NSMutableDictionary * dict;

@property (nonatomic,copy)NSString * testcode;
@end
