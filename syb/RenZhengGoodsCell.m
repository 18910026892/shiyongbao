//
//  RenZhengGoodsCell.m
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "RenZhengGoodsCell.h"

@implementation RenZhengGoodsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setRenzhengmodel:(RenZhengGoodsModel *)renzhengmodel
{
    _renzhengmodel = renzhengmodel;
    
    // Initialization code
    _goodsImage = [[UIImageView alloc]init];
    _goodsImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 128*Proportion);
    _goodsImage.backgroundColor = [UIColor clearColor];
    NSString * goodsImageUrl = renzhengmodel.goods_logo;
    UIImage * noimage = [UIImage imageNamed:@"zhengpintianchong"];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
  
    [self.contentView addSubview:_goodsImage];
    
    _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(0, 128*Proportion-20*Proportion, SCREEN_WIDTH, 20*Proportion)];
    _goodsName.textColor = [UIColor whiteColor];
    _goodsName.font = [UIFont systemFontOfSize:15.0];
    _goodsName.textAlignment = NSTextAlignmentLeft;
    _goodsName.backgroundColor = RGBACOLOR(1, 1, 1,.6);
    _goodsName.text = [NSString stringWithFormat:@"     %@",renzhengmodel.logo_title];
    [self.contentView addSubview:_goodsName];
    
    
    
}
@end
