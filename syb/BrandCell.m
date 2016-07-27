//
//  BrandCell.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "BrandCell.h"

@implementation BrandCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.cellImage];
        
        [self.contentView addSubview:self.grayView];
    }
    
    return self;
}



-(UIImageView*)cellImage
{
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(0,0,kMainScreenWidth,102*Proportion);
    }
    return _cellImage;
}

-(UIView*)grayView
{
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.frame = CGRectMake(0,102*Proportion,kMainScreenWidth,6);
        _grayView.backgroundColor= kDefaultBackgroundColor;
    }
    return _grayView;
}
-(void)setModel:(brandModel *)model
{
    _model = model;
    
    NSString * imageUrl = model.group_img;
    
    [self.cellImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
}

@end
