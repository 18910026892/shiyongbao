//
//  GroupGoodsViewController.h
//  syb
//
//  Created by GongXin on 16/7/18.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductGoodsModel.h"
#import "ProductGoodsCell.h"
@interface GroupGoodsViewController : BaseViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * TableView;


@property (nonatomic,strong)NSMutableArray * goodArray;

@property (nonatomic,strong)NSMutableArray * goodModelArray;

@property (nonatomic,strong)NSMutableArray * goodListArray;

@property(nonatomic,copy)NSString * page;
@property(nonatomic,copy)NSString * group_id;
@end
