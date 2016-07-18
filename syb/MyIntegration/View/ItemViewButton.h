//
//  ItemViewButton.h
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteralGoodsModel.h"
@interface ItemViewButton : UIView
@property (nonatomic,assign)BOOL isSelected;
@property (strong,nonatomic) InteralGoodsModel *goods;
@end
