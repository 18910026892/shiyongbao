//
//  CommodityTableViewCell.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "CommodityTableViewCell.h"

@implementation CommodityTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setCommodityModel:(CommodityModel *)CommodityModel
{
    _CommodityModel = CommodityModel;
    
    // Initialization code
    _goodsImage = [[UIImageView alloc]init];
    _goodsImage.frame = CGRectMake(5, 5, 90, 90);
    _goodsImage.backgroundColor = [UIColor whiteColor];
    NSString * goodsImageUrl = CommodityModel.goods_image;
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    [self.contentView addSubview:_goodsImage];
    
    
    _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-200, 40)];
    _goodsName.textColor = [UIColor blackColor];
    _goodsName.font = [UIFont systemFontOfSize:15.0];
    _goodsName.textAlignment = NSTextAlignmentLeft;
    _goodsName.numberOfLines = 2;
    _goodsName.lineBreakMode = NSLineBreakByCharWrapping;
    _goodsName.backgroundColor = [UIColor clearColor];
    _goodsName.text = [NSString stringWithFormat:@"%@",CommodityModel.goods_title];
    [self.contentView addSubview:_goodsName];
    
    
    _goodsFrom = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 60, 20)];
    _goodsFrom.textColor = ThemeColor;
    _goodsFrom.font = [UIFont systemFontOfSize:15.0];
    _goodsFrom.textAlignment = NSTextAlignmentRight;
    _goodsFrom.backgroundColor = [UIColor clearColor];
    _goodsFrom.text = [NSString stringWithFormat:@"%@",CommodityModel.site_name];
    [self.contentView addSubview:_goodsFrom];
    
    
    
    _goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, SCREEN_WIDTH-200, 20)];
    _goodsPrice.textColor = [UIColor redColor];
    _goodsPrice.font = [UIFont systemFontOfSize:14.0];
    _goodsPrice.textAlignment = NSTextAlignmentLeft;
    _goodsPrice.numberOfLines = 2;
    _goodsPrice.lineBreakMode = NSLineBreakByCharWrapping;
    _goodsPrice.backgroundColor = [UIColor clearColor];
    float  money = [CommodityModel.goods_price floatValue];
    _goodsPrice.text = [NSString stringWithFormat:@"￥%.2f元",money];
    [self.contentView addSubview:_goodsPrice];
    
    
    //质检通过
    _passImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90,30,79,60)];
    UIImage * passImage = [UIImage imageNamed:@"pass"];
    _passImage.image = passImage;
    [self.contentView addSubview:_passImage];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
