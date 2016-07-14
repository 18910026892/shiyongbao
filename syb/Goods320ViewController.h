//
//  Goods320ViewController.h
//  syb
//
//  Created by GongXin on 16/7/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BrandCell.h"
#import "Good320Cell.h"
@interface Goods320ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    UITableView * TableView;

}


//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//品牌列表
@property(nonatomic,strong)NSMutableArray * brandArray;
@property (nonatomic,strong)NSArray * brandModelArray;
@property (nonatomic,strong)NSMutableArray * brandList;


//商品列表
@property(nonatomic,strong)NSMutableArray * goodsArray;
@property (nonatomic,strong)NSArray * goodsModelArray;
@property (nonatomic,strong)NSMutableArray * goodsList;


//首页列表参数
@property(nonatomic,copy)NSString * cat_id;
@property (nonatomic,copy)NSString * page;



@end
