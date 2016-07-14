//
//  MallViewController.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallCollectionViewCell.h"
#import "MallModel.h"
@interface MallViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel * TitleLabel;
    
    UIImageView * FirstImageView;
   
   UIButton * HeaderButton;
    UILabel * HeaderLabel;
    
    UILabel * AuthenticationLabel;
    UILabel * lineLabel;
    UITableView * TableView;
    
    
    UICollectionView * CollectionView;
    
    UIImageView * cellImage;
    
    //自定义弹出视图
    UIView * customPopView;
    UIView * headerView;
    UIWebView * _webView;
    UIButton * cancleBtn;
    UIView * goBuyView;
    UIButton * goBuyBtn;
    UIActivityIndicatorView *testActivityIndicator;
    
    SingleManage * SM;
    
    
    
}

@property (nonatomic,copy)NSString * doctitle;

@property BOOL isShow;

//返回的对象字典
@property(nonatomic,strong)NSMutableDictionary * objDict;

//商城分类数组
@property (nonatomic,strong)NSMutableArray * categoryMallArray;

//商城标题数组
@property (nonatomic,strong)NSMutableArray * MallTileArray;

//商城数组
@property (nonatomic,strong)NSMutableArray * MallArray;

//商城模型数组
@property (nonatomic,strong)NSMutableArray * MallListArray;

//参数
@property (nonatomic,copy)NSString * site_cat_id;


@property (nonatomic,copy)NSString * shopDetailUrl;
@property (nonatomic,copy)NSString * BuyDetailUrl;
@property (nonatomic,copy)NSString * shopTitle;

@end
