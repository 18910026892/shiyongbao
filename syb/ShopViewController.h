//
//  ShopViewController.h
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsModel.h"
#import "ShopsCell.h"
@interface ShopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ShopsCellDelegate>
{
    UITableView * TableView;
    SingleManage * SM;

}
@property (nonatomic,copy)NSString * networkType;
//是否刷新的标志
@property(nonatomic,assign)BOOL update;

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
