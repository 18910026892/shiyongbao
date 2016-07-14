//
//  StoreTableViewCell.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "StoreTableViewCell.h"

@implementation StoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStoreModel:(StoreModel *)StoreModel
{
    _StoreModel = StoreModel;
    
    
    _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(25, 12, SCREEN_WIDTH-50, 20)];
    _cellTitle.backgroundColor = [UIColor clearColor];
    _cellTitle.font = [UIFont systemFontOfSize:14];
    _cellTitle.textAlignment = NSTextAlignmentLeft;
    _cellTitle.textColor = [UIColor blackColor];
  
    NSString * store_name = StoreModel.qt_store_name;
    NSString * pass_str = StoreModel.is_pass_str;
    NSString * infoStr;
    if (store_name&&pass_str) {
        infoStr  = [NSString stringWithFormat:@"%@%@",store_name,pass_str];
    }else
        
    {
        infoStr = @"";
    }
    
    _cellTitle.text = infoStr;
    [self.contentView addSubview:_cellTitle];
    
}



@end
