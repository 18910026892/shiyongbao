//
//  BaseCell.m
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+(id)loadFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
}

+(NSString*)cellIdentifier
{
    return NSStringFromClass(self);
}

+(id)loadFromCellStyle:(UITableViewCellStyle)cellStyle{
    
    return [[self alloc] initWithStyle:cellStyle reuseIdentifier:NSStringFromClass(self)];
}

- (void)awakeFromNib
{
    //    self.contentView.backgroundColor = [UIColor whiteColor];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
