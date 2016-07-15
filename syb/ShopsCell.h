//
//  ShopsCell.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsModel.h"
@class ShopsCell;

@protocol ShopsCellDelegate <NSObject>

@optional
-(void)attentionButtonClick:(UIButton*)sender ;
-(void)goodsButtonClickWithDict:(NSDictionary*)dict;

@end

@interface ShopsCell : UITableViewCell
//数据模型
@property (nonatomic,strong)ShopsModel * shopsModel;

@property (weak, nonatomic) id <ShopsCellDelegate> delegate;

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
