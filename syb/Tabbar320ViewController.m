//
//  Tabbar320ViewController.m
//  syb
//
//  Created by GongXin on 16/7/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "Tabbar320ViewController.h"

@implementation Tabbar320ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hpVc = [[HomePage320ViewController alloc]init];
    hpVc.title = @"商品汇";
    [hpVc.tabBarItem setImage:[UIImage imageNamed:@""]];
    [hpVc.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
    UINavigationController * hpNC = [[UINavigationController alloc]initWithRootViewController:hpVc];
    
    shopVc = [[Shop320ViewController alloc]init];
    shopVc.title = @"卖家汇";
    [shopVc.tabBarItem setImage:[UIImage imageNamed:@""]];
    [shopVc.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
    UINavigationController * shopNC = [[UINavigationController alloc]initWithRootViewController:shopVc];
    

    shiyongbaoVc = [[ShiYongBao320ViewController alloc]init];
    shiyongbaoVc.title = @"识用宝认证";
    [shiyongbaoVc.tabBarItem setImage:[UIImage imageNamed:@""]];
    [shiyongbaoVc.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
    UINavigationController * shiyongbaoNC = [[UINavigationController alloc]initWithRootViewController:shiyongbaoVc];
    
    cartVc = [[Cart320ViewController alloc]init];
    cartVc.title = @"购物车";
    [cartVc.tabBarItem setImage:[UIImage imageNamed:@""]];
    [cartVc.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
    UINavigationController * cartNC = [[UINavigationController alloc]initWithRootViewController:cartVc];
    
    
    meVc = [[Me320ViewController alloc]init];
    meVc.title = @"我的";
    [meVc.tabBarItem setImage:[UIImage imageNamed:@""]];
    [meVc.tabBarItem setSelectedImage:[UIImage imageNamed:@""]];
    UINavigationController * meNc = [[UINavigationController alloc]initWithRootViewController:meVc];
    

    
    
    self.viewControllers = [NSArray arrayWithObjects:hpNC,shopNC,shiyongbaoNC,cartNC,meNc, nil];
    self.tabBar.tintColor = ThemeColor;

    
    
}
@end
