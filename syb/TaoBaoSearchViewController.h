//
//  TaoBaoSearchViewController.h
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTextField.h"
@interface TaoBaoSearchViewController : UIViewController
<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //UI
    UITableView * TableView;
    
    UIView * TabelViewFooterView;
    
    UIButton * cleanRecordButton;
}
//是否能添加的标志
@property BOOL CanAddRecord;

@property(nonatomic,strong)NSMutableArray * oldSearchArray;

//搜索历史记录数组
@property (nonatomic,strong)NSMutableArray * searchRecordArray;

//图片视图
@property (nonatomic,strong)UIView * SearchBarView;


//搜索框
@property (nonatomic,strong)SearchTextField * SearchBar;

//取消
@property (nonatomic,strong)UIButton * CancleButton;

//跳转连接
@property (nonatomic,strong)NSString * click_url;


@end
