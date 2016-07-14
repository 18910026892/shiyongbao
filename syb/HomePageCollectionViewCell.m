//
//  HomePageCollectionViewCell.m
//  syb
//
//  Created by GX on 15/11/4.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "HomePageCollectionViewCell.h"

@implementation HomePageCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _HeaderImage = [[UIImageView alloc]init];
        _HeaderImage.frame = CGRectMake(0, -5, SCREEN_WIDTH/2-10, 52*Proportion);
        _HeaderImage.backgroundColor = [UIColor clearColor];
        _HeaderImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_HeaderImage];
        
    }
    return self;
}
@end
