//
//  IteralGoodCollectionViewCell.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "IteralGoodCollectionViewCell.h"
#import "ItemViewButton.h"
@interface IteralGoodCollectionViewCell ()
@property (weak, nonatomic) IBOutlet ItemViewButton *itemView;

@end

@implementation IteralGoodCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.itemView.cornerRadius = 5;
    // Initialization code
}
-(void)setGoods:(InteralGoodsModel *)goods
{
    _goods = goods;
    self.itemView.goods = goods;
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.itemView.isSelected = selected;
    self.itemView.money.textColor = HexRGBAlpha(0xf1f1f1,1);
}
@end
