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
@interface MyMessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
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

//消息数组
@property (nonatomic,strong)NSMutableArray * messageList;
@end
