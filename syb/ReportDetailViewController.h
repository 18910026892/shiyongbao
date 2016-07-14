//
//  ReportDetailViewController.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportDetailViewController.h"
#import "StoreTableViewCell.h"
#import "StoreModel.h"
#import "ReportDetailTableViewCell.h"
#import "ReportDetailModel.h"
#import "ReportModel.h"
@interface ReportDetailViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * backButton;
    
    UITableView * TableView;

}

@property (nonatomic,strong)ReportModel * model;

@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UILabel * cellTitle;
@property (nonatomic,strong)UIView * reportHeader;

@property (nonatomic,strong)UILabel * sectionTitle;


@property (nonatomic,strong)NSMutableArray * eventModelArray;
@property (nonatomic,strong)NSMutableArray * eventListArray;
@property (nonatomic,strong)NSMutableArray * SiteModelArray;
@property (nonatomic,strong)NSMutableArray * SiteListArray;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;
//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;


@end
