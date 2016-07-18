//
//  OrderGoodsCell.h
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItem.h"

@interface OrderGoodsCell : UITableViewCell

@property (nonatomic,strong)OrderItem * orderItem;

@property (nonatomic,strong)UIImageView * goodsImage;
@property (nonatomic,strong)UILabel * goodsName;
@property (nonatomic,strong)UILabel * goodsPrice;
@property (nonatomic,strong)UILabel * goodsintegral;

@end
