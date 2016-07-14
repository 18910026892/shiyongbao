//
//  AttentionShopTableViewCell.m
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "AttentionShopTableViewCell.h"

@implementation AttentionShopTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setAttentionShopsModel:(AttentionShopsDto *)attentionShopsModel
{
    _attentionShopsModel = attentionShopsModel;
    
    //平台来源
    _platform = [[UIImageView alloc]initWithFrame:CGRectMake(10,12.5, 40,40)];
    NSString * platform = attentionShopsModel.shop_logo;
    [_platform sd_setImageWithURL:[NSURL URLWithString:platform]];
    
    //店铺名称
    _shopName = [[UILabel alloc]initWithFrame:CGRectMake(60,12.5, SCREEN_WIDTH-90, 20)];
    _shopName.text = attentionShopsModel.shop_name;
    _shopName.textColor = [UIColor blackColor];
    _shopName.font = [UIFont systemFontOfSize:14.0];
    _shopName.textAlignment = NSTextAlignmentLeft;
    
    //质检通过
    _passImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,2.5,79,60)];
    UIImage * passImage = [UIImage imageNamed:@"pass"];
    _passImage.image = passImage;
    
    
    _AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _AttentionButton.frame = CGRectMake(SCREEN_WIDTH-70,5, 60, 30);
    _AttentionButton.layer.borderWidth = .5;
    _AttentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
    _AttentionButton.layer.cornerRadius = 10;
    _AttentionButton.backgroundColor = [UIColor whiteColor];
    [_AttentionButton setTitle:@"取消关注" forState:UIControlStateNormal];
    _AttentionButton.tag = [attentionShopsModel.shop_id integerValue];
    [_AttentionButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    _AttentionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_AttentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _AttentionCount = [[UILabel alloc]init];
    _AttentionCount.frame = CGRectMake(SCREEN_WIDTH-130,40, 120, 20);
    NSString  * userCount = attentionShopsModel.atte_count;
    if ([userCount integerValue] > 10000) {
        userCount = [NSString stringWithFormat:@"共%.1ld万人认为靠谱",[userCount integerValue]/10000];
    }else{
        userCount = [NSString stringWithFormat:@"共%.0ld人认为靠谱",(long)[userCount integerValue]];
    }
    _AttentionCount.text = userCount;
    _AttentionCount.textColor = [UIColor blackColor];
    _AttentionCount.textAlignment = NSTextAlignmentRight;
    _AttentionCount.font = [UIFont systemFontOfSize:12];
    
    
    //中间那根线
    _cellLine = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, SCREEN_WIDTH-20,.5)];
    _cellLine.backgroundColor = RGBACOLOR(210,210,210,.5);
    
    
    //Cell的背景视图
    _cellBackView =  [[UIView alloc]init];
    _cellBackView.frame = CGRectMake(0,5, SCREEN_WIDTH, 170);
    _cellBackView.backgroundColor = [UIColor whiteColor];
    
    
    //三张图片
    _goodsImage = [[UIImageView alloc]init];
    _goodsImage.frame = CGRectMake(0, 72.5, SCREEN_WIDTH, 90*Proportion);
    UIImage * noimage = [UIImage imageNamed:@"shopnoimage"];
    NSString * shopimage = attentionShopsModel.shop_image;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:shopimage] placeholderImage:noimage];
    
    
    [_cellBackView addSubview:_platform];
    [_cellBackView addSubview:_shopName];
    [_cellBackView addSubview:_passImage];
    [_cellBackView addSubview:_AttentionButton];
    [_cellBackView addSubview:_AttentionCount];
    [_cellBackView addSubview:_cellLine];
    [_cellBackView addSubview:_goodsImage];
    
    [self.contentView addSubview:_cellBackView];
    
    
    
    
}

-(void)attentionButtonClick:(UIButton*)sender
{
    UIButton * btn = (UIButton*)sender;
    
    if ([self.delegate respondsToSelector:@selector(attentionButtonClick:)]) {
        
        NSString * tag = [NSString stringWithFormat:@"%ld",(long)btn.tag];
        
        [self.delegate attentionButtonClick:tag];
    }
}

@end
