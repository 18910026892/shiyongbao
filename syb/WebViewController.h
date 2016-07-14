//
//  WebViewController.h
//  syb
//
//  Created by GX on 15/10/30.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebShiYongShuoModel.h"
#import "WebShiYongShuoTableViewCell.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
#import "UIWebView+Clean.h"

typedef enum{
    
    WebViewTypeNormal,//正常
    WebViewTypeShiYongShuo,//识用说
   
    
} WebViewType ;

@interface WebViewController :UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton * bottomButton;

    UILabel *  TitleLabel;
    UIButton * backButton;
    UIButton * reloadButton;
    UIButton * closeButton;
    
    UIWebView * WebView;
    //菊花指示器
    UIActivityIndicatorView *TestActivityIndicator;
//    NJKWebViewProgressView *_progressView;
//    NJKWebViewProgress *_progressProxy;
    
    //识用说按钮
    UIButton * ShiYongShuoButton;
    
 
    UITableView * TableView;
    //菊花指示器
    UIActivityIndicatorView *testActivityIndicator;
    
   
    UIView * customPopView;
    UIView * headerView;
    UIView * cpvBGview;
    UIView * detailView;
    UIView * detailHeaderView;
    UIImageView * imgv;
    UILabel * titleLabel;
    UILabel * priceLabel;
    UIWebView * _webView;
    UIButton * cancleBtn;
    UISegmentedControl * segmetedControl;
    
    
    //代维权弹出视图
    UIView * CustomPopView;
    UIView * HeaderView;
    UIWebView * WEBView;
    UIButton * CancleBtn;
    
    
    
}
@property float OldY;
@property BOOL isAlipay;
@property BOOL isTmall;
@property BOOL shiyongshuoShow;
@property BOOL isdaiweiquanShow;
@property NSInteger count;
@property (assign, nonatomic)BOOL isHidden;

@property (assign, nonatomic)BOOL aiTaoBao;

//webView的样式
@property (assign, nonatomic)  WebViewType webViewType;

@property (nonatomic,copy)NSString * DaiWeiQuan;

//页面标题
@property (nonatomic,copy)NSString * webTitle;

//将要请求的URL
@property (nonatomic,copy)NSString * requestURL;

//返利规则数组
@property (nonatomic,strong)NSMutableArray * RuleArray;


//当前匹配上的字典对象
@property (nonatomic,strong)NSMutableDictionary * RuleDict;



//获取到的Html字符串
@property (nonatomic,copy)NSString * htmlStr;


//当前访问的URL
@property (nonatomic,copy)NSString * NewUrl;

//识用说标题
@property (nonatomic,copy)NSString * ShiYongShuoTitle;

//识用说ID
@property (nonatomic,copy)NSString * ShiYongShuoID;

//识用说数组
@property (nonatomic,strong)NSMutableArray * ShiYongShuoArray;

//识用说模型数组
@property (nonatomic,strong)NSArray * ShiYongShuoModelArray;



//识用说详情标题数组
@property (nonatomic,strong)NSArray * segmentControlArray;

//识用说索引位置
@property NSInteger selectIndex;

//小的webview 请求的URL地址
@property(nonatomic,copy)NSString * smallWebUrl;

@property BOOL smallWebShow;


//使用说
@property (nonatomic,strong)NSMutableDictionary * shiyongshuoDict;

//天猫订单
@property (nonatomic,strong)NSMutableArray * ConditionArray;
@property (nonatomic,copy)NSString * alipay1;
@property (nonatomic,copy)NSString * url1;

//代维权URL
@property (nonatomic,strong)NSString * daiweiquanURL;

@property (nonatomic,copy)NSString * doctitle;

@end
