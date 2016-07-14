//
//  MallViewController.m
//  syb
//
//  Created by GX on 15/10/28.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "MallViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "TaoBaoSearchViewController.h"
@implementation MallViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initTitleLabel];
     [MobClick beginLogPageView:@"电商导航"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@NO];
}
-(void)initTitleLabel
{
    
    
    if (!TitleLabel) {
        TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-80, 44)];
        TitleLabel.textColor = [UIColor blackColor];
        TitleLabel.font = [UIFont boldSystemFontOfSize:16];
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.backgroundColor = [UIColor clearColor];
        NSString * str = @"安心购 （长按可显示该商家简介）";
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];;
       
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:10.0]
                              range:NSMakeRange(4, 12)];
        TitleLabel.attributedText = AttributedStr;
      
    }
    
    [self.navigationController.navigationBar addSubview:TitleLabel];
   
    
    
    
}
//页面设置
-(void)PageSetup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.title = @"";
   [self.navigationController.navigationBar setTranslucent:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TitleLabel removeFromSuperview];
    [MobClick endLogPageView:@"电商导航"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isShow = NO;
    [self initHeaderLabel];
    [self initLineLabel];
    [self InitHeaderButton];
    [self initAuthenticationLabel];
    [self requestCategoryData];
    [self InitFirstImageView];
    [self InitCollectionView];
    [self OtherSetup];
}

-(void)requestCategoryData
{
   
    [HDHud showHUDInView:self.view title:@"加载中..."];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_MallCateList pragma:nil ImageData:nil];
    request.successGetData = ^(id obj){
        //加载框消失
      
     
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        _categoryMallArray = [_objDict valueForKey:@"result"];
     
        
        _MallTileArray = [NSMutableArray array];
        
        for (NSDictionary * dict in _categoryMallArray) {
            NSString * site_cate_name = [dict valueForKey:@"site_cat_name"];
            [_MallTileArray addObject:site_cate_name];
        }
        
        HeaderLabel.hidden = NO;
        lineLabel.hidden = NO;
        AuthenticationLabel.hidden = NO;
        
        [self InitTabelView];
        [self requestMallData];
        
    };
    request.failureGetData = ^(void){
      
        [HDHud showNetWorkErrorInView:self.view];
    };
}
//请求商城数据
-(void)requestMallData
{
    _site_cat_id = [[_categoryMallArray objectAtIndex:0] valueForKey:@"site_cat_id"];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_site_cat_id,@"sc_id", nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_MallList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        _MallArray = [obj valueForKey:@"result"];
       
        NSArray * modelArray = [MallModel mj_objectArrayWithKeyValuesArray:_MallArray];
        
        _MallListArray = [NSMutableArray arrayWithArray:modelArray];
        
        [CollectionView reloadData];
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}

//其他设置
-(void)OtherSetup
{
  
    self.automaticallyAdjustsScrollViewInsets = NO;
}


-(void)InitFirstImageView
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Mallfirst"]) {

        NSLog(@"Complate");
        
    }else
    {
        FirstImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        FirstImageView.userInteractionEnabled = YES;
        FirstImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgvClick:)];
        tap.numberOfTapsRequired = 1;
        [FirstImageView  addGestureRecognizer:tap];
        FirstImageView.image = [UIImage imageNamed:@"mallfirst"];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:FirstImageView];
        [window bringSubviewToFront:self.view];
    }
    
}

-(void)imgvClick:(UITapGestureRecognizer*)recognizer
{

    FirstImageView.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Mallfirst"];

}
-(void)InitHeaderButton
{
    if (!HeaderButton) {
        HeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        HeaderButton.frame = CGRectMake(0, 114, SCREEN_WIDTH, 50*Proportion);
        UIImage * headerImage = [UIImage imageNamed:@"tianmaosearch"];
        [HeaderButton setBackgroundImage:headerImage forState:UIControlStateNormal];
        [HeaderButton addTarget:self action:@selector(HeaderClick:) forControlEvents:UIControlEventTouchUpInside];
        HeaderButton.layer.masksToBounds = YES;
        HeaderButton.hidden = NO;
        HeaderButton.layer.borderWidth=0.5;
        HeaderButton.layer.borderColor = [UIColor grayColor].CGColor;
       
    }
     [self.view addSubview:HeaderButton];
}
-(void)initHeaderLabel
{
    if (!HeaderLabel) {
        HeaderLabel = [[UILabel alloc]init];
        HeaderLabel.frame = CGRectMake(10, 64, SCREEN_WIDTH-20, 50);
        HeaderLabel.textColor = [UIColor blackColor];
        HeaderLabel.text = @"   通过识用宝到如下网商平台购物,识用宝提供售后维权支持，包括：取证、检测、消协对接、律所律师援助等。";
        HeaderLabel.font = [UIFont boldSystemFontOfSize:12*Proportion];
        HeaderLabel.numberOfLines = 2;
        
    }
    [self.view addSubview:HeaderLabel];
}


