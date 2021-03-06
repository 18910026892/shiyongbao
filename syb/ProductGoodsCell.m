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
    

    float price = [goodsModel.goods_price floatValue];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f" , price];
    
    
    float intergral = [goodsModel.revert_point floatValue];
    
    self.integralLabel.text = [NSString stringWithFormat:@" 积分:%.2f " ,intergral];
    
    
    
    
    
    [self.integralLabel sizeToFit];
    
 
    
    
    
    self.shopNameLabel.text = goodsModel.store_name;
    
    self.platformLabel.text = goodsModel.site_name;
    
     self.attentionButton.tag = [goodsModel.tag integerValue];
    
    
    NSString * buttonTitle;
    
    if ([goodsModel.user_id isEmpty]) {
        buttonTitle = @"+关注";
        
        [_attentionButton setTitleColor:HexRGBAlpha(0xf02f70, 1) forState:UIControlStateNormal];
        
    }else
    {
        buttonTitle = @"已关注";
        
            [_attentionButton setTitleColor:HexRGBAlpha(0x999999, 1) forState:UIControlStateNormal];
    }
    
    [self.attentionButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    
}

-(UIImageView*)goodsImageView
{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.frame= CGRectMake(6*Proportion, 6*Proportion, 90*Proportion, 90*Proportion);
        
    }
    return _goodsImageView;
}

-(UILabel*)goodsNameLabel
{
    if(!_goodsNameLabel)
    {
        _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(110*Proportion, 6*Proportion, SCREEN_WIDTH-120*Proportion, 40)];
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
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(110*Proportion, 47*Proportion, kMainScreenWidth-180*Proportion, 15)];
        _priceLabel.textColor = HexRGBAlpha(0xf02f70, 1);
        _priceLabel.font = [UIFont systemFontOfSize:15.0];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceLabel;
}

-(UILabel*)integralLabel
{
    if (!_integralLabel) {
        _integralLabel = [UILabel labelWithFrame:CGRectMake(110*Proportion,65*Proportion,kMainScreenWidth-180*Proportion, 15) text:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:HexRGBAlpha(0x6766ff, 1) alignment:NSTextAlignmentLeft];
        _integralLabel.layer.cornerRadius = 2;
        _integralLabel.layer.masksToBounds = YES;
        
    }
    return _integralLabel;
    
 
}


-(UILabel*)shopNameLabel
{
    if (!_shopNameLabel) {
        _shopNameLabel = [UILabel labelWithFrame:CGRectMake(110*Proportion,
                                                         83*Proportion,
                                                         kMainScreenWidth-150*Proportion,
                                                         20) text:@"" textColor:HexRGBAlpha(0x444444, 1) font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _shopNameLabel;
}

-(UIButton*)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.frame = CGRectMake(SCREEN_WIDTH-70,45*Proportion, 58, 28);
        _attentionButton.layer.borderWidth = .5;
        _attentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
        _attentionButton.layer.cornerRadius = 6;
        _attentionButton.backgroundColor = [UIColor whiteColor];

        [_attentionButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    

    }
    return _attentionButton;
}

-(UILabel*)platformLabel
{
    if (!_platformLabel) {
        _platformLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-70,83*Proportion, 60, 15) text:@"" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    }
    return _platformLabel;
}
-(void)attentionButtonClick:(UIButton*)sender;
{
    UIButton * btn = (UIButton*)sender;
    
    
    if (_delegate) {
        
        [self.delegate attentionButtonClick:btn clickedWithData:_goodsModel];
    }
}

@end
