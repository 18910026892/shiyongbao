//
//  BrandCell.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "brandModel.h"
@interface BrandCell : UITableViewCell

@property (nonatomic,strong)brandModel * model;

@property (nonatomic,strong)UIImageView * cellImage;

@property (nonatomic,strong)UIView * grayView;

@end
