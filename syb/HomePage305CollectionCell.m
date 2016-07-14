//
//  HomePage305CollectionCell.m
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "HomePage305CollectionCell.h"

@implementation HomePage305CollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(0, 0, 90*Proportion, 90*Proportion);
        [self.contentView addSubview:_cellImage];
        
        _cellTitle = [[UILabel alloc]init];
        _cellTitle.frame = CGRectMake(0, 90*Proportion, 90*Proportion, 20*Proportion);
        _cellTitle.textAlignment = NSTextAlignmentCenter;
        _cellTitle.textColor = [UIColor blackColor];
        _cellTitle.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_cellTitle];
        
    }
    return self;
}
- (void)setRenzhengmodel:(RenZhengGoodsModel *)renzhengmodel
{
    _renzhengmodel = renzhengmodel;
   
}
@end
