//
//  JianZhengCollectionCollectionCell.h
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouPiaoModel.h"
@interface JianZhengCollectionCollectionCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UILabel * cellTitle;
@property (nonatomic,strong)UILabel * rankLabel;
@property (nonatomic,strong)UILabel * countLabel;
//水平线
@property (nonatomic,strong)UILabel * horizontalLabel;
//竖直线条
@property (nonatomic,strong)UILabel * verticalLabel;

@property (nonatomic,strong)TouPiaoModel * toupiaoModel;

@end
