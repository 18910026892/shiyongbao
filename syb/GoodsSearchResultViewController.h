//
//  GoodsSearchResultViewController.h
//  syb
//
//  Created by GX on 15/11/5.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsSearchModel.h"
#import "GoodsSearchTableViewCell.h"
@interface GoodsSearchResultViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
     SybSession * userSession;
}

@property (nonatomic,strong)  UIButton * searchButton;
@property (nonatomic,strong)  UITableView * TableView;

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

//搜索类型的关键词
@property (nonatomic,copy)NSString * KeyWord;

@end
