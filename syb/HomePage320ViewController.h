//
//  HomePage320ViewController.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAdsPlayView.h"
#import "SearchViewController.h"
#import "CategoryViewController.h"
#import "WebViewController.h"
#import "MyMessageViewController.h"
#import "LoginViewController.h"
@interface HomePage320ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    //单例对象
    SingleManage * SM;
    
    //项目Logo
    UIImageView * logoImg;
    
    //搜索视图
    UIView * searchView;
    UIImageView * MagnifierIV;
    UILabel * placeholderL;
    UIButton * messageButton;
    UIImageView * pointImage;
    UIButton * GoTopButton;
    
    UITableView * TableView;
    
}

//轮播
@property (nonatomic,strong)CCAdsPlayView * BannerView;

//广告请求完成
@property BOOL AdFinish;

//其他层请求完成
@property BOOL OtherFloorFinish;


//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;
@property (nonatomic,strong)NSMutableArray * shopCatList;
@property (nonatomic,strong)NSMutableArray * goodCatList;


//用户相关信息的数据
@property(nonatomic,strong)NSMutableDictionary * userDict;

//一楼

//广告数组
@property (nonatomic,strong)NSMutableArray * bannerImageArray;
@property(nonatomic,strong)NSMutableArray * bannerArray;
@property (nonatomic,strong)NSArray * bannerModelArray;
@property (nonatomic,strong)NSDictionary * bannerDict;

//首页分类列表参数
@property(nonatomic,strong)NSMutableArray * catArray;


@end
