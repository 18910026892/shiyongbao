//
//  PayTheGasolineTableViewCell.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "PayTheGasolineTableViewCell.h"

@interface PayTheGasolineTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectIV;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end


@implementation PayTheGasolineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.selectIV.backgroundColor = [UIColor blackColor];
    }else{
        self.selectIV.backgroundColor = [UIColor whiteColor];
    }
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.isSelected = selected;
}
-(void)setGasolineNumber:(NSString *)gasolineNumber
{
    _gasolineNumber = gasolineNumber;
    self.number.text = [NSString stringWithFormat:@"卡号: %@",gasolineNumber];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
