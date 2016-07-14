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
        
        [self.contentView addSubview:self.imageView];
        
        
    }
    
    return self;
}



-(UIImageView*)cellImage
{
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(0,0,SCREEN_WIDTH,102*Proportion);
    }
    return _cellImage;
}


-(void)setModel:(brandModel *)model
{
    _model = model;
}

@end
