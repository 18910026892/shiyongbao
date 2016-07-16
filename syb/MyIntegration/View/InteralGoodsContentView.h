//
//  InteralGoodsContentView.h
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InteralGoodsModel;
@protocol InteralGoodsContentViewDelegate <NSObject>

- (void)itemDidClicked:(InteralGoodsModel *)goods;

@end

@interface InteralGoodsContentView : UIView
@property (strong,nonatomic) NSArray *datas;
@property (nonatomic,assign)id<InteralGoodsContentViewDelegate> delegate;
@end
