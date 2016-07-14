//
//  ShopAllViewController.m
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ShopAllViewController.h"
#import "ShopViewController.h"
#import "ClassifyViewController.h"
@implementation ShopAllViewController
- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"网商汇";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"^^^%@",_categoryArray);
    [self PageSetup];
    //[self initBackButton];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@NO];
}

-(void)initBackButton
{
    if (!backButton) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.navigationController.navigationBar addSubview:backButton];
}
-(void)backButtonClick:(UIButton*)sender
{
 
    
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];

}

//页面设置
-(void)PageSetup
{
 
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self addData];
 
    
}

-(void)addData
{

    
    NSDictionary * dict1 = @{ @"cat_id" : @"101", @"cat_name" : @"跨境美妆"};
    NSDictionary * dict2 = @{ @"cat_id" : @"109", @"cat_name" : @"跨境母婴"};
    
    
    _categoryArray = [NSMutableArray array];
    
    [_categoryArray addObjectsFromArray:[UserDefaultsUtils valueWithKey:@"shopCatList"]];
    
    if ([_categoryArray count]==0) {
        [_categoryArray removeAllObjects];
        [_categoryArray addObject:dict1];
        [_categoryArray addObject:dict2];
    }

    
    _catIdArray = [NSMutableArray array];
    _TitleArray = [NSMutableArray array];
        
    for (NSDictionary * dict in _categoryArray) {
            NSString * catid = [dict valueForKey:@"cat_id"];
            NSString * title = [dict valueForKey:@"cat_name"];
            
            [_catIdArray addObject:catid];
            [_TitleArray addObject:title];
    }

    
    
    [self initScroll];

}


-(void)initScroll
{
    if (!smallScrollView) {
        smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64,SCREEN_WIDTH , 40)];
        smallScrollView.backgroundColor = [UIColor whiteColor];
        smallScrollView.bounces = YES;
        smallScrollView.pagingEnabled = YES;
        smallScrollView.showsHorizontalScrollIndicator = NO;
        smallScrollView.showsVerticalScrollIndicator = NO;
        smallScrollView.opaque = YES;
        
    }

    if (!bigScrollView) {
        bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,104,SCREEN_WIDTH , SCREEN_HEIGHT-104)];
        bigScrollView.backgroundColor = [UIColor clearColor];
        bigScrollView.bounces = NO;
        bigScrollView.pagingEnabled = YES;
        bigScrollView.showsHorizontalScrollIndicator = NO;
        bigScrollView.showsVerticalScrollIndicator = NO;
        bigScrollView.delegate = self;
        bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*[_categoryArray count],bigScrollView.frame.size.height);
        bigScrollView.scrollEnabled = YES;
        
        


        

    }
  

    [self addController];
    [self addLable];
    
    
    // 添加默认控制器
    ShopViewController * vc = [self.childViewControllers firstObject];
    vc.view.frame = bigScrollView.bounds;
    vc.cat_id1 = _catIdArray[0];
    [bigScrollView addSubview:vc.view];
    
    
    ShopsTitle *lable = [smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    
    [self.view addSubview:bigScrollView];
    [self.view addSubview:smallScrollView];
    
}
-(void)addController
{
    
    for (int i=0 ; i<[_catIdArray count] ;i++){
        ShopViewController * shopVC = [[ShopViewController alloc]init];
        shopVC.cat_id1 = _catIdArray[i];
        [self addChildViewController:shopVC];
    }
    
}
/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < [_TitleArray count]; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        ShopsTitle *lbl1 = [[ShopsTitle alloc]init];
        lbl1.text = [_TitleArray objectAtIndex:i];
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    smallScrollView.contentSize = CGSizeMake(70 * [_TitleArray count], 0);
    
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
    ShopsTitle *titleLable = (ShopsTitle *)smallScrollView.subviews[index];
    
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
    ShopViewController * shopVc = self.childViewControllers[index];
    shopVc.cat_id1 = _catIdArray[index];
    
    [smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            ShopsTitle *temlabel = smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (shopVc.view.superview) return;
    shopVc.view.frame = scrollView.bounds;
    [bigScrollView addSubview:shopVc.view];
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
    ShopsTitle *labelLeft = smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex <smallScrollView.subviews.count) {
        ShopsTitle *labelRight = smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}




@end
