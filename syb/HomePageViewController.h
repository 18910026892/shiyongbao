//
//  HomePageViewController.h
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleManage.h"
#import "HomePageTabelViewCell.h"
#import "HomePageFloorDTO.h"
#import "CCAdsPlayView.h"
@interface HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HomePageTableViewCellDelegate>
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
    
    //二维码按钮
    UIButton * BarCodeButton;
    
    //首页的背景视图
    UITableView * TableView;

    //floor1
    UIView * HeaderView;
    CCAdsPlayView * BannerView;
    UIImageView * xunzhenImageView;
    UICollectionView * CollectionView;
    //Go Top Button
    UIButton * GoTopButton;

    //Footer
    UIView * FooterView;
    UIButton * moreButton;
    
}

//广告请求完成
@property BOOL AdFinish;

//其他层请求完成

@property BOOL OtherFloorFinish;


//是否刷新的标志
@property(nonatomic,assign)BOOL update;


//广告数组
@property (nonatomic,strong)NSMutableArray * bannerImageArray;
@property(nonatomic,strong)NSMutableArray * bannerArray;

@property (nonatomic,strong)NSArray * bannerModelArray;


@property (nonatomic,strong)NSMutableArray * categoryArray;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;


//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//店铺列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * ShopsListArray;


//首页数据数组(未建模前)
@property (nonatomic,strong)NSMutableArray * HomePageArray;

//首页数据数组(建模)
@property (nonatomic,strong)NSMutableArray * NewHomePageArray;

//店铺分类数组
@property (nonatomic,strong)NSMutableArray * shopCatList;

@end
