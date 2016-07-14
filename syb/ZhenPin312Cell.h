//
//  ZhenPin312Cell.h
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenPin312Model.h"
@interface ZhenPin312Cell : UITableViewCell

@property (nonatomic,strong)ZhenPin312Model * zhengpinModel;
@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UILabel * CategoryLabel;
@property (nonatomic,strong)UILabel * cellTitle;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * completionLabel;
@property (nonatomic,strong)UILabel * stateLabel1;
@property (nonatomic,strong)UILabel * stateLabel2;

@end
