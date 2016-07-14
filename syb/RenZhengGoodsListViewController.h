//
//  RenZhengGoodsListViewController.h
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenZhengGoodsCell.h"
#import "RenZhengGoodsModel.h"
@interface RenZhengGoodsListViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * backButton;
    UITableView * TableView;
    
    
    //兼容IOS7全屏模式
    BOOL                    _isInsetGeted;
    UIEdgeInsets            _initScrollViewInset;
}

//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//商品列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * GoodsList;



@end
