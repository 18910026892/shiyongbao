//
//  StoreTableViewCell.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
@interface StoreTableViewCell : UITableViewCell

@property(nonatomic,strong)StoreModel * StoreModel;

@property(nonatomic,strong)UILabel * cellTitle;


@end
