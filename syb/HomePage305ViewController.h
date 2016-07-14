//
//  HomePage305ViewController.h
//  syb
//
//  Created by GongXin on 16/2/23.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAdsPlayView.h"
#import "HomePage305CollectionCell.h"
#import "RenZhengGoodsModel.h"
@interface HomePage305ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
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
    
    //首页的背景视图
    UITableView * TableView;
    


}

//轮播
@property (nonatomic,strong)CCAdsPlayView * BannerView;


//广告请求完成
@property BOOL AdFinish;

//其他层请求完成
@property BOOL OtherFloorFinish;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

@property (nonatomic,strong)NSMutableArray * shopCatList;
@property (nonatomic,strong)NSMutableArray * goodCatList;

//一楼

//广告数组
@property (nonatomic,strong)NSMutableArray * bannerImageArray;
@property(nonatomic,strong)NSMutableArray * bannerArray;
@property (nonatomic,strong)NSArray * bannerModelArray;
@property (nonatomic,strong)NSDictionary * bannerDict;



//二楼
@property(nonatomic,strong)NSMutableArray * GoodsArray;
@property (nonatomic,strong)NSArray * ModelArray;
@property (nonatomic,strong)NSMutableArray * GoodsList;

@property (nonatomic,strong)UIButton * JianZhengButton;
@property (nonatomic,strong)UIButton * ZhengPinButton;
@property (nonatomic,strong)UIButton * moreButton;

//线条
@property (nonatomic,strong)UILabel * line;

//竖直线条
@property (nonatomic,strong)UILabel * verticalLabel;

@property (nonatomic,strong)UILabel * sectionLabel;
@property (nonatomic,strong)UILabel * moreLabel;
@property (nonatomic,strong)UIView * sectionBG;
@property (nonatomic,strong)UICollectionView * CollectionView;

//三楼四楼

@property (nonatomic,strong)NSMutableDictionary * logoDict;
@property (nonatomic,strong)UIImageView * ThreeFloorCellImage;
@property (nonatomic,strong)UIImageView * FourFloorCellImage;

@property (nonatomic,copy)NSString * firstUrL;
@property (nonatomic,copy)NSString * secondUrl;

//用户相关信息的数据
@property(nonatomic,strong)NSMutableDictionary * userDict;


@end
