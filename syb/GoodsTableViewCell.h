//
//  GoodsTableViewCell.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "good320Model.h"
@interface GoodsTableViewCell : UITableViewCell

@property(nonatomic,strong)good320Model * goodsModel;

@property(nonatomic,strong)UIImageView * goodsImageView;

@property (nonatomic,strong)UILabel * goodsNameLabel;

@property (nonatomic,strong)UILabel * priceLabel;

@property (nonatomic,strong)UILabel * integralLabel;

@property (nonatomic,strong)UILabel * shopNameLabel;

@property (nonatomic,strong)UIButton * attentionButton;

@property (nonatomic,strong)UILabel * platformLabel;

@end
