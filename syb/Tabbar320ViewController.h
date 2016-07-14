//
//  Tabbar320ViewController.h
//  syb
//
//  Created by GongXin on 16/7/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage320ViewController.h"
#import "Shop320ViewController.h"
#import "ShiYongBao320ViewController.h"
#import "Cart320ViewController.h"
#import "Me320ViewController.h"

@interface Tabbar320ViewController : UITabBarController
{
    HomePage320ViewController * hpVc;
    Shop320ViewController * shopVc;
    ShiYongBao320ViewController * shiyongbaoVc;
    Cart320ViewController * cartVc;
    Me320ViewController * meVc;
}

@end
