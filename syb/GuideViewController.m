//
//  GuideViewController.m
//  syb
//
//  Created by GX on 15/11/19.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GuideViewController.h"
#import "TabbarViewController.h"
@implementation GuideViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initGuide];
    
}

-(void)initGuide
{
  
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*3, 0)];
    [scrollView setPagingEnabled:YES];
    [scrollView setBounces:NO];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    
    NSString * image1name;
    if (SCREEN_HEIGHT>500) {
        image1name = @"guide1_1";
    }else
    {
        image1name = @"guide1";
    }
    imageview1.image = [UIImage imageNamed:image1name];
    [scrollView addSubview:imageview1];
    
    
    
    
    UIImageView *imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    
    NSString * image2name;
    if (SCREEN_HEIGHT>500) {
        image2name = @"guide2_1";
    }else
    {
        image2name = @"guide2";
    }
    imageview2.image = [UIImage imageNamed:image2name];
    [scrollView addSubview:imageview2];
    
    
    UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    NSString * image3name;
    if (SCREEN_HEIGHT>500) {
        image3name = @"guide3_1";
    }else
    {
        image3name = @"guide3";
    }
    imageview3.image = [UIImage imageNamed:image3name];
    imageview3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstpressed)];
    [imageview3 addGestureRecognizer:tapGesture];
    [scrollView addSubview:imageview3];
    

    
    
    UIPageControl*page=[[UIPageControl alloc]init];
    page.frame=CGRectMake(WIDTH_VIEW(self.view)/2-20*Proportion, CGRectGetHeight(self.view.frame)-30*Proportion, 45*Proportion, 30*Proportion);
    page.pageIndicatorTintColor = [UIColor whiteColor];
    page.currentPageIndicatorTintColor = ThemeColor;
    page.numberOfPages =3;
    page.currentPage=0;
    page.tag = 100;
    page.userInteractionEnabled=NO;
    [self.view addSubview:scrollView];
    [self.view addSubview:page];
    
}
//
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl* page = (UIPageControl*)[self.view viewWithTag:100];
    int current = scrollView.contentOffset.x/SCREEN_WIDTH;
    page.currentPage = current;
}

//点击进入体验按钮
-(void)firstpressed
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //初始化应用的根视图控制器
    TabbarViewController * tabbarVC = [[TabbarViewController alloc]init];
    self.view.window.rootViewController = tabbarVC;

}

@end
