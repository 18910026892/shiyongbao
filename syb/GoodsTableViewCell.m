//
//  GoodsTableViewCell.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "GoodsTableViewCell.h"

@implementation GoodsTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.goodsImageView];
        
        [self.contentView addSubview:self.goodsNameLabel];
        
        [self.contentView addSubview:self.priceLabel];
        
        [self.contentView addSubview:self.integralLabel];
        
        [self.contentView addSubview:self.shopNameLabel];
        
        [self.contentView addSubview:self.attentionButton];
        
        [self.contentView addSubview:self.platformLabel];
        
        
    }
    
    return self;
}




@end
