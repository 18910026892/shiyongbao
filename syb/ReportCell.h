//
//  ReportCell.h
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportModel.h"
@interface ReportCell : UICollectionViewCell

@property (nonatomic,strong)ReportModel * reportModel;
@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UILabel * cellTitle;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * CategoryLabel;
//水平线
@property (nonatomic,strong)UILabel * horizontalLabel;
//竖直线条
@property (nonatomic,strong)UILabel * verticalLabel;

@end
