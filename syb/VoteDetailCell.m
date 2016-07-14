//
//  VoteDetailCell.m
//  syb
//
//  Created by GongXin on 16/3/23.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "VoteDetailCell.h"

@implementation VoteDetailCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH-80, 20)];
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.font = [UIFont systemFontOfSize:14];
        _cellTitle.textAlignment = NSTextAlignmentLeft;
        _cellTitle.textColor = [UIColor grayColor];
        
        
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(SCREEN_WIDTH-50,7, 30, 30);
        _cellImage.image = [UIImage imageNamed:@"pingtaiunselect"];
        _cellImage.layer.cornerRadius = 15;

        
        [self.contentView addSubview:_cellTitle];
        [self.contentView addSubview:_cellImage];
        
    }
    return self;
}
@end
