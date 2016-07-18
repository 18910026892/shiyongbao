//
//  goodsAttentionViewController.h
//  syb
//
//  Created by 巩鑫 on 16/7/17.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "goodsAttentionModel.h"
#import "goodsAttentionCell.h"
@interface goodsAttentionViewController : BaseViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * TableView;


@property (nonatomic,strong)NSMutableArray * goodArray;

@property (nonatomic,strong)NSMutableArray * goodModelArray;

@property (nonatomic,strong)NSMutableArray * goodListArray;

@property(nonatomic,copy)NSString * page;


@end
