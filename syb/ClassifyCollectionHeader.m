//
//  ClassifyCollectionHeader.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ClassifyCollectionHeader.h"

@implementation ClassifyCollectionHeader
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //图片视图
        _HeaderLabel = [[UILabel alloc]initWithFrame:self.frame];
        _HeaderLabel.backgroundColor = [UIColor clearColor];
        _HeaderLabel.textAlignment = NSTextAlignmentLeft;
        _HeaderLabel.font = [UIFont systemFontOfSize:12.0];
        _HeaderLabel.textColor = [UIColor grayColor];
        
        [self addSubview:_HeaderLabel];
        
        
    }
    return self;
}

-(void)setHeader:(NSString *)header
{
    _header = header;
    self.HeaderLabel.text = header;
}

@end
