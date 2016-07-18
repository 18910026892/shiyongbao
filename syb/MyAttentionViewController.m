//
//  MyAttentionViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "shopAttentionViewController.h"
#import "goodsAttentionViewController.h"
@implementation MyAttentionViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    [MobClick beginLogPageView:@"我的关注"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"我的关注"];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDatas];
    [self showBackButton:YES];
    
}

-(void)setupDatas
{
    _categoryArray = [NSMutableArray array];
    
    [_categoryArray addObject:@"商品"];
    [_categoryArray addObject:@"店铺"];
    
    
    [self initScroll];
}
-(void)initScroll
{
    if (!smallScrollView) {
        smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-70,22,140, 40)];
        smallScrollView.backgroundColor = [UIColor clearColor];
        smallScrollView.bounces = YES;
        smallScrollView.pagingEnabled = YES;
        smallScrollView.showsHorizontalScrollIndicator = NO;
        smallScrollView.showsVerticalScrollIndicator = NO;
        smallScrollView.opaque = YES;
        
    }
    
    if (!bigScrollView) {
        bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64,SCREEN_WIDTH , SCREEN_HEIGHT-64)];
        bigScrollView.backgroundColor = [UIColor clearColor];
        bigScrollView.bounces = NO;
        bigScrollView.pagingEnabled = YES;
        bigScrollView.showsHorizontalScrollIndicator = NO;
        bigScrollView.showsVerticalScrollIndicator = NO;
        bigScrollView.delegate = self;
        bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,bigScrollView.frame.size.height);
        bigScrollView.scrollEnabled = YES;
        
        
        
        
        
        
    }
    
    
    [self addController];
    [self addLable];
    
    
    // 添加默认控制器
    goodsAttentionViewController * vc = [self.childViewControllers firstObject];
    vc.view.frame = bigScrollView.bounds;
    [bigScrollView addSubview:vc.view];
    
    
    ShopsTitle *lable = [smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    
    [self.view addSubview:bigScrollView];
    [self.Customview addSubview:smallScrollView];
    
}
-(void)addController
{

    
    goodsAttentionViewController * goodsVc = [goodsAttentionViewController viewController];
    [self addChildViewController:goodsVc];
    
    
    shopAttentionViewController * shopVC = [shopAttentionViewController viewController];
    [self addChildViewController:shopVC];
    
    
}
/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < [_categoryArray count]; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
       attentionLabel *lbl1 = [[attentionLabel alloc]init];
        lbl1.text = [_categoryArray objectAtIndex:i];
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    smallScrollView.contentSize = CGSizeMake(70 * 2, 0);
    
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    ShopsTitle *titlelable = (ShopsTitle *)recognizer.view;
    CGFloat offsetX = titlelable.tag * bigScrollView.frame.size.width;
    CGFloat offsetY = bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [bigScrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x /bigScrollView.frame.size.width;
    // 滚动标题栏
    attentionLabel *titleLable = (attentionLabel *)smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax =smallScrollView.contentSize.width -smallScrollView.frame.size.width;
    
    
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx,smallScrollView.contentOffset.y);
    [smallScrollView setContentOffset:offset animated:YES];
    
    // 添加控制器
     BaseViewController * Vc = self.childViewControllers[index];

    
    [smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            attentionLabel *temlabel = smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }else if (idx==index)
        {
            attentionLabel *temlabel = smallScrollView.subviews[idx];
            temlabel.scale = 1.0;
        }
    }];
    
    if (Vc.view.superview) return;
    Vc.view.frame = scrollView.bounds;
    [bigScrollView addSubview:Vc.view];

}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    attentionLabel *labelLeft = smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex <smallScrollView.subviews.count) {
        attentionLabel *labelRight = smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}

@end
