//
//  RenZhengGoodsDetailViewController.h
//  syb
//
//  Created by GongXin on 16/2/25.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenZhengGoodsModel.h"
@interface RenZhengGoodsDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UIImageView * cellimg;
    UILabel * celltitle;
    UILabel * line;
    UIButton * shiyongshuoButton;
    
    //使用说弹出视图
    UIView * customPopView;
    UIView * headerView;
    UIWebView * webView;
    UIButton * cancleBtn;
    UISegmentedControl * segmetedControl;
    //菊花指示器
    UIActivityIndicatorView *testActivityIndicator;
    UIView * cpvBGview;
    
    SingleManage * SM;

}


//识用说索引位置
@property NSInteger selectIndex;
//小的webview 请求的URL地址
@property(nonatomic,copy)NSString * smallWebUrl;
//识用说详情标题数组
@property (nonatomic,strong)NSArray * segmentControlArray;
//识用说
@property (nonatomic,strong)NSMutableDictionary * shiyongshuoDict;




@property (nonatomic,strong)RenZhengGoodsModel * model;

@property (nonatomic,strong)UILabel * cellTitle;

@property (nonatomic,strong)UIView *HeaderView;

@property(nonatomic,strong)UITableView * TableView;

@property (nonatomic,strong)UIButton * backButton;

@property (nonatomic,strong)UILabel * sectionTitle;

@property (nonatomic,strong)NSMutableArray * SiteArray;

@property (nonatomic,strong)UILabel * cellLabel;

@end
