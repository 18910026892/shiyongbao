//
//  OrderGoodsCell.m
//  syb
//
//  Created by GongXin on 16/7/12.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "OrderGoodsCell.h"

@implementation OrderGoodsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        [self.contentView addSubview:self.goodsImage];
        [self.contentView addSubview:self.goodsName];
        [self.contentView addSubview:self.goodsPrice];
        [self.contentView addSubview:self.goodsintegral];
    }
    return self;
}

-(UIImageView*)goodsImage
{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc]init];
        _goodsImage.frame = CGRectMake(10, 10, 80, 80);
        _goodsImage.backgroundColor = [UIColor whiteColor];
    }
    return _goodsImage;
}

-(UILabel*)goodsName
{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-120, 40)];
        _goodsName.textColor = [UIColor blackColor];
        _goodsName.font = [UIFont systemFontOfSize:15.0];
        _goodsName.textAlignment = NSTextAlignmentLeft;
        _goodsName.numberOfLines = 2;
        _goodsName.lineBreakMode = NSLineBreakByCharWrapping;
        _goodsName.backgroundColor = [UIColor clearColor];
    }
    return _goodsName;
}
-(UILabel*)goodsPrice
{
    if (!_goodsPrice) {
        _goodsPrice = [UILabel labelWithFrame:CGRectMake(110,60, 100, 20) text:@"" textColor:ThemeColor font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
    }
    return _goodsPrice;
}
-(UILabel*)goodsintegral
{
    if (!_goodsintegral) {
        _goodsintegral = [UILabel labelWithFrame:CGRectMake(210,60, 80, 20) text:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:[UIColor purpleColor] alignment:NSTextAlignmentLeft];
        
    }
    
    
    return _goodsintegral;
}


-(void)setOrderItem:(OrderItem *)orderItem
{
    _orderItem = orderItem;
    
    NSString * imageUrl = orderItem.pict_url;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    self.goodsName.text = orderItem.auction_title;
    
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%@" , orderItem.real_pay];
    
    self.goodsintegral.text = [NSString stringWithFormat:@"积分:%@" ,orderItem.obtain_point];
    
    [self.goodsintegral sizeToFit];
    
    self.goodsintegral.layer.cornerRadius = 3;
}

@end
