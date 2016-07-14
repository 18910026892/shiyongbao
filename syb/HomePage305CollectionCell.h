//
//  HomePage305CollectionCell.h
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenZhengGoodsModel.h"
@interface HomePage305CollectionCell : UICollectionViewCell


@property (nonatomic,strong)RenZhengGoodsModel * renzhengmodel;
@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UILabel * cellTitle;;

@end
