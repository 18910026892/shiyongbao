//
//  ZhenPin312Cell.m
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhenPin312Cell.h"

@implementation ZhenPin312Cell
- (void)setZhengpinModel:(ZhenPin312Model *)zhengpinModel;
{
    _zhengpinModel = zhengpinModel;
    
    _cellImage = [[UIImageView alloc]init];
    _cellImage.frame = CGRectMake(10, 10, 80, 80);
    _cellImage.backgroundColor = [UIColor whiteColor];
    _cellImage.layer.cornerRadius = 3;
    _cellImage.layer.masksToBounds = YES;
    _cellImage.layer.borderWidth = .5;
     _cellImage.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
    
    NSString * goodsImageUrl = zhengpinModel.main_image;
    
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [_cellImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    
    [self.contentView addSubview:_cellImage];
    
    
    _CategoryLabel = [[UILabel alloc]init];
    _CategoryLabel.frame = CGRectMake(100, 10, 80, 20);
    _CategoryLabel.text = _zhengpinModel.cat_name;
    _CategoryLabel.font = [UIFont systemFontOfSize:12];
    _CategoryLabel.textColor = ThemeColor;
    _CategoryLabel.backgroundColor = RGBACOLOR(241, 241, 241, 1);
    _CategoryLabel.layer.cornerRadius = 5;
    _CategoryLabel.layer.masksToBounds = YES;
    _CategoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_CategoryLabel];
   
    
    _cellTitle = [[UILabel alloc]init];
    _cellTitle.frame = CGRectMake(100, 32, SCREEN_WIDTH-120, 40);
    _cellTitle.text = _zhengpinModel.short_title;
    _cellTitle.numberOfLines = 2;
    _cellTitle.font = [UIFont systemFontOfSize:14];
    _cellTitle.textColor = [UIColor blackColor];
    [self.contentView addSubview:_cellTitle];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.frame = CGRectMake(SCREEN_WIDTH-90, 10, 80, 20);
    _dateLabel.textColor = RGBACOLOR(175, 175, 175, 1);
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.text = _zhengpinModel.create_date;
    [self.contentView addSubview:_dateLabel];
    
    _completionLabel = [[UILabel alloc]init];
    _completionLabel.textColor = [UIColor grayColor];
    _completionLabel.frame = CGRectMake(100, 70, 50, 20);
    _completionLabel.font = [UIFont systemFontOfSize:12];
    _completionLabel.text = @"完成度";
    [self.contentView addSubview:_completionLabel];
    
    
    for (int i =0 ; i<4; i++) {
    
    
        _stateLabel1 = [[UILabel alloc]init];
        _stateLabel1.frame = CGRectMake(150+i*25, 78, 20, 4);
        _stateLabel1.backgroundColor = RGBACOLOR(234, 234, 234, 1);
        [self.contentView addSubview:_stateLabel1];
        
    }
    
    int j = [_zhengpinModel.qa_status intValue];
    
    for (int i =0 ; i<j; i++) {
        
        _stateLabel2 = [[UILabel alloc]init];
        _stateLabel2.frame = CGRectMake(150+i*25, 78, 20, 4);
        _stateLabel2.backgroundColor = ThemeColor;
        [self.contentView addSubview:_stateLabel2];
        
    }
    
}
@end
