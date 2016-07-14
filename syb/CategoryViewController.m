//
//  CategoryViewController.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "CategoryViewController.h"
#import "ClassifyViewController.h"
@implementation CategoryViewController

- (id)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"索引位置的数字是%ld",(long)_selectIndex);
   // NSLog(@"^^^^%@",_categoryArray);
    [self PageSetup];
    [self initNavigationBar];
   
    self.navigationItem.title = @"";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@NO];
}

//初始化相关数据
-(void)InitData
{
    
     NSDictionary * dict1 = @{ @"cat_id" : @"1316", @"name" : @"跨境美妆"};
     NSDictionary * dict2 = @{ @"cat_id" : @"1319", @"name" : @"跨境母婴"};

    
    _categoryArray = [NSMutableArray array];
    
    [_categoryArray addObjectsFromArray:[UserDefaultsUtils valueWithKey:@"goodCatList"]];
    
    if ([_categoryArray count]==0) {
        [_categoryArray removeAllObjects];
        [_categoryArray addObject:dict1];
        [_categoryArray addObject:dict2];
    }
    
    
    NSLog(@"分类ID是***%@",_categoryArray);
    
    _TitleArray = [NSMutableArray array];
    _catIdArray = [NSMutableArray array];
    
    for (NSDictionary * dict in _categoryArray) {
        
        NSString * title = [dict valueForKey:@"name"];
        NSString * cat_id = [dict valueForKey:@"cat_id"];
        [_TitleArray addObject:title];
        [_catIdArray addObject:cat_id];
    }

     [self initScroll];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [smallScrollView removeFromSuperview];
    [backButton removeFromSuperview];
}
//页面设置
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.navigationItem.hidesBackButton = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)initNavigationBar
{
    if (!backButton) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       
    }
 //    [self.navigationController.navigationBar addSubview:backButton];

    if (smallScrollView) {
        
        [self.navigationController.navigationBar addSubview:smallScrollView];
    }
  
}
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self InitData];
}


-(void)initScroll
{
    
    if (!smallScrollView) {
        smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-70,2,140, 40)];
        smallScrollView.backgroundColor = [UIColor clearColor];
        smallScrollView.bounces = YES;
        smallScrollView.pagingEnabled = YES;
        smallScrollView.showsHorizontalScrollIndicator = NO;
        smallScrollView.showsVerticalScrollIndicator = NO;
        smallScrollView.opaque = YES;
        
    }
  
    if (!bigScrollView) {
        
        bigScrollView = [[UIScrollView alloc] init];
        bigScrollView.frame =CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-113);
        bigScrollView.backgroundColor = BGColor;
        bigScrollView.bounces = NO;
        bigScrollView.pagingEnabled = YES;
        bigScrollView.showsHorizontalScrollIndicator = NO;
        bigScrollView.showsVerticalScrollIndicator = NO;
        bigScrollView.delegate = self;
        bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*[_categoryArray count],bigScrollView.frame.size.height);
        
        NSLog(@"&&&&&&&&%f",bigScrollView.contentOffset.x);
        
    }
    
    [self addController];
    
    [self addLable];
    
    // 添加默认控制器
    
   // if (_selectIndex==0) {
        ClassifyViewController * vc = self.childViewControllers[0];
        vc.view.frame = bigScrollView.bounds;
        vc.cat_id1 = _catIdArray[0];
        [bigScrollView addSubview:vc.view];
    
        ShopsTitle *lable = smallScrollView.subviews[0];
        lable.scale = 1.0;
        
//    }
    
//    else if (_selectIndex==1)
//    {
//        ClassifyViewController * vc = self.childViewControllers[1];
//        vc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        vc.cat_id1 = _catIdArray[1];
//        [bigScrollView addSubview:vc.view];
//        bigScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
//        ShopsTitle *lable = smallScrollView.subviews[1];
//        lable.scale = 1.0;
//    }
    
    [self.navigationController.navigationBar addSubview:smallScrollView];
    [self.view addSubview:bigScrollView];    

    
}

#pragma mark - UIBarPositioningDelegate Methods


-(void)addController
{
    for (int i=0 ; i<[_categoryArray count] ;i++){
        ClassifyViewController * classifyVC = [[ClassifyViewController alloc]init];
        classifyVC.cat_id1 = _catIdArray[i];
        [self addChildViewController:classifyVC];
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
        lbl1.textColor = RGBACOLOR(51, 51, 51, 1);
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
    
    
    NSLog(@"&&&&&&&&%f",offsetX);
}


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
    ClassifyViewController * Vc = self.childViewControllers[index];
    Vc.cat_id1 = _catIdArray[index];
    
    [smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            ShopsTitle *temlabel = smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }else if (idx==index)
        {
            ShopsTitle *temlabel = smallScrollView.subviews[idx];
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
    ShopsTitle *labelLeft = smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    
    
    if (rightIndex <smallScrollView.subviews.count) {
        ShopsTitle *labelRight = smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}



@end
