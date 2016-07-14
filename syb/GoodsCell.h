//
//  GoodsCell.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@interface GoodsCell : UITableViewCell

@property (nonatomic,strong)GoodsModel * GoodsModel;
@property (nonatomic,strong)UIImageView * goodsImage;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * goodsPrice;
@property (nonatomic,strong)UILabel * goodsFrom;
@property (nonatomic,strong)UIImageView * passImage;
@end
