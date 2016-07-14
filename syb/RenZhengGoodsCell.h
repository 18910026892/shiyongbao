//
//  RenZhengGoodsCell.h
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenZhengGoodsModel.h"
@interface RenZhengGoodsCell : UITableViewCell

@property (nonatomic,strong)RenZhengGoodsModel * renzhengmodel;

@property (nonatomic,strong)UIImageView * goodsImage;
@property (nonatomic,strong)UILabel * goodsName;


@end
