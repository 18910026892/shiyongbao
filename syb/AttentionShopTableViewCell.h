//
//  AttentionShopTableViewCell.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionShopsDto.h"
@class AttentionShopTableViewCell;

@protocol AttentionShopTableViewCellDelegate <NSObject>

@optional

-(void)attentionButtonClick:(NSString*)value;

@end

@interface AttentionShopTableViewCell : UITableViewCell
//数据模型
@property (nonatomic,strong)AttentionShopsDto * attentionShopsModel;

@property (weak, nonatomic) id <AttentionShopTableViewCellDelegate> delegate;

//Cell 的背景视图
@property (nonatomic,strong)UIView * cellBackView;
//平台来源
@property (nonatomic,strong)UIImageView * platform;
//店铺名称
@property (nonatomic,strong)UILabel * shopName;
//质检通过标识
@property (nonatomic,strong)UIImageView * passImage;
//关注按钮
@property (nonatomic,strong)UIButton * AttentionButton;
//关注的人数量
@property (nonatomic,strong)UILabel * AttentionCount;
//店铺的商品图片1
@property (nonatomic,strong)UIImageView * goodsImage;

//线条
@property (nonatomic,strong)UILabel * cellLine;
@end
