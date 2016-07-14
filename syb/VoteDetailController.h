//
//  VoteDetailController.h
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerButton.h"
#import "SearchTextField.h"
#import <UMSocial.h>
#import "TouPiaoModel.h"
@interface VoteDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate,PickerButtonDelegate,UITextFieldDelegate,UIWebViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate>
{
    
    UIImageView * cellimg;
    UILabel * celltitle,* rankLabel,*countLabel;
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
@property (nonatomic,strong)NSDictionary * vote_goods;

@property (nonatomic,strong)TouPiaoModel * toupiaoModel;

@property (nonatomic,strong)PickerButton * pickerButton;

@property (nonatomic,strong)UIView *HeaderView;

@property (nonatomic,strong)NSDictionary * voteDict;

@property(nonatomic,strong)UITableView * TableView;

@property (nonatomic,strong)UIButton * backButton;

@property (nonatomic,strong)UIButton * shareButton;

@property (nonatomic,strong)UILabel * sectionTitle;

@property (nonatomic,strong)UILabel * haibugouLabel;

@property (nonatomic,strong)SearchTextField * CustomTF;

@property (nonatomic,strong)UILabel * feihuaLabel;

@property (nonatomic,strong)UIView * FooterView;

@property (nonatomic,strong)UIButton * toupiaoButton;



@property (nonatomic,strong)NSMutableArray * AllSiteArray;
@property (nonatomic,strong)NSMutableArray * AllSiteNameArray;


@property (nonatomic,strong)NSMutableArray * VoteSiteArray;



@property (nonatomic,strong)UILabel * selectBG;

@property NSInteger index;

@property (nonatomic,strong)NSMutableDictionary * toupiaoDict;

//识用说索引位置
@property NSInteger selectIndex;
//小的webview 请求的URL地址
@property(nonatomic,copy)NSString * smallWebUrl;
//识用说详情标题数组
@property (nonatomic,strong)NSArray * segmentControlArray;
//识用说
@property (nonatomic,strong)NSMutableDictionary * shiyongshuoDict;

@property (nonatomic,strong)NSMutableDictionary * selectDict;

@property(nonatomic,strong)NSMutableArray * shareArray;
@property (nonatomic,strong)NSString * shareContent;
@property (nonatomic,strong)NSString * shareTitle;
@property (nonatomic,strong)NSString * shareUrl;

//展示数组
@property (nonatomic,strong)NSMutableArray * showArray;

@property (nonatomic,strong)UIView * footerHeader;

@property (nonatomic,strong)NSString * vote_manual_site_id;

@property (nonatomic,strong)NSString * vote_manual_store_name;
@end
