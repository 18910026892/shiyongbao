//
//  CashingTableViewCell.m
//  syb
//
//  Created by 庞珂路 on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "CashingTableViewCell.h"

@interface CashingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;


@property (weak, nonatomic) IBOutlet UIImageView *selectIV;

@end

@implementation CashingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setAccountInfo:(NSDictionary *)accountInfo
{
    NSDictionary *infoDic = [accountInfo objectForKey:@"binding_info"];
    _accountInfo = infoDic;
    NSString *name = [infoDic objectForKey:@"name"];
    NSString *account = [infoDic objectForKey:@"account"];
    self.account.text = [NSString stringWithFormat:@"账号 : %@",account];
    self.name.text = [NSString stringWithFormat:@"姓名 : %@",name];;
}
-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.bottomHeight.constant = 0.5;
}
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.selectIV.hidden = !isSelected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
