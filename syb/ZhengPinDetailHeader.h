//
//  ZhengPinDetailHeader.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenPin312Model.h"
@class ZhengPinDetailHeader;

@protocol ZhengPinDetailHeaderDelegate <NSObject>

@optional
-(void)stateButtonClick:(UIButton*)sender;

@end


@interface ZhengPinDetailHeader : UIView

@property  NSInteger flag;

@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * imageArray;

@property (nonatomic,strong)NSDictionary * zhiboHeader;

@property (weak, nonatomic) id <ZhengPinDetailHeaderDelegate> delegate;



@property (nonatomic,strong)UILabel * horizontalLabel;

@property (nonatomic,strong)UIImageView * cellImage;

@property (nonatomic,strong)UILabel * cellTitle;

@property (nonatomic,strong)UIButton * stateButton;
@property (nonatomic,strong)UIImageView * arrowImage;



@end
