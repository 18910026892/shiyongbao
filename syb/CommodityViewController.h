//
//  CommodityViewController.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"
#import "CommodityTableViewCell.h"
@interface CommodityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * backButton;
    UITableView * TableView;
    SingleManage * SM;
}

//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//请求数据传递的参数
@property (nonatomic,copy)NSString * cat_id;

//请求数据传递的参数
@property (nonatomic,copy)NSString * shop_id;
//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//商品列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * GoodsList;

@end
