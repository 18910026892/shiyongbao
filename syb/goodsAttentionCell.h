//
//  goodsAttentionCell.h
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsAttentionModel.h"

@class goodsAttentionCell ;

@protocol goodsAttentionCellDelegate <NSObject>

@optional

-(void)attentionButtonClick:(UIButton*)sender clickedWithData:(id)celldata;


@end


@interface goodsAttentionCell : UITableViewCell

@property (weak, nonatomic) id <goodsAttentionCellDelegate> delegate;

@property (nonatomic,strong)goodsAttentionModel * goodsModel;

@property(nonatomic,strong)UIImageView * goodsImageView;

@property (nonatomic,strong)UILabel * goodsNameLabel;

@property (nonatomic,strong)UILabel * priceLabel;

@property (nonatomic,strong)UILabel * integralLabel;

@property (nonatomic,strong)UILabel * shopNameLabel;

@property (nonatomic,strong)UIButton * attentionButton;

@property (nonatomic,strong)UILabel * platformLabel;



@end
