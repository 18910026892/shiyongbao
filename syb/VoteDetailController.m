//
//  VoteDetailController.m
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "VoteDetailController.h"
#import <IQKeyboardManager.h>
#import "LoginViewController.h"
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import "VoteDetailCell.h"
@implementation VoteDetailController
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)setKeyboardConfic
{
    //打开键盘通知
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:50];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self.navigationController.navigationBar addSubview:self.backButton];
    [self.navigationController.navigationBar addSubview:self.shareButton];
    
    [MobClick beginLogPageView:@"鉴证2"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];
    [self.shareButton removeFromSuperview];
    [MobClick endLogPageView:@"鉴证2"];
    

}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
}
-(UIButton*)backButton
{
    if (!_backButton) {
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 44, 44);
        [_backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
    
}
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}



-(UIButton*)shareButton
{
    if (!_shareButton) {
        
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(SCREEN_WIDTH-50, 0, 44, 44);
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        _shareButton.enabled = NO;
        [_shareButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareButton;
}
-(void)getshiyongshuo
{
    
    
    NSString * shiyongshuoID = [_vote_goods valueForKey:@"goods_id"];
    
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:shiyongshuoID,@"goods_id", nil];
    
    NSLog(@"%@",postDict);
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_SearchProductById pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        NSLog(@"***%@",obj);
        
        NSArray * resultArray = [obj valueForKey:@"result"];
        
        if ([resultArray count]>0) {
            _shiyongshuoDict = resultArray[0];
        }
        
       shiyongshuoButton.enabled = YES;
        
    };
    request.failureGetData = ^(void){
        
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}
-(void)shareButtonClick:(UIButton*)sender
{

    //微信
   
    [UMSocialWechatHandler setWXAppId:@"wx6ce9b0678b8452b4" appSecret:@"836df79dd9b950f0ca4888ff8fd8e522" url:_shareUrl];
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _shareTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _shareTitle;
    
    
    //打开新浪微博的SSO开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
     
   [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2615361489"
                                              secret:@"1a2845caf946207db3b3966269318c90"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1104475469" appKey:@"v73xN4C1jk7NrN2N" url:_shareUrl];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    [UMSocialData defaultData].extConfig.qqData.title = _shareTitle;
    [UMSocialData defaultData].extConfig.qzoneData.title = _shareTitle;
    
    
    UIImage * shareImage = [UIImage imageNamed:@"shareimage"];
    
    NSArray * shareArray;
    
    if ([_shareArray count]==0) {
        shareArray  = [NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil];
    }else
    {
        shareArray = [NSArray arrayWithArray:_shareArray];
    }

    
    NSString * shareText = [NSString stringWithFormat:@"%@,%@\n\n%@",_shareTitle,_shareContent,_shareUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"552f1092fd98c59fbd00227a"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:shareArray
                                       delegate:self];
    


    
    
}
//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"鉴.正";
    [self setKeyboardConfic];
    [self requestData];
    [self GetSharePlatform];
    _segmentControlArray = @[[@"识真伪" uppercaseString], [@"知应用" uppercaseString], [@"通养护" uppercaseString], [@"规格参数" uppercaseString]];
}

-(UIView*)HeaderView
{
    if (!_HeaderView) {
        _HeaderView = [[UIView alloc]init];
       _HeaderView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 100);
        _HeaderView.backgroundColor = [UIColor whiteColor];

        //图片
        if (!cellimg) {
            cellimg = [[UIImageView alloc]init];
            cellimg.frame = CGRectMake(15,15, 70, 70);
            cellimg.backgroundColor = [UIColor whiteColor];
            cellimg.layer.cornerRadius = 3;
            cellimg.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
            cellimg.layer.borderWidth = .5;
            NSString * goodsImageUrl =  _toupiaoModel.main_image;
    
            UIImage * noimage = [UIImage imageNamed:@"noimage"];
                    [cellimg sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
        }
        
        
        //产品标题
        if (!celltitle) {
            celltitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200*Proportion, 40)];
            celltitle.textColor = [UIColor blackColor];
            celltitle.font = [UIFont systemFontOfSize:16.0];
            celltitle.textAlignment = NSTextAlignmentLeft;
            celltitle.numberOfLines = 2;
           // celltitle.lineBreakMode = NSLineBreakByCharWrapping;
            celltitle.backgroundColor = [UIColor clearColor];
            celltitle.text = _toupiaoModel.short_title;
        }
 
        if (!rankLabel) {
            rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 200*Proportion, 20)];
            rankLabel.textColor = [UIColor grayColor];
            rankLabel.font = [UIFont systemFontOfSize:14.0];
            rankLabel.textAlignment = NSTextAlignmentLeft;
            rankLabel.backgroundColor = [UIColor clearColor];
            rankLabel.text = [NSString stringWithFormat:@"目前排名：%@",_toupiaoModel.vote_sort];
        }
        
        if (!countLabel) {
            countLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 200*Proportion, 20)];
            countLabel.textColor = [UIColor grayColor];
            countLabel.font = [UIFont systemFontOfSize:14.0];
            countLabel.textAlignment = NSTextAlignmentLeft;
            countLabel.backgroundColor = [UIColor clearColor];
            countLabel.text =[NSString stringWithFormat:@"已有投票：%@",_toupiaoModel.vote_total];
        }
        
        

        if (!line) {
            line = [[UILabel alloc]initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = BGColor;
        }
        
        if (!shiyongshuoButton) {
            shiyongshuoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            shiyongshuoButton.frame = CGRectMake(SCREEN_WIDTH-80, 62, 60, 25);
            shiyongshuoButton.backgroundColor = [UIColor whiteColor];
            [shiyongshuoButton setTitle:@"识用说" forState:UIControlStateNormal];
            [shiyongshuoButton setTitleColor:RGBACOLOR(102, 102, 102, 1) forState:UIControlStateNormal];
            shiyongshuoButton.layer.borderColor = RGBACOLOR(114, 114, 114, 1).CGColor;            shiyongshuoButton.layer.cornerRadius = 5;
            shiyongshuoButton.layer.borderWidth = 0.5;
            shiyongshuoButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [shiyongshuoButton addTarget:self action:@selector(shiyongshuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            shiyongshuoButton.enabled = NO;
        }
        
        [_HeaderView addSubview:cellimg];
        [_HeaderView addSubview:celltitle];
        [_HeaderView addSubview:rankLabel];
        [_HeaderView addSubview:countLabel];
        [_HeaderView addSubview:line];
        [_HeaderView addSubview:shiyongshuoButton];
    }
    return _HeaderView;
}
-(void)shiyongshuoButtonClick:(UIButton*)sender
{
    NSLog(@"shiyongshuo");
    
    
    if (IS_DICTIONARY_CLASS(_shiyongshuoDict)) {
        if(!segmetedControl)
        {
            segmetedControl = [[UISegmentedControl alloc] initWithItems:_segmentControlArray];
            segmetedControl.tintColor = ThemeColor;
            segmetedControl.frame =CGRectMake(20,5,SCREEN_WIDTH-40, 30);
            segmetedControl.selectedSegmentIndex = _selectIndex;
            [segmetedControl addTarget:self action: @selector(controlPressed:)
                      forControlEvents:UIControlEventValueChanged
             ];
            segmetedControl.backgroundColor = [UIColor clearColor];
            
        }
        
        
        
        
        webView = [[UIWebView alloc]init];
        webView.frame = CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT-204);
        webView.scalesPageToFit = NO;
        webView.delegate = self;
        webView.backgroundColor = [UIColor clearColor];
        
        NSString * urlString = [_shiyongshuoDict valueForKey:@"pinjian"];
        NSURL * loadUrl = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loadUrl];
        [webView loadRequest:urlRequest];
        
        
        if (!testActivityIndicator) {
            
            testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            testActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,120);//只能设置中心，不能设置大小
            testActivityIndicator.color = ThemeColor;
            [testActivityIndicator setHidesWhenStopped:YES];
            [testActivityIndicator startAnimating];
            [webView addSubview:testActivityIndicator];
        }
        
        
        if (!headerView) {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164)];
            headerView.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
            [headerView addGestureRecognizer:tapGesture];
        }
        
        if (!cpvBGview) {
            
            cpvBGview = [[UIView alloc] initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH,SCREEN_HEIGHT-164)];
            cpvBGview.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
        }
        
        
        
        customPopView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        customPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        customPopView.userInteractionEnabled = YES;
        
        
        
        [cpvBGview addSubview:webView];
        [cpvBGview addSubview:segmetedControl];
        [customPopView addSubview:headerView];
        [customPopView addSubview:cpvBGview];
        
        
        [UIView animateWithDuration:0.25f animations:^{
            [customPopView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
            
        } completion:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:customPopView];

    }else
    {
        
        [HDHud showMessageInView:self.view title:@"暂无信息"];
    }
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [testActivityIndicator stopAnimating];
}


