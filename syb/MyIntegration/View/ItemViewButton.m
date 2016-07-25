//
//  ItemViewButton.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ItemViewButton.h"

@interface ItemViewButton ()

@property (weak, nonatomic) IBOutlet UILabel *interal;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ItemViewButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        UIView *containerView = [[[UINib nibWithNibName:@"ItemViewButton" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}
-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
//    if (isSelected) {
//        self.contentView.borderColor = [UIColor redColor];
//        self.contentView.borderWidth = 1;
//    }else{
//        self.contentView.borderWidth = 0;
//    }
}
-(void)setGoods:(InteralGoodsModel *)goods
{
    _goods = goods;
    self.money.text = [NSString stringWithFormat:@"%@元",goods.gift_trade_price];
    self.interal.text = [NSString stringWithFormat:@"需要%@积分",goods.gift_price];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
