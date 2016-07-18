//
//  ProductGoodsCell.h
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductGoodsModel.h"

@class ProductGoodsCell ;

@protocol ProductGoodsCellDelegate <NSObject>

@optional

-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;


@end


@interface ProductGoodsCell : UITableViewCell

@property (weak, nonatomic) id <ProductGoodsCellDelegate> delegate;

@property(nonatomic,strong)ProductGoodsModel * goodsModel;

@property(nonatomic,strong)UIImageView * goodsImageView;

@property (nonatomic,strong)UILabel * goodsNameLabel;

@property (nonatomic,strong)UILabel * priceLabel;

@property (nonatomic,strong)UILabel * integralLabel;

@property (nonatomic,strong)UILabel * shopNameLabel;

@property (nonatomic,strong)UIButton * attentionButton;

@property (nonatomic,strong)UILabel * platformLabel;
@end
