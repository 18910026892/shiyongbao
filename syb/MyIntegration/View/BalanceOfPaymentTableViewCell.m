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
    [self setUpUI];
}
- (void)setUpUI
{
    NSTimeInterval timeInterval = self.data.adjust_date.doubleValue;
    self.date.text = [self getDateByTimeInterval:timeInterval];
    self.orderNumber.text = self.data.rel_order_id;
    self.integral.text = [NSString stringWithFormat:@"%@积分",self.data.point_num];
}
- (NSString *)getDateByTimeInterval:(NSTimeInterval)stamp
{
    stamp = stamp/1000;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM.dd"];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
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
