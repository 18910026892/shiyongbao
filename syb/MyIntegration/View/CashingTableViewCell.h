//
//  CashingTableViewCell.h
//  syb
//
//  Created by 庞珂路 on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashingTableViewCell : UITableViewCell
@property (strong,nonatomic) NSDictionary *accountInfo;
@property (nonatomic,assign)BOOL isSelected;
@end
