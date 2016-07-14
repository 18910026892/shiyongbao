//
//  ZhengpinDetailCollectionViewCell.m
//  syb
//
//  Created by GongXin on 16/4/11.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengpinDetailCollectionViewCell.h"

@implementation ZhengpinDetailCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, 80*Proportion,80*Proportion);
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}
@end