- (void)controlPressed:(id)sender {
    
    _selectIndex = segmetedControl.selectedSegmentIndex;
    
    
    
    switch (_selectIndex) {
        case 0:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"pinjian"];
        }
            break;
        case 1:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"yingyong"];
        }
            break;
        case 2:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"kehu"];
        }
            break;
        case 3:
        {
            _smallWebUrl = [_shiyongshuoDict  valueForKey:@"guige"];
        }
            break;
        default:
            break;
    }
    
    
    NSURL * loadUrl = [NSURL URLWithString:_smallWebUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:loadUrl];
    [webView loadRequest:urlRequest];
    
    
}

#pragma mark - ViewController Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}
-(void)cancleClick:(UIButton*)sender
{
    [self tappedCancel];
}
//识用说页面消失
- (void)tappedCancel
{
    
    
    [UIView animateWithDuration:0.25f animations:^{
        [customPopView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        customPopView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [customPopView removeFromSuperview];
        }
    }];
}

-(void)GetSharePlatform

{
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_toupiaoModel.qa_id,@"vote_id",nil];
    
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GetSharePlatform pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失

        
        self.shareButton.enabled = YES;
        
        NSDictionary * resultDict = [obj valueForKey:@"result"];
        
        _shareArray = [resultDict valueForKey:@"iOSshare"];
        _shareTitle = [resultDict valueForKey:@"shareTitle"];
        _shareUrl  = [resultDict valueForKey:@"shareUrl"];
        _shareContent = [resultDict valueForKey:@"ShareContent"];
        
        
    };
    request.failureGetData = ^(void){
        
        
    };
}


