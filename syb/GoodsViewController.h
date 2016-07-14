//
//  GoodsViewController.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "brandModel.h"
#import "good320Model.h"
#import "BrandCell.h"
#import "GoodsTableViewCell.h"

@interface GoodsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * TableView;

@property (nonatomic,strong)NSMutableArray * brandArray;

@property (nonatomic,strong)NSMutableArray * brandModelArray;

@property (nonatomic,strong)NSMutableArray * brandListArray;

@property (nonatomic,strong)NSMutableArray * goodArray;

@property (nonatomic,strong)NSMutableArray * goodModelArray;

@property (nonatomic,strong)NSMutableArray * goodListArray;

@property(nonatomic,copy)NSString * page;
@property(nonatomic,copy)NSString * cat_id;


@end
