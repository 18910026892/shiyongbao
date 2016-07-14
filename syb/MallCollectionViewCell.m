//
//  MallCollectionViewCell.m
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "MallCollectionViewCell.h"

@implementation MallCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
     

        
        
    }
    return self;
}


//初始化数据模型
- (void)setMallModel:(MallModel *)mallModel;
{
    
    _mallModel = mallModel;
 
    
}

@end