-(void)initAuthenticationLabel
{
    if (!AuthenticationLabel) {
        AuthenticationLabel = [[UILabel alloc]init];
        AuthenticationLabel.frame = CGRectMake(80+30*Proportion, SCREEN_HEIGHT-84, SCREEN_WIDTH/2+20*Proportion, 23);
        AuthenticationLabel.backgroundColor = RGBACOLOR(228, 228, 228, 1);
        AuthenticationLabel.text = @"含未经识用宝正品检测认证商家";
        AuthenticationLabel.textColor = [UIColor blackColor];
        AuthenticationLabel.font = [UIFont systemFontOfSize:12];
        AuthenticationLabel.textAlignment = NSTextAlignmentCenter;
        AuthenticationLabel.layer.cornerRadius = 5;
        AuthenticationLabel.layer.masksToBounds = YES;
        AuthenticationLabel.hidden = YES;
        [self.view addSubview:AuthenticationLabel];
    }
}

-(void)initLineLabel
{
    if (!lineLabel) {
        lineLabel = [[UILabel alloc]init];
        lineLabel.frame = CGRectMake(0, 164 , SCREEN_WIDTH, .5);
        lineLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        lineLabel.hidden = YES;
        [self.view addSubview:lineLabel];
    }
}

-(void)InitTabelView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,115+50*Proportion, 80, SCREEN_HEIGHT-164-50*Proportion) style:UITableViewStylePlain];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor = BGColor;
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TableView.showsVerticalScrollIndicator = YES;
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [self.view addSubview:TableView];
    }

 
}
-(void)viewDidLayoutSubviews
{
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  [_categoryMallArray  count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    
    static NSString * cellID = @"MallCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = BGColor;
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = ThemeColor;
        NSIndexPath * first = [NSIndexPath indexPathForRow:0 inSection:0];
        [TableView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionNone];
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.5];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = [[_categoryMallArray objectAtIndex:indexPath.row]valueForKey:@"site_cat_name"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    _site_cat_id = [[_categoryMallArray objectAtIndex:indexPath.row] valueForKey:@"site_cat_id"];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_site_cat_id,@"sc_id", nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_MallList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        _MallArray = [obj valueForKey:@"result"];
        
        NSArray * modelArray = [MallModel mj_objectArrayWithKeyValuesArray:_MallArray];
        
        _MallListArray = [NSMutableArray arrayWithArray:modelArray];
        
        [CollectionView reloadData];
        
        
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}

//集合视图
-(void)InitCollectionView
{
    
    if(!CollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80,115+50*Proportion,SCREEN_WIDTH-80,SCREEN_HEIGHT-199-50*Proportion) collectionViewLayout:layout];
        CollectionView.alwaysBounceVertical = YES;
        CollectionView.backgroundColor = [UIColor clearColor];
        [CollectionView registerClass:[MallCollectionViewCell class]
           forCellWithReuseIdentifier:@"MallCollectionViewCell"];
        
        CollectionView.dataSource = self;
        CollectionView.delegate = self;
        CollectionView.scrollEnabled = YES;
        [self.view addSubview:CollectionView];
    }
  
    
}

