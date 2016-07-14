//
//  SearchViewController.h
//  syb
//
//  Created by GX on 15/10/20.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseSearchTypeView.h"
#import "SearchTextField.h"
@interface SearchViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView * TableView;
@property (nonatomic,strong)UIView * TabelViewFooterView;
@property (nonatomic,strong)UIButton * cleanRecordButton;

//是否能添加的标志
@property BOOL CanAddRecord;

@property(nonatomic,strong)NSMutableArray * oldSearchArray;

//商品搜索记录数组
@property (nonatomic,strong)NSMutableArray * GoodsSearchArray;

//店铺搜索记录数组
@property (nonatomic,strong)NSMutableArray * ShopsSearchArray;

//识用说搜索记录数组
@property (nonatomic,strong)NSMutableArray * ShiYongShuoSearchArray;



//搜索历史记录数组
@property (nonatomic,strong)NSMutableArray * searchRecordArray;

//图片视图
@property (nonatomic,strong)UIView * SearchBarView;

//选择搜索类型按钮
@property (nonatomic,strong)UIButton * SearchTypeButton;

//搜索框
@property (nonatomic,strong)SearchTextField * SearchBar;



//取消
@property (nonatomic,strong)UIButton * CancleButton;

//搜索类型参数
@property (nonatomic,copy)NSString * searchType;


@end
