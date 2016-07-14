//
//  MyMessageViewController.h
//  syb
//
//  Created by GX on 15/10/23.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageViewController.h"
#import "MessageModel.h"
#import "MessageTableViewCell.h"
@interface MyMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * TableView;

@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;


@property(nonatomic,copy)NSString * page;

@end
