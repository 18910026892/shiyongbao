//
//  GuideViewController.m
//  syb
//
//  Created by GongXin on 16/7/20.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIImageView * firstGuideImageView;

@property(nonatomic,strong)UIImageView * secondGuideImageView;

@property(nonatomic,strong)UIImageView * thirdGuideImageView;

@end
@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.pageControl];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    if ([self.timer isValid]) {
        
        [self.timer invalidate];
        //这行代码很关键
        _timer=nil;
        
    }
    
}

-(UIScrollView*)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        [_mainScrollView setContentSize:CGSizeMake(kMainScreenWidth*3, 0)];
        [_mainScrollView setPagingEnabled:YES];
        [_mainScrollView setBounces:NO];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        
        [_mainScrollView addSubview:self.firstGuideImageView];
        [_mainScrollView addSubview:self.secondGuideImageView];
        [_mainScrollView addSubview:self.thirdGuideImageView];
    }
    return _mainScrollView;
}

-(UIPageControl*)pageControl
{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.frame=CGRectMake(kMainScreenWidth/2-25, kMainScreenHeight-30, 50,30);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.numberOfPages =3;
        _pageControl.currentPage=0;
        _pageControl.tag = 100;
        _pageControl.userInteractionEnabled=NO;
    }
    return _pageControl;
}

-(UIImageView*)firstGuideImageView
{
    if (!_firstGuideImageView) {
        _firstGuideImageView = [[UIImageView alloc]init];
        _firstGuideImageView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        _firstGuideImageView.backgroundColor = [UIColor clearColor];
        _firstGuideImageView.image= [UIImage imageNamed:@"guide1"];
        
    }
    return _firstGuideImageView;
}

-(UIImageView*)secondGuideImageView
{
    if (!_secondGuideImageView) {
        _secondGuideImageView  = [[UIImageView alloc]init];
        _secondGuideImageView.frame = CGRectMake(kMainScreenWidth, 0,kMainScreenWidth, kMainScreenHeight);
        _secondGuideImageView.backgroundColor = [UIColor clearColor];
        _secondGuideImageView.image = [UIImage imageNamed:@"guide2"];
    }
    return _secondGuideImageView;
}

-(UIImageView*)thirdGuideImageView

{
    if (!_thirdGuideImageView) {
        _thirdGuideImageView = [[UIImageView alloc]init];
        _thirdGuideImageView.frame =CGRectMake(kMainScreenWidth*2, 0,kMainScreenWidth, kMainScreenHeight);
        _thirdGuideImageView.backgroundColor = [UIColor clearColor];
        _thirdGuideImageView.image = [UIImage imageNamed:@"guide3"];
        _thirdGuideImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstpressed)];
        [_thirdGuideImageView addGestureRecognizer:tapGesture];
    }
    return _thirdGuideImageView;
}


#pragma scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  

    float w = scrollView.contentOffset.x;
    
    
    if (w==750) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goHomePage) userInfo:nil repeats:YES];
    }else
        
    {
        if ([self.timer isValid]) {
            
            [self.timer invalidate];
            //这行代码很关键
            _timer=nil;
            
        }
    }
    
    
}

-(void)goHomePage
{
    if (_delegate) {
        [_delegate GuideViewControllerSureBtnClicked];
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl* page = (UIPageControl*)[self.view viewWithTag:100];
    int current = scrollView.contentOffset.x/kMainScreenWidth;
    page.currentPage = current;
}

//点击进入体验按钮
-(void)firstpressed
{
    if ([_delegate respondsToSelector:@selector(GuideViewControllerSureBtnClicked)]) {
        [_delegate GuideViewControllerSureBtnClicked];
    }
    
}

@end