-(void)requestData
{
    
    [HDHud showHUDInView:self.view title:@"加载中..."];
      NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_toupiaoModel.qa_id,@"qaId",nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_VoteGoodsDetail_V2  pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失

        [HDHud hideHUDInView:self.view];
        
        
        NSLog(@"投票详情的数据是******%@",obj);
        
        _vote_goods = [[obj valueForKey:@"result"] valueForKey:@"vote_goods"];
        
        
        _VoteSiteArray = [[obj valueForKey:@"result"] valueForKey:@"vote_store"];
        
        _AllSiteArray = [[obj valueForKey:@"result"] valueForKey:@"all_rebate_sites"];
    
        _AllSiteNameArray = [NSMutableArray array];
        

        _showArray = [NSMutableArray array];
        [_showArray addObjectsFromArray:_VoteSiteArray];
        
        NSDictionary * haibugouDict = @{@"haibugou":@"自己举荐",@"qt_store_id":@"",@"qt_store_name":@""};
        [_showArray addObject:haibugouDict];
        
        
        
        for (NSDictionary * dict in _AllSiteArray) {
            NSString * siteName = [dict valueForKey:@"site_name"];
            [_AllSiteNameArray addObject:siteName];
        }
          //  NSLog(@"平台的数组是%@",_VoteSiteArray);
        
         [self.view addSubview:self.TableView];
        
        
        
       [HDHud hideHUDInView:self.view];
        
    
        [self getshiyongshuo];
        
    };
    request.failureGetData = ^(void){
        
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}


