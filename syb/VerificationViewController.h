//
//  VerificationViewController.h
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface VerificationViewController : BaseViewController
{

    UILabel * phoneNumberLabel;
    UILabel * verficationCodeLabel;
    UILabel * invitationCodeLabel;
    UILabel * password;
    UILabel * line,*line1;
    UIView * TFView;
    CustomTextField * tf;
    CustomTextField * Tf;
    CustomTextField * TF;

    UIButton * registerBtn;
    SybSession * userSession;
}


//要发送的手机号
@property (nonatomic,copy)NSString * phoneNumber;

//短信验证码
@property (nonatomic,copy)NSString * sendCode;

//邀请码

@property(nonatomic,copy)NSString * invitationCode;

//密码
@property (nonatomic,copy)NSString * passWord;
//短信验证码返回值
@property (nonatomic,strong)NSMutableDictionary * sendDict;


@property (nonatomic,strong)NSMutableDictionary * dict;

//用户相关信息的数据
@property(nonatomic,strong)NSMutableDictionary * userDict;

@property (nonatomic,copy)NSString * testcode;

@end
