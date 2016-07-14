//
//  ShopsDetailViewController.h
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopsDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    
    UIButton * backButton;
    
    UIView * HeaderView;
    //平台来源
    UIImageView * platform;
    //店铺名称
    UILabel * shopName;
    //质检通过标识
    UIImageView * passImage;
    //关注按钮
    UIButton * AttentionButton;
    //关注的人数量
    UILabel * AttentionCount;


    UITableView * TableView;
    UIView * menuView;
    UIButton * menuButtn;
    
    //菊花指示器
    UIActivityIndicatorView *testActivityIndicator;
    UIWebView * WebView;
}

//获取到的数据
@property (nonatomic,strong)NSMutableArray * UrlArray;

//索引标题数组
@property (nonatomic,strong)NSMutableArray * IndexesArray;

//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;


@property(nonatomic,strong)NSMutableDictionary * shopDict;

@property (nonatomic,copy)NSString * url4;
@end
