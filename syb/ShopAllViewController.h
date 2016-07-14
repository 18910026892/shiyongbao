//
//  ShopAllViewController.h
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsTitle.h"
@interface ShopAllViewController : UIViewController<UIScrollViewDelegate>
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
