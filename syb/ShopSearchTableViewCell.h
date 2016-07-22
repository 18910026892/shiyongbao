//
//  ShopSearchTableViewCell.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsSearchModel.h"
@class ShopSearchTableViewCell;

@protocol ShopSearchTableViewCellDelegate <NSObject>

@optional

-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;
-(void)goodsButtonClickWithDict:(NSDictionary*)dict;

@end

@interface ShopSearchTableViewCell : UITableViewCell
//数据模型
@property (nonatomic,strong)ShopsSearchModel * ShopsSearchModel;

@property (weak, nonatomic) id <ShopSearchTableViewCellDelegate> delegate;
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
@property (nonatomic,strong)UIImageView * goodsImageView;
//点击按钮
@property (nonatomic,strong)UIImageView * clickImage;

//线条
@property (nonatomic,strong)UILabel * cellLine;

//线条1
@property (nonatomic,strong)UILabel * cellLine1;


@end
