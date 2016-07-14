//
//  BalanceOfPaymentTableViewCell.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BalanceOfPaymentTableViewCell.h"
#import "BalanceOfPaymentModel.h"


@interface BalanceOfPaymentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *integral;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

@end

@implementation BalanceOfPaymentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(BalanceOfPaymentModel *)data
{
    _data = data;
}
-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    self.bottomLineHeight.constant = 0.5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
