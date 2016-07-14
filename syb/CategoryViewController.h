//
//  CategoryViewController.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "ShopsTitle.h"
@interface CategoryViewController : UIViewController<UIScrollViewDelegate>
{
    UIButton * backButton;
    UIScrollView * bigScrollView;
    UIScrollView * smallScrollView;
}

//分段控件
@property (strong, nonatomic)HYSegmentedControl *segmentedControl;

//标题数组
@property (nonatomic,strong)NSMutableArray * TitleArray;
//分类ID数组
@property (nonatomic,strong)NSMutableArray * catIdArray;
//分类数组(总)
@property(nonatomic,strong)NSMutableArray * categoryArray;

@property NSInteger selectIndex;


@end
