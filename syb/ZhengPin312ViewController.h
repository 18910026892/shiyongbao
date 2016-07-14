//
//  ZhengPin312ViewController.h
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenPin312Cell.h"
#import "ZhenPin312Model.h"
@interface ZhengPin312ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * backButton;
    UIButton * reportButton;
    UITableView * TableView;
}
@property (nonatomic,strong)NSMutableArray * zhengpinArray;
@property (nonatomic,strong)NSMutableArray * zhengpinModelArray;
@property (nonatomic,strong)NSMutableArray * zhengpinListArray;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;
//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;
@end