#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_MallListArray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MallModel * mallmodel = _MallListArray[indexPath.item];
    
    MallCollectionViewCell * cell = (MallCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"MallCollectionViewCell" forIndexPath:indexPath];


    cell.backgroundColor = [UIColor whiteColor];
    cell.mallModel = mallmodel;

    //图片视图
    cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,8*Proportion, 72*Proportion, 56*Proportion)];
    NSString * imageUrl = cell.mallModel.site_logo;
    [cellImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    cellImage.layer.masksToBounds = YES;
    [cell.contentView addSubview:cellImage];
    
    cell.tag = indexPath.item;
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.numberOfTouchesRequired = 1;
    [cell addGestureRecognizer:longPressGr];
    
    
    return cell;
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(72*Proportion,72*Proportion);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(4,3,4,3);
    
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        
        MallModel * mallmodel = _MallListArray[indexPath.item];
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webViewType = WebViewTypeShiYongShuo;
        webVC.requestURL = mallmodel.link_url;
        webVC.webTitle  = mallmodel.site_name;
        webVC.DaiWeiQuan = @"daiweiquan";
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        MallCollectionViewCell * cell = (MallCollectionViewCell*)[gesture view];
        NSLog(@"%ld",(long)cell.tag);
        
        MallModel * mallmodel = _MallListArray[cell.tag];
        _shopDetailUrl = mallmodel.site_intro_url;
        _BuyDetailUrl  = mallmodel.link_url;
        _shopTitle  = mallmodel.site_name;
        
        NSLog(@"^^^^^%@",_shopDetailUrl);
        if (![_shopDetailUrl isEqualToString:@""]) {
            [self initPopView];
        }else
        {
            [HDHud showMessageInView:self.view title:@"抱歉，没有该商城的简介"];
        }

        
    }
    
}
-(void)initPopView
{
    
    if (!customPopView) {
        customPopView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        customPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        customPopView.userInteractionEnabled = YES;
    }

    if (!headerView) {
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 350)];
        headerView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [headerView addGestureRecognizer:tapGesture];
    }
    
  
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH,310);
        _webView.scalesPageToFit = NO;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.bounces = NO;
      

    }
    NSURL * requestURL = [NSURL URLWithString:_shopDetailUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    [_webView loadRequest:request];
    
    

    if (!cancleBtn) {
        //取消按钮
        cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleBtn.frame = CGRectMake(SCREEN_WIDTH-40, -15, 30, 30);
        cancleBtn.layer.masksToBounds = YES;
        cancleBtn.layer.cornerRadius = 15;
        UIImage * btnimg = [UIImage imageNamed:@"webcancle"];
        [cancleBtn setImage:btnimg forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!goBuyView) {
        
        goBuyView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
        goBuyView.backgroundColor = RGBACOLOR(234, 234, 234, 1);
    }
    
    if (!goBuyBtn) {
        
        goBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        goBuyBtn.frame = CGRectMake(SCREEN_WIDTH/2-40, 4, 80, 30);
        goBuyBtn.backgroundColor = [UIColor redColor];
        [goBuyBtn setTitle:@"去购买" forState:UIControlStateNormal];
        [goBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        goBuyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        goBuyBtn.layer.cornerRadius = 3;
        [goBuyBtn addTarget:self action:@selector(goBuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
  
    if (!testActivityIndicator) {
        
        testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        testActivityIndicator.center = CGPointMake(SCREEN_WIDTH/2,175);
        testActivityIndicator.color = ThemeColor;
        [testActivityIndicator setHidesWhenStopped:YES];
    }
    
    
    
    
    [goBuyView addSubview:goBuyBtn];
    [customPopView addSubview:headerView];
    [_webView addSubview:cancleBtn];
    [_webView addSubview:testActivityIndicator];
    [customPopView addSubview:_webView];
    [customPopView addSubview:goBuyView];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:customPopView];
    
    [self tappedCancel];
    
    
}


-(void)goBuyBtnClick:(UIButton*)sender
{
    [self tappedCancel];
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        
        NSString * Url = [NSString stringWithFormat:@"%@",_BuyDetailUrl];
        NSString * webTitle = [NSString stringWithFormat:@"%@",_shopTitle];
        WebViewController * webVC = [[WebViewController alloc]init];
        webVC.webViewType = WebViewTypeShiYongShuo;
        webVC.requestURL = Url;
        webVC.webTitle = webTitle;
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
- (void)tappedCancel
{
    
    
    if (_isShow==NO&&![_doctitle isEqualToString:@"404 Not Found"] ) {
      
        [UIView animateWithDuration:0.25f animations:^{
            [customPopView setFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
            
        } completion:^(BOOL finished) {
            _isShow = YES;
        }];
        
        
        
    }else if (_isShow==NO&&[_doctitle isEqualToString:@"404 Not Found"] )
    {
         [HDHud showMessageInView:self.view title:@"亲，该商城的简介跑火星去了..."];
        
    }else {
        [UIView animateWithDuration:0.25f animations:^{
            [customPopView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT)];
            
        } completion:^(BOOL finished) {
            _isShow = NO;
        }];
        
     
    }
    
    
    


}

-(void)cancleClick:(UIButton*)sender
{
    [self tappedCancel];
}
#pragma WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    [testActivityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    _doctitle = [_webView documentTitle];
    NSLog(@"%@",_doctitle);
    if ([_doctitle isEqualToString:@"404 Not Found"]) {
        
        [UIView animateWithDuration:0.25f animations:^{
            [customPopView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT)];
            
        } completion:^(BOOL finished) {
            _isShow = NO;
        }];
        [HDHud showMessageInView:self.view title:@"亲，该商城的简介跑火星去了..."];
    }
    
    [testActivityIndicator stopAnimating];
}

-(void)HeaderClick:(UIButton*)sender
{
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        
        TaoBaoSearchViewController * TaobaoSearchVC = [[TaoBaoSearchViewController alloc]init];
        [self.navigationController pushViewController:TaobaoSearchVC animated:NO];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
@end
