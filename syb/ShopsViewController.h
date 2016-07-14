//
//  ShopsViewController.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopsModel.h"
#import "ShopsCell.h"
@interface ShopsViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,ShopsCellDelegate>
{
   
    SybSession * userSession;
    
}
@property (nonatomic,strong)UITableView * TableView;;


//请求数据传递的参数
@property (nonatomic,copy)NSString * cat_id1;

//页面参数
@property (nonatomic,copy)NSString * page;


//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//商品列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * ShopsList;

@property (nonatomic,strong)NSMutableArray * ShopsListArray;

@end
