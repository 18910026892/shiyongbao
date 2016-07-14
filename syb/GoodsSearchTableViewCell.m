//
//  GoodsSearchTableViewCell.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GoodsSearchTableViewCell.h"

@implementation GoodsSearchTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setGoodsModel:(GoodsSearchModel *)GoodsModel
{
    _GoodsModel = GoodsModel;
    
    // Initialization code
    _goodsImage = [[UIImageView alloc]init];
    _goodsImage.frame = CGRectMake(5, 5, 90, 90);
    _goodsImage.backgroundColor = [UIColor whiteColor];
    NSString * goodsImageUrl = GoodsModel.goods_img_url;
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
    _goodsName.text = [NSString stringWithFormat:@"%@",GoodsModel.goods_name];
    [self.contentView addSubview:_goodsName];
    
    
    _goodsFrom = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 70, 60, 20)];
    _goodsFrom.textColor = ThemeColor;
    _goodsFrom.font = [UIFont systemFontOfSize:15.0];
    _goodsFrom.textAlignment = NSTextAlignmentRight;
    _goodsFrom.backgroundColor = [UIColor clearColor];
    _goodsFrom.text = [NSString stringWithFormat:@"%@",GoodsModel.site_name];
    [self.contentView addSubview:_goodsFrom];
    
    
    
    _goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 100, 20)];
    _goodsPrice.textColor = [UIColor redColor];
    _goodsPrice.font = [UIFont systemFontOfSize:14.0];
    _goodsPrice.textAlignment = NSTextAlignmentLeft;
    _goodsPrice.numberOfLines = 2;
    _goodsPrice.lineBreakMode = NSLineBreakByCharWrapping;
    _goodsPrice.backgroundColor = [UIColor clearColor];
    
    float  money = [GoodsModel.goods_price floatValue];
    _goodsPrice.text = [NSString stringWithFormat:@"￥%.2f元",money];
    [self.contentView addSubview:_goodsPrice];
    
    
    
    _goodsintegral = [UILabel labelWithFrame:CGRectMake(210,50, 100, 20) text:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:KContentFont size:14]  backgroundColor:[UIColor purpleColor] alignment:NSTextAlignmentLeft];
 
    _goodsintegral.text = [NSString stringWithFormat:@"积分:%@" ,GoodsModel.revert_point];
    
    [_goodsintegral sizeToFit];
    
    [self.contentView addSubview:_goodsintegral];
    
    
    _goodsStore = [UILabel labelWithFrame:CGRectMake(110,
                                                     70,
                                                     kMainScreenWidth-150,
                                                     20) text:GoodsModel.store_name textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];

    [self.contentView addSubview:_goodsStore];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
