//
//  ShopsAllViewController.h
//  syb
//
//  Created by GongXin on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopsTitle.h"
@interface ShopsAllViewController : BaseViewController
<UIScrollViewDelegate>
{
    UIScrollView * bigScrollView;
    UIScrollView *smallScrollView;
    UIButton * backButton;
}
//标题数组
@property (nonatomic,strong)NSMutableArray * TitleArray;
//分类ID数组
@property (nonatomic,strong)NSMutableArray * catIdArray;
//分类数组(总)
@property(nonatomic,strong)NSMutableArray * categoryArray;
@end
