//
//  RegisterViewController.h
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "PooCodeView.h"
@interface RegisterViewController : BaseViewController
{
   
    UIView * TFView;
    UILabel * phoneNumber;
    CustomTextField * tf;
    UIButton * nextBtn;
    
    UILabel * line;
    UILabel * codeLabel;
    
    CustomTextField * codeTF;
    PooCodeView * pooCode;
    
}

//是否需要展示验证码
@property (nonatomic,copy)NSString * needShow;

//是否展示验证码
@property BOOL isShow;

//是否输入正确的验证码
@property BOOL isTest;

@property (nonatomic,copy)NSString * userName;
@property (nonatomic,strong)NSMutableDictionary * sendDict;
@property (nonatomic,copy)NSString * testcode;

@end
