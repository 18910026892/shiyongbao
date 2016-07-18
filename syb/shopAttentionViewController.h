//
//  shopAttentionViewController.h
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "shopAttentionCell.h"
#import "shopAttentionModel.h"
@interface shopAttentionViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,shopAttentionCellDelegate>
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
