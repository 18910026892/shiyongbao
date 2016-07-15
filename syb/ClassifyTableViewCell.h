//
//  ClassifyTableViewCell.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassifyTableModel.h"

@interface ClassifyTableViewCell : UITableViewCell

//对应的数据模型
@property (nonatomic,strong)ClassifyTableModel * ClassifyModel;

@end