-(UITableView*)TableView
{
    if (!_TableView)
    {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.backgroundColor = [UIColor whiteColor];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _TableView.tableHeaderView = self.HeaderView;
        _TableView.tableFooterView = self.FooterView;
    }
    
    return _TableView;
}
-(PickerButton*)pickerButton
{
 
        CGRect rect = CGRectMake(25,5,SCREEN_WIDTH-50, 30);
   
        _pickerButton =  [[PickerButton alloc]initWithItemList:_AllSiteNameArray];

        
        _pickerButton.frame = rect;
        
        [_pickerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        _pickerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _pickerButton.isShowSelectItemOnButton = YES;
        
        _pickerButton.delegate = self;
        
        [_pickerButton setBackgroundColor:[UIColor whiteColor]];
    
    
       [_pickerButton setImage:[UIImage imageNamed:@"downArrowGray"] forState:UIControlStateNormal];
    
       _pickerButton.imageEdgeInsets = UIEdgeInsetsMake(0,250*Proportion, 0, 0);
    
       _pickerButton.titleEdgeInsets = UIEdgeInsetsMake(0, -220*Proportion, 0, 0);
    
 
       _pickerButton.layer.borderWidth = .5;
    
       _pickerButton.layer.borderColor = [UIColor grayColor].CGColor;
  
        _pickerButton.layer.cornerRadius = 5;
    
        _pickerButton.hidden = YES;
    
    return _pickerButton;
}
-(SearchTextField*)CustomTF
{
    if (!_CustomTF) {
        _CustomTF = [[SearchTextField alloc]initWithFrame:CGRectMake(25,45,SCREEN_WIDTH-50, 30)];
        _CustomTF.textColor = [UIColor blackColor];
        _CustomTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _CustomTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _CustomTF.keyboardType = UIKeyboardTypeDefault;
        _CustomTF.returnKeyType = UIReturnKeyDefault;
        _CustomTF.delegate = self;
        _CustomTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _CustomTF.placeholder = @"  输入完整店铺名称";
        _CustomTF.layer.borderWidth=.5;
        _CustomTF.layer.borderColor = [UIColor grayColor].CGColor;
        _CustomTF.layer.cornerRadius = 5;
        _CustomTF.hidden = YES;
        _CustomTF.tintColor = ThemeColor;
        _CustomTF.font = [UIFont systemFontOfSize:14];
    }
    return _CustomTF;
}
#pragma PickerButton Delegate

- (void)pickerButton:(PickerButton *)button
      didSelectIndex:(NSInteger)index
             andItem:(NSString *)item;
{
    NSLog(@"%ld **** %@ ",(long)index,item);
    
 
   _vote_manual_site_id  = [_AllSiteArray[index] valueForKey:@"action_id"];
    
    NSLog(@" %@",_vote_manual_site_id);
    
}

-(UILabel*)haibugouLabel
{
    if (!_haibugouLabel) {
        _haibugouLabel = [[UILabel alloc]init];
        _haibugouLabel.frame = CGRectMake(20, 10, 60, 40);
        _haibugouLabel.text = @"更多";
        _haibugouLabel.textColor = [UIColor blackColor];
        _haibugouLabel.font = [UIFont systemFontOfSize:14];
    }
    return _haibugouLabel;
    
    
    
}


-(UILabel*)feihuaLabel
{
    if (!_feihuaLabel) {
        _feihuaLabel = [[UILabel alloc]init];
        _feihuaLabel.frame = CGRectMake(20, 60, SCREEN_WIDTH-40, 60);
        _feihuaLabel.text = @"  如果您能举荐您信任的该商品卖家，我们将不胜感激！我们将比对筛选大家举荐的卖家，进行“正品检测认证”，并把通过“正品认证”的优秀卖家推荐给更多的消费者。";
        _feihuaLabel.font = [UIFont systemFontOfSize:12.0];
        _feihuaLabel.numberOfLines = 4;
    }
    return _feihuaLabel;
}

-(UIView*)FooterView
{
    if (!_FooterView) {
        _FooterView = [[UIView alloc]init];
        _FooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        _FooterView.backgroundColor = [UIColor whiteColor];
        _footerHeader = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 80)];
        _footerHeader.backgroundColor = [UIColor whiteColor];
        [_footerHeader addSubview:self.pickerButton];
        [_footerHeader addSubview:self.CustomTF];
       

        [_FooterView addSubview:_footerHeader];
        [_FooterView addSubview:self.toupiaoButton];
        [_FooterView addSubview:self.feihuaLabel];
      
        
    }
    
    return _FooterView;
}
-(UIButton*)toupiaoButton
{
    
    if (!_toupiaoButton) {
        _toupiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _toupiaoButton.frame = CGRectMake(20, 12.5, SCREEN_WIDTH-40, 35);
        _toupiaoButton.backgroundColor = ThemeColor;
        [_toupiaoButton setTitle:@"投票" forState:UIControlStateNormal];
        [_toupiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toupiaoButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _toupiaoButton.layer.cornerRadius = 3.5;
        [_toupiaoButton addTarget:self action:@selector(toupiaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
  
    return  _toupiaoButton;
}
-(void)toupiaoButtonClick:(UIButton*)sender
{
    NSLog(@"toupiao");
    
    SM = [SingleManage shareManage];
    if (!SM.isLogin) {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];

        
    }else if(SM.isLogin)
    {
        
        if (IS_DICTIONARY_CLASS(_selectDict)) {
            NSDictionary * postDict;
            
            NSString * token = SM.userToken;
            
            NSString * vote_store_idNumber = [_selectDict valueForKey:@"qt_store_id"];
            
            NSString * voteid = [_vote_goods valueForKey:@"qa_id"];
    
            NSString * action_id = [_selectDict valueForKey:@"action_id"];
            NSString * store_name = [_selectDict valueForKey:@"qt_store_name"];
            

            
            
            if (![vote_store_idNumber isEqualToString:@""]) {
                
                
                NSString * vote_store_id = vote_store_idNumber;
                
                postDict = [NSDictionary dictionaryWithObjectsAndKeys:voteid,@"qa_id",token,@"token",@"iOS",@"vote_resource",vote_store_id,@"qt_store_id",action_id,@"action_id",store_name,@"store_name", nil];
                
                
                NSLog(@"投票1要传递的参数是%@",postDict);
                [HDHud showHUDInView:self.view title:@"正在投票..."];
                
                GXHttpRequest * request = [[GXHttpRequest alloc]init];
                [request StartWorkPostWithurlstr:URL_DoVoteGoods_V2 pragma:postDict ImageData:nil];
                
                request.successGetData = ^(id obj){
                    
                    NSLog(@"^^^%@",obj);
                    
                    [HDHud hideHUDInView:self.view];
                    
                    NSString * code = [obj valueForKey:@"code"];
                    
                    NSString * message = [obj valueForKey:@"message"];
                    
                    
                    if ([code isEqualToString:@"1"]) {
                        [HDHud showMessageInView:self.view title:@"投票成功"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadJianZheng"
                                                                            object:nil];
                        
                        [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
                        
                        
                    }else if ([code isEqualToString:@"0"])
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    
                };
                request.failureGetData = ^(void){
                    
                    [HDHud hideHUDInView:self.view];
                    [HDHud showNetWorkErrorInView:self.view];
                };

                
                
            }else if ([vote_store_idNumber isEqualToString:@""])
                
            {
       
                
                _vote_manual_store_name = self.CustomTF.text;
                
                if (!_vote_manual_site_id) {
                    _vote_manual_site_id = [_AllSiteArray[0] valueForKey:@"action_id"];
                }
                
                
                NSLog(@"_vote_manual_store_name == %@ _vote_manual_site_id = =%@",_vote_manual_store_name,_vote_manual_site_id);
                
                if ([_vote_manual_site_id isEmpty]||[_vote_manual_store_name isEmpty]) {
                    [HDHud showMessageInView:self.view title:@"请先选择平台并且输入店铺名称"];
                }else
                {
                    
                  
 
                    postDict = [NSDictionary dictionaryWithObjectsAndKeys:voteid,@"qa_id",token,@"token",@"iOS",@"vote_resource",_vote_manual_site_id,@"action_id",_vote_manual_store_name,@"store_name", nil];
                    
                    
                    NSLog(@"投票2 要传递的参数是%@",postDict);
                    
                    [HDHud showHUDInView:self.view title:@"正在投票..."];
                    
                    GXHttpRequest * request = [[GXHttpRequest alloc]init];
                    [request StartWorkPostWithurlstr:URL_DoVoteGoods_V2 pragma:postDict ImageData:nil];
                    
                    request.successGetData = ^(id obj){
                        
                        NSLog(@"^^^%@",obj);
                        
                        [HDHud hideHUDInView:self.view];
                        
                        NSString * code = [obj valueForKey:@"code"];
                        
                        NSString * message = [obj valueForKey:@"message"];
                        
                        
                        if ([code isEqualToString:@"1"]) {
                            [HDHud showMessageInView:self.view title:@"投票成功"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadJianZheng"
                                                                                object:nil];
                            
                            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
                            
                            
                        }else if ([code isEqualToString:@"0"])
                        {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        
                    };
                    request.failureGetData = ^(void){
                        
                        [HDHud hideHUDInView:self.view];
                        [HDHud showNetWorkErrorInView:self.view];
                    };

                    
                    
                }
                
                
            }
            
            
          
            
            
            

        }else
        {
  
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有举荐您认为可靠的卖家哦，如果您不想举荐，请确认通过" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
        

        
    }

     
 
}
-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return [_showArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        _sectionTitle.backgroundColor = BGColor;
        _sectionTitle.textColor = [UIColor grayColor];
        _sectionTitle.textAlignment = NSTextAlignmentLeft;
        _sectionTitle.font = [UIFont systemFontOfSize:14.0f];
        _sectionTitle.text = [NSString stringWithFormat:@"   举荐卖家（请您举荐您信任的卖家）"];
    }
    
    return _sectionTitle;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 30;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    VoteDetailCell * cell;
    
    if (!cell) {
        cell  = [[VoteDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = ThemeColor;
        
     
    
    }
    

   
    NSString * haibugou = [_showArray[indexPath.row] valueForKey:@"haibugou"];
    
    if ([haibugou length]==0) {
        NSString * storeName = [_showArray[indexPath.row] valueForKey:@"qt_store_name"];
        
        
        NSString * siteName = [_showArray[indexPath.row] valueForKey:@"site_name"];
        
        NSString * string = [NSString stringWithFormat:@"%@ %@",storeName,siteName];
        
        
        // 创建可变属性化字符串
        NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:string];
        
        
        
        // 设置颜色
        UIColor *color =  [UIColor blackColor];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:color
                           range:[string rangeOfString:storeName]];
        
        
        cell.cellTitle.attributedText = attrString;
        
        
        
    }else
    {
        cell.cellTitle.text = haibugou;
        cell.cellTitle.font = [UIFont systemFontOfSize:14.0f];
        cell.cellTitle.textColor = [UIColor grayColor];
    }
  
    
    

    
    
    
    return cell;
    
}
// 选中操作
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
    VoteDetailCell *lastCell = [tableView cellForRowAtIndexPath:lastIndex];
    lastCell.cellImage.image = [UIImage imageNamed:@"pingtaiunselect"];
    
    // 选中操作
    VoteDetailCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.cellImage.image = [UIImage imageNamed:@"pingtaiselect"];
    

    // 保存选中的
    _index = indexPath.row;
    [_TableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];


    
    NSInteger last = [_showArray count]-1;
    
    NSLog(@"****%ld",(long)last);
    
    if (_index==last) {
        
   
        
        _pickerButton.hidden = NO;
        _CustomTF.hidden = NO;
        
       _toupiaoButton.frame = CGRectMake(20, 92.5, SCREEN_WIDTH-40, 35);
        _feihuaLabel.frame = CGRectMake(20, 140, SCREEN_WIDTH-40, 60);
    }else
    {
         NSLog(@"other");
        _pickerButton.hidden = YES;
        _CustomTF.hidden = YES;
        _toupiaoButton.frame = CGRectMake(20, 12.5, SCREEN_WIDTH-40, 35);
        _feihuaLabel.frame = CGRectMake(20, 60, SCREEN_WIDTH-40, 60);
    }
    
      _selectDict = _showArray[indexPath.row];
    
    NSLog(@"******%@",_selectDict);
}

@end
