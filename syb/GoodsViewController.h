//
//  GoodsViewController.h
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCell.h"
#import "GoodsModel.h"
#import "DOPDropDownMenu.h"

@interface GoodsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>
{
    UIButton * backButton;
    
    UITableView * TableView;

    
    DOPDropDownMenu * menuView;
    
    SingleManage * SM;
    
}

@property BOOL Finish;
//返回值的数组
@property (nonatomic,strong)NSMutableDictionary * backDict;

//筛选数组
@property (nonatomic,strong)NSMutableArray *ScreeningArray;

//排序对象字典
@property (nonatomic,strong)NSMutableDictionary * SortDict;

//元素1数组
@property (nonatomic,strong)NSMutableArray * Item1Array;
//元素2数组
@property (nonatomic,strong)NSMutableArray * Item2Array;

@property (nonatomic,strong)NSMutableArray * FinalArray;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//请求数据传递的参数
@property (nonatomic,copy)NSString * cat_id;

//页面参数
@property (nonatomic,copy)NSString * page;

//传参字典
@property (nonatomic,strong)NSMutableDictionary * paraDict;

@property (nonatomic,strong)NSMutableDictionary * postDict;

@property (nonatomic,strong)NSMutableDictionary * FirstDict;

//未知筛选条件参数
@property (nonatomic,copy)NSString * screeningKey;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//商品列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * GoodsList;
@end
