//
//  ReportCell.m
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportCell.h"

@implementation ReportCell
- (void)setReportModel:(ReportModel *)reportModel
{
    _reportModel = reportModel;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(30*Proportion, 20*Proportion, 80*Proportion, 80*Proportion);
        _cellImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellImage];
        

        _cellTitle = [[UILabel alloc]init];
        _cellTitle.frame = CGRectMake(10,120*Proportion, 140*Proportion-20, 40*Proportion);
       
        _cellTitle.numberOfLines = 2;
        _cellTitle.font = [UIFont systemFontOfSize:14];
        _cellTitle.textColor = [UIColor blackColor];
        [self.contentView addSubview:_cellTitle];
        
        
        _CategoryLabel = [[UILabel alloc]init];
        _CategoryLabel.frame = CGRectMake(0, 170*Proportion, 60, 20);
      
        _CategoryLabel.font = [UIFont systemFontOfSize:12];
        _CategoryLabel.textColor = ThemeColor;
        _CategoryLabel.backgroundColor = RGBACOLOR(241, 241, 241, 1);
        _CategoryLabel.layer.cornerRadius = 5;
        _CategoryLabel.layer.masksToBounds = YES;
        _CategoryLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_CategoryLabel];
        
        
        
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.frame = CGRectMake(65, 170*Proportion, 80*Proportion, 20);
        _dateLabel.textColor = RGBACOLOR(175, 175, 175, 1);
        _dateLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_dateLabel];
        
        //水平线
        _horizontalLabel = [[UILabel alloc]init];
        _horizontalLabel.frame = CGRectMake(-10*Proportion, 200*Proportion, SCREEN_WIDTH/2, .5);
        _horizontalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        
         [self.contentView addSubview:_horizontalLabel];
        //竖直线
        _verticalLabel = [[UILabel alloc]init];
        _verticalLabel.frame = CGRectMake(SCREEN_WIDTH/2, -10*Proportion, .5, 200*Proportion+20);
        _verticalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        
         [self.contentView addSubview:_verticalLabel];
    }
    return self;
}



@end
