//
//  BaseViewController.m
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import <IQKeyboardManager.h>
@interface BaseTabBarController()

@end

@implementation BaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
     
    }
    return self;
}

+ (instancetype)viewController{
    
    return [[self alloc] init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    [self preferredStatusBarStyle];
    
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar = [BaseTabBarController shareTabBarController];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = kDefaultBackgroundColor;
    
    _Customview = [[UIImageView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, kMainScreenWidth,self.navigationController.navigationBar.frame.size.height)];
    _Customview.userInteractionEnabled = YES;
   //  _Customview.image = [UIImage imageNamed:@"nav_background"];
    _Customview.backgroundColor = kNavBackGround;
    
    _LeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LeftBtn.titleLabel.font = [UIFont fontWithName:KContentFont size:16.0];
    _LeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 25);
    [_LeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 2, 20)];
    _LeftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    _RightBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    _RightBtn.titleLabel.font = [UIFont fontWithName:KContentFont size:14.0];
    _RightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_RightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0,-10)];
    //[_RightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [_RightBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/4, 10*Proportion,kMainScreenWidth/2, 50*Proportion)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.adjustsFontSizeToFitWidth =YES;
    _titleLabel.minimumScaleFactor = 0.5;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _Customview.frame = CGRectMake(0, 0,kMainScreenWidth,64);
        [_LeftBtn setFrame:CGRectMake(10,20, 64*Proportion, 44)];
        [_RightBtn setFrame:CGRectMake(kMainScreenWidth - 88, 20,88, 44)];
        _titleLabel.frame = CGRectMake(100*Proportion, 20,kMainScreenWidth-200*Proportion, 44);
    }
    else {
        _Customview.frame = CGRectMake(0, 0,kMainScreenWidth,44);
        [_LeftBtn setFrame:CGRectMake(10, 10, 64*Proportion, 44)];
        [_RightBtn setFrame:CGRectMake(kMainScreenWidth - 88, 10*Proportion, 88, 44)];
        _titleLabel.frame = CGRectMake(100*Proportion, 0,kMainScreenWidth-200*Proportion, 44);
    }
    
    [_Customview addSubview:_RightBtn];
    [_Customview addSubview:_LeftBtn];
    [_Customview addSubview:_titleLabel];
    [self.view addSubview:_Customview];
}

//设置title
-(void)setNavTitle:(NSString *)title;
{
    self.titleLabel.text = title;
}

-(void)showBackButton:(BOOL)show{
    self.LeftBtn.hidden = !show;
    
    if(show){
        [self.LeftBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        
        [self.LeftBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.LeftBtn setImage:nil forState:UIControlStateNormal];
        [self.LeftBtn removeTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)backEvent{
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if(_isPopToRoot==YES)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(void)setBackImageViewWithName:(NSString *)imgName
{
    _backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _backImageView.image = [UIImage imageNamed:imgName];
    [self.view insertSubview:_backImageView atIndex:0];
}

- (void)setupViews
{
    
    
    
}
-(void)setupDatas
{
    
}

- (void)setNavigationBarHide:(BOOL)isHide;
{
    if(isHide){
        [_Customview removeFromSuperview];
    }else{
        [self.view addSubview:_Customview];
    }
}

- (void)setTabBarHide:(BOOL)isHide
{
    if(isHide){
        [self.tabBar hiddenTabBar:YES];
    }else{
        [self.tabBar hiddenTabBar:NO];
    }
}


#pragma mark - NoDataView method
/**
 *  显示无数据视图
 *
 *  @param frame 内容显示的frame
 */
- (void)showNoDataViewWithFrame:(CGRect)frame{
    if (!_noDataView) {
        _noDataView =  [[BKNodataView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _noDataView.delegate = self;
    }
    [_noDataView showNoDataViewController:self noDataType:kNoDataType_Default];
    [_noDataView setContentViewFrame:frame];
}

- (void)showNoDataViewInView:(UIView *)superView{
    //    -(void)showNoDataView:(UIView*)superView noDataType:(NODataType)type
    if (!_noDataView) {
        _noDataView =  [[BKNodataView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _noDataView.delegate = self;
    }
    [_noDataView showNoDataView:superView noDataType:kNoDataType_Default];
}
- (void)showNoDataViewInView:(UIView *)superView noDataString:(NSString *)noDataString
{
    if (!_noDataView) {
        _noDataView =  [[BKNodataView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _noDataView.delegate = self;
    }
    [_noDataView showNoDataView:superView noDataString:noDataString];
    

}

- (void)showSmileNoDataViewInView:(UIView *)superView noDataString:(NSString *)noDataString;
{
    if (!_noDataView) {
        _noDataView =  [[BKNodataView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _noDataView.delegate = self;
    }
    [_noDataView showSmileNodataView:superView noDataString:noDataString];
}
- (void)showNoDataView
{
    [self showLoadFailView:YES noDataType:0];
}

- (void)hideNoDataView
{
    [self showLoadFailView:NO noDataType:0];
}

- (void)showLoadFailView:(BOOL)isShow noDataType:(NODataType)nodataType{
    if(isShow){
        if (!_noDataView) {
            _noDataView = [[BKNodataView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            _noDataView.delegate = self;
        }
        [_noDataView showNoDataViewController:self noDataType:nodataType];
    }
    else{
        [_noDataView hide];
    }
}
#pragma mark - show or hide noNetWorkView method
-(void)showNoNetWorkView{
    [self showNoNetWorkViewInView:self.view];
}

- (void)showNoNetWorkView:(NoNetWorkViewStyle)style{
    return [self showNoNetWorkViewInView:self.view frame:self.view.bounds style:style];
}

- (void)showNoNetWorkViewWithFrame:(CGRect)frame{
    [self showNoNetWorkViewInView:self.view frame:frame];
}

-(void)showNoNetWorkViewInView:(UIView *)view{
    [self showNoNetWorkViewInView:view frame:view.bounds];
}

- (void)showNoNetWorkViewInView:(UIView *)view frame:(CGRect)frame{
    NoNetWorkViewStyle style = NoNetWorkViewStyle_No_NetWork;
    AFNetworkReachabilityStatus networkStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if(networkStatus == AFNetworkReachabilityStatusReachableViaWiFi || networkStatus == AFNetworkReachabilityStatusReachableViaWWAN){
        //加载失败
        style = NoNetWorkViewStyle_Load_Fail;
    }
    [self showNoNetWorkViewInView:view frame:frame style:style];
}

- (void)showNoNetWorkViewInView:(UIView *)view frame:(CGRect)frame style:(NoNetWorkViewStyle)style{
    if (!_noNetWorkView) {
        _noNetWorkView = [[BKNoNetView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _noNetWorkView.delegate = self;
    }
    [_noNetWorkView showInView:view style:style];
    _noNetWorkView.frame = frame;
}

-(void)hideNoNetWorkView
{
    [_noNetWorkView hide];
}

//Overide method
#pragma mark NoNetWorkViewDelegate
-(void)retryToGetData{
    [self hideNoNetWorkView];
    [self hideNoDataView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reLogin{
    NSLog(@"重新登录");
}


-(void)dealloc{
    //[[Httprequest shareRequest] cancelRequest];
}

@end
