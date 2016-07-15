//
//  ClassifyCollectionCell.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyCollectionModel.h"
@interface ClassifyCollectionCell : UICollectionViewCell

//对应的数据模型
@property (nonatomic,strong)ClassifyCollectionModel * ClassifyCollectionModel;

//分类图片
@property (nonatomic,strong)UIImageView * ClassifyImage;

//分类名称
@property (nonatomic,strong)UILabel * ClassifyTitle;


@end
