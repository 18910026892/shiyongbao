//
//  ShopsTitle.m
//  syb
//
//  Created by GX on 15/10/29.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopsTitle.h"

@implementation ShopsTitle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
        
    }
    return self;
}
/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale*.9 green:scale*.06 blue:scale*0.36 alpha:1];
    CGFloat minScale = 0.8;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}
@end
