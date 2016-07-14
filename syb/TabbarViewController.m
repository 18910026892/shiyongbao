//
//  TabbarViewController.m
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomePageViewController.h"
#import "MallViewController.h"
#import "MineViewController.h"

#import "HomePage305ViewController.h"
#import "CategoryViewController.h"
#import "ShopAllViewController.h"


@interface TabbarViewController ()
{
    //标签导航下的s个试图控制器
   //HomePageViewController * hpVC;
    MallViewController * mallsVC;
    MineViewController * mineVC;

    HomePage305ViewController * hpVC;
    CategoryViewController * goodsCatVc;
    ShopAllViewController * shopCatVc;
}
@end

@implementation TabbarViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

- (void)HideTabbar:(NSNotification *)notification
{

    

   BOOL hideButton = [notification.object boolValue];
    
    if (hideButton) {
        self.anxingouButton.hidden = YES;
    }else if(!hideButton)
    {
        self.anxingouButton.hidden = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(HideTabbar:)
                                       name:@"HideTabbarButton"
                                               object:nil];
    
    
    hpVC = [[HomePage305ViewController alloc]init];
    hpVC.title = @"首页";
   [hpVC.tabBarItem setImage:[UIImage imageNamed:@"tab1"]];
   [hpVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab1-1"]];
    UINavigationController * hpNC = [[UINavigationController alloc]initWithRootViewController:hpVC];
    

    goodsCatVc = [[CategoryViewController alloc]init];
    goodsCatVc.title = @"商品汇";
    [goodsCatVc.tabBarItem setImage:[UIImage imageNamed:@"tab4"]];
    [goodsCatVc.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab4-4"]];
    UINavigationController * goodsNC = [[UINavigationController alloc]initWithRootViewController:goodsCatVc];
    
    
    mallsVC = [[MallViewController alloc]init];

    UINavigationController * mallsNC = [[UINavigationController alloc]initWithRootViewController:mallsVC];
    
    shopCatVc = [[ShopAllViewController alloc]init];
    shopCatVc.title = @"卖家汇";
    [shopCatVc.tabBarItem setImage:[UIImage imageNamed:@"tab2"]];
    [shopCatVc.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab2-2"]];
    
    
    UINavigationController * shopNC = [[UINavigationController alloc]initWithRootViewController:shopCatVc];
    
    mineVC = [[MineViewController alloc]init];
    mineVC.title = @"个人中心";
    [mineVC.tabBarItem setImage:[UIImage imageNamed:@"tab3"]];
    [mineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab3-3"]];
    UINavigationController * mineNC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    
    self.viewControllers = [NSArray arrayWithObjects:hpNC,goodsNC, mallsNC,shopNC,mineNC,nil];
    self.tabBar.tintColor = ThemeColor;

    self.delegate = self;
   [self.view addSubview:self.anxingouButton];
    
    
}

-(UIButton*)anxingouButton
{
    if (!_anxingouButton) {
        _anxingouButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _anxingouButton.frame = CGRectMake(SCREEN_WIDTH/2-30, SCREEN_HEIGHT-62, 60, 60);
        [_anxingouButton setBackgroundImage:[UIImage imageNamed:@"tab5"] forState:UIControlStateNormal];
       
        
        [_anxingouButton addTarget:self action:@selector(anxingouButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anxingouButton;
}

-(void)anxingouButtonClick:(UIButton*)sender
{
    NSLog(@"123");

    self.selectedIndex= 2;
    [self checkSelect];

}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = self.selectedIndex;
    NSLog(@"aaaaaaaaaaaa%ld",index);
    [self checkSelect];
    
}

-(void)checkSelect
{
    NSInteger index = self.selectedIndex;
    if (index==2) {
    [_anxingouButton setBackgroundImage:[UIImage imageNamed:@"tab5-5"] forState:UIControlStateNormal];
    }else
    {
      [_anxingouButton setBackgroundImage:[UIImage imageNamed:@"tab5"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
