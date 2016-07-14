//
//  ClassifyCollectionCell.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ClassifyCollectionCell.h"

@implementation ClassifyCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
//初始化数据模型
- (void)setClassifyColllectionModel:(ClassifyCollectionModel *)ClassifyColllectionModel;
{
   
    _ClassifyCollectionModel = ClassifyColllectionModel;
    
    NSLog(@"^^^^%@",_ClassifyCollectionModel);

}

@end
