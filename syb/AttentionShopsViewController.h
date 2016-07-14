//
//  AttentionShopsViewController.h
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionShopsDto.h"
#import "AttentionShopTableViewCell.h"
@interface AttentionShopsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AttentionShopTableViewCellDelegate>
{
    UIButton * backButton;
    UITableView * TableView;

}

//是否刷新的标志
@property(nonatomic,assign)BOOL update;

//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

//数据模型数组
@property (nonatomic,strong)NSArray * ModelArray;

//店铺列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * ShopsList;

//店铺列表页面的商品列表数组
@property (nonatomic,strong)NSMutableArray * ShopsListArray;
@end
