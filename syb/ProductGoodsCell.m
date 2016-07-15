//
//  ProductGoodsCell.m
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ProductGoodsCell.h"

@implementation ProductGoodsCell
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

-(void)setGoodsModel:(ProductGoodsModel *)goodsModel
{
    _goodsModel  = goodsModel;
    
    NSString * goodsImageUrl = goodsModel.goods_img_url;
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    
    
    self.goodsNameLabel.text = goodsModel.goods_name;
    
    NSString * price = [NSString stringWithFormat:@"￥%@",goodsModel.goods_price];
    
    self.priceLabel.text = price;
    
    self.integralLabel.text = [NSString stringWithFormat:@"积分:%@" ,goodsModel.revert_point];
    
    [self.integralLabel sizeToFit];
    
    self.shopNameLabel.text = goodsModel.store_name;
    
    self.platformLabel.text = goodsModel.site_name;
    
}

-(UIImageView*)goodsImageView
{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.frame= CGRectMake(5, 5, 90, 90);
        
    }
    return _goodsImageView;
}

-(UILabel*)goodsNameLabel
{
    if(!_goodsNameLabel)
    {
        _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-170, 40)];
        _goodsNameLabel.textColor = [UIColor blackColor];
        _goodsNameLabel.font = [UIFont systemFontOfSize:15.0];
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
        _goodsNameLabel.numberOfLines = 2;
        _goodsNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _goodsNameLabel.backgroundColor = [UIColor clearColor];
    }
    return _goodsNameLabel;
}

-(UILabel*)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 70, 20)];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceLabel;
}

-(UILabel*)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [UILabel labelWithFrame:CGRectMake(180,50, 70, 20) text:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:[UIColor purpleColor] alignment:NSTextAlignmentLeft];
    }
    return _integralLabel;
    
 
}


-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel = [UILabel labelWithFrame:CGRectMake(110,
                                                         70,
                                                         kMainScreenWidth-150,
                                                         20) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _shopNameLabel;
}

-(UIButton*)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.frame = CGRectMake(SCREEN_WIDTH-70,15, 60, 30);
        _attentionButton.layer.borderWidth = .5;
        _attentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
        _attentionButton.layer.cornerRadius = 10;
        _attentionButton.backgroundColor = [UIColor whiteColor];
        
        NSString * buttonTitle;
        
        if ([_goodsModel.user_id isEmpty]) {
            buttonTitle = @"+关注";
        }else
        {
            buttonTitle = @"已关注";
        }
        
        [_attentionButton setTitle:buttonTitle forState:UIControlStateNormal];

        [_attentionButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    

    }
    return _attentionButton;
}

-(UILabel*)platformLabel
{
    if (!_platformLabel) {
        _platformLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-70,55, 60, 30) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    }
    return _platformLabel;
}

@end
