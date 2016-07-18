//
//  MyAttentionViewController.h
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "attentionLabel.h"
@interface MyAttentionViewController : BaseViewController

<UIScrollViewDelegate>
{
    UIScrollView * bigScrollView;
    UIScrollView *smallScrollView;
}

//分类数组(总)
@property(nonatomic,strong)NSMutableArray * categoryArray;

@end
