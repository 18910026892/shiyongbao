//
//  GoodsSearchTableViewCell.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsSearchModel.h"


@class GoodsSearchTableViewCell ;

@protocol GoodsSearchTableViewCellDelegate <NSObject>

@optional

-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;


@end

@interface GoodsSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) id <GoodsSearchTableViewCellDelegate> delegate;


@property (nonatomic,strong)GoodsSearchModel * goodsModel;

@property(nonatomic,strong)UIImageView * goodsImageView;

@property (nonatomic,strong)UILabel * goodsNameLabel;

@property (nonatomic,strong)UILabel * priceLabel;

@property (nonatomic,strong)UILabel * integralLabel;

@property (nonatomic,strong)UILabel * shopNameLabel;

@property (nonatomic,strong)UIButton * attentionButton;

@property (nonatomic,strong)UILabel * platformLabel;

@end
