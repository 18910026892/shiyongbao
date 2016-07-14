//
//  MeHeaderLogoutView.h
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeHeaderLogoutView;
@protocol MeHeaderLogoutViewDelegate <NSObject>
@optional

-(void)MeHeaderLogoutViewLoginBtn:(UIButton *)loginBtn;
-(void)MeHeaderLogoutViewRegisterBtn:(UIButton *)registerBtn;
@end
@interface MeHeaderLogoutView : UIView

@property(nonatomic,strong)id<MeHeaderLogoutViewDelegate>delegate;
//头像
@property(nonatomic,strong)UIImageView * avatarImageView;

@property(nonatomic,strong)UIButton * loginButton;

@property(nonatomic,strong)UIButton * registerButton;


@end
