//
//  ShopsCell.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsCell.h"

@implementation ShopsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setShopsModel:(ShopsModel *)shopsModel
{
    _shopsModel = shopsModel;
    
     UIImage * image = [UIImage imageNamed:@"noimage"];
    
    //平台来源
    _platform = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 40,40)];
    NSString * platform = shopsModel.shop_logo;
    [_platform sd_setImageWithURL:[NSURL URLWithString:platform] placeholderImage:image];
    
    //店铺名称
    _shopName = [[UILabel alloc]initWithFrame:CGRectMake(60,10, SCREEN_WIDTH/2-60, 20)];
    _shopName.text = shopsModel.shop_name;
    _shopName.textColor = [UIColor blackColor];
    _shopName.font = [UIFont systemFontOfSize:14.0];
    _shopName.textAlignment = NSTextAlignmentLeft;
    
    
    _AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _AttentionButton.frame = CGRectMake(SCREEN_WIDTH-140,15, 60, 30);
    _AttentionButton.layer.borderWidth = .5;
    _AttentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
     _AttentionButton.layer.cornerRadius = 7.5;
    _AttentionButton.backgroundColor = [UIColor whiteColor];
    
    NSString * buttonTitle;
    
    if ([shopsModel.user_id isEmpty]) {
        buttonTitle = @"+关注";
        
           [_AttentionButton setTitleColor:HexRGBAlpha(0xf02f70, 1) forState:UIControlStateNormal];
        
    }else
    {
         buttonTitle = @"已关注";
        
         [_AttentionButton setTitleColor:HexRGBAlpha(0x999999, 1) forState:UIControlStateNormal];
        
    }

     [_AttentionButton setTitle:buttonTitle forState:UIControlStateNormal];
    _AttentionButton.tag = [shopsModel.tag integerValue];
 
    _AttentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_AttentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    

    //中间那根线
    _cellLine = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20,.5)];
    _cellLine.backgroundColor = RGBACOLOR(210,210,210,.5);
    
    
    
    
    //Cell提示点击
    _clickImage = [[UIImageView alloc]init];
    _clickImage.frame = CGRectMake(kMainScreenWidth-60, 22.5, 41, 15);
    _clickImage.image = [UIImage imageNamed:@"goshop"];
    

    
    for (int i=0; i<3; i++) {
        _goodsImageView = [[UIImageView alloc]init];
        _goodsImageView.frame = CGRectMake(kMainScreenWidth/3*i, 60, kMainScreenWidth/3-0.5, kMainScreenWidth/3);
        _goodsImageView.backgroundColor = [UIColor whiteColor];
        
        _goodsImageView.image = image;
        
        [self.contentView addSubview:_goodsImageView];
    }
    
    
    
    
    NSInteger GoodsCount = [_shopsModel.recommend_goods count];
    
    if (GoodsCount!=0) {
        for (int i=0; i<GoodsCount; i++) {
            _goodsImage = [UIButton buttonWithType:UIButtonTypeCustom];
            _goodsImage.frame = CGRectMake(kMainScreenWidth/3*i, 60, kMainScreenWidth/3-0.5, kMainScreenWidth/3);
            _goodsImage.backgroundColor = [UIColor whiteColor];
            
            
            NSString * imageUrl = [_shopsModel.recommend_goods[i] valueForKey:@"goods_img_url"];
      
    
            
            [_goodsImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal];
            
            [_goodsImage addTarget:self action:@selector(goodsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            _goodsImage.tag = i;
            [self.contentView addSubview:_goodsImage];
        }

    }

    for (int i=1; i<3; i++) {
        _cellLine1 = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/3*i, 60, 0.5,kMainScreenWidth/3)];
        _cellLine1.backgroundColor = RGBACOLOR(210,210,210,.5);
        [self.contentView addSubview:_cellLine1];
    }
    
    
    //三张图片
    [self.contentView addSubview:_platform];
    [self.contentView addSubview:_shopName];
    [self.contentView addSubview:_AttentionButton];
    [self.contentView addSubview:_AttentionCount];
    [self.contentView addSubview:_cellLine];
    [self.contentView addSubview:_clickImage];


    

}
-(void)goodsButtonClick:(UIButton*)sender;
{
    UIButton * btn = (UIButton*)sender;
    
    
    if (_delegate) {

        [self.delegate goodsButtonClickWithDict:_shopsModel.recommend_goods[btn.tag]];
    }
}

-(void)attentionButtonClick:(UIButton*)sender;
{
    UIButton * btn = (UIButton*)sender;
    
    
    if (_delegate) {
        
        [self.delegate attentionButtonClick:btn clickedWithData:_shopsModel];
    }
}


@end
