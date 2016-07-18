//
//  shopAttentionCell.h
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shopAttentionModel.h"
@class shopAttentionCell;

@protocol shopAttentionCellDelegate <NSObject>

@optional
-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;
-(void)goodsButtonClickWithDict:(NSDictionary*)dict;

@end

@interface shopAttentionCell : UITableViewCell

@property(nonatomic,strong)shopAttentionModel * shopsModel;

@property (weak, nonatomic) id <shopAttentionCellDelegate> delegate;

//平台来源
@property (nonatomic,strong)UIImageView * platform;
//店铺名称
@property (nonatomic,strong)UILabel * shopName;

//关注按钮
@property (nonatomic,strong)UIButton * AttentionButton;
//关注的人数量
@property (nonatomic,strong)UILabel * AttentionCount;
//店铺的商品图片
@property (nonatomic,strong)UIButton * goodsImage;

//点击按钮
@property (nonatomic,strong)UIImageView * clickImage;

//线条
@property (nonatomic,strong)UILabel * cellLine;

//线条1
@property (nonatomic,strong)UILabel * cellLine1;


@end
