//
//  CommodityTableViewCell.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
@interface CommodityTableViewCell : UITableViewCell
@property (nonatomic,strong)CommodityModel * CommodityModel;
@property (nonatomic,strong)UIImageView * goodsImage;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * goodsPrice;
@property (nonatomic,strong)UILabel * goodsFrom;
@property (nonatomic,strong)UIImageView * passImage;
@end
