//
//  MeHeaderLogoutView.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MeHeaderLogoutView.h"

@implementation MeHeaderLogoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.avatarImageView];
        [self addSubview:self.loginButton];
         [self addSubview:self.registerButton];
    }
    return self;
}


-(UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.frame = CGRectMake(20, 75, 60, 60);
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImageView.layer.borderWidth = 2;
        _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image =  [UIImage imageNamed:@"touxiang"];
    }
    return _avatarImageView;
}
-(UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton =[UIButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(100,89,80, 30) title:@"去登录" titleColor:RGBCOLOR(154, 160, 169) font:[UIFont systemFontOfSize:16] backgroundColor:[UIColor whiteColor]];
        _loginButton.layer.cornerRadius = 2;

        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIButton*)registerButton
{
    if (!_registerButton) {
        _registerButton =[UIButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(200,89,80, 30) title:@"新人注册" titleColor:RGBCOLOR(154, 160, 169) font:[UIFont systemFontOfSize:16] backgroundColor:[UIColor whiteColor]];
        _registerButton.layer.cornerRadius = 2;
        [_registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

-(void)loginButtonClick:(UIButton*)sender
{
    NSLog(@"login");
    if (_delegate) {
        [_delegate MeHeaderLogoutViewLoginBtn:sender];
    }
    
}


-(void)registerButtonClick:(UIButton*)sender
{
     NSLog(@"register");
    if (_delegate) {
        [_delegate MeHeaderLogoutViewRegisterBtn:sender];
    }
}


@end
