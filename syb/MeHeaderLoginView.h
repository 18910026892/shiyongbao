//
//  MeHeaderLoginView.h
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeHeaderLoginView;
@protocol MeHeaderLoginViewDelegate <NSObject>
@optional

-(void)MeHeaderClick;
-(void)MeHeaderLoginViewMessageBtn:(UIButton *)messageBtn;

@end
@interface MeHeaderLoginView : UIView

@property(nonatomic,strong)id<MeHeaderLoginViewDelegate>delegate;
//头像
@property(nonatomic,strong)UIImageView * avatarImageView;

//昵称
@property(nonatomic,strong)UILabel * nickNameLabel;

@property(nonatomic,strong)UIButton * messageButton;

@property (nonatomic,strong)UIImageView * pointImage;

@property (nonatomic) BOOL hiddenPoint;

@property(nonatomic,copy)NSString * imageUrl;

@property (nonatomic,copy)NSString * nickName;

@end
