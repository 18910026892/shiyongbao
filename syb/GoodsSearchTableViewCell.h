//
//  GoodsSearchTableViewCell.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsSearchModel.h"
@interface GoodsSearchTableViewCell : UITableViewCell

@property (nonatomic,strong)GoodsSearchModel * GoodsModel;
@property (nonatomic,strong)UIImageView * goodsImage;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * goodsPrice;
@property (nonatomic,strong)UILabel * goodsStore;
@property (nonatomic,strong)UILabel * goodsFrom;
@property (nonatomic,strong)UILabel * goodsintegral;
@property (nonatomic,strong)UIButton * attentionButton;

@end
