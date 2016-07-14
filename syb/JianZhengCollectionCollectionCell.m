//
//  JianZhengCollectionCollectionCell.m
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "JianZhengCollectionCollectionCell.h"

@implementation JianZhengCollectionCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
        
    }
    return self;
}

//初始化数据模型
- (void)setToupiaoModel:(TouPiaoModel *)toupiaoModel
{
    _toupiaoModel = toupiaoModel;
    
    _cellImage = [[UIImageView alloc]init];
    _cellImage.frame = CGRectMake(0, 0, 90*Proportion, 90*Proportion);
    [self.contentView addSubview:_cellImage];
    
    _cellTitle = [[UILabel alloc]init];
    _cellTitle.frame = CGRectMake(0, 90*Proportion, 90*Proportion, 20);
    _cellTitle.textAlignment = NSTextAlignmentCenter;
    _cellTitle.textColor = [UIColor blackColor];
    _cellTitle.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_cellTitle];
    
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.frame = CGRectMake(0, 90*Proportion+20, 90*Proportion, 20);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = [UIColor grayColor];
    _countLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_countLabel];
    
    _rankLabel = [[UILabel alloc]init];
    _rankLabel.frame = CGRectMake(0, 0, 40,20);
    _rankLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_rankLabel];
    
    _horizontalLabel = [[UILabel alloc]init];
    _horizontalLabel.frame = CGRectMake(-10, 90*Proportion+45, 90*Proportion+20, .5);
    _horizontalLabel.backgroundColor = RGBACOLOR(150,150,150,1);
    
    [self.contentView addSubview:_horizontalLabel];
    
    _verticalLabel = [[UILabel alloc]init];
    _verticalLabel.frame = CGRectMake(90*Proportion+10, -5, .5, 90*Proportion+52);
    _verticalLabel.backgroundColor = RGBACOLOR(150,150,150,1);
    [self.contentView addSubview:_verticalLabel];
}





@end
