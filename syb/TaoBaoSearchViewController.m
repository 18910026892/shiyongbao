//
//  TaoBaoSearchViewController.m
//  syb
//
//  Created by GX on 15/11/12.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "TaoBaoSearchViewController.h"
#import "WebViewController.h"
@implementation TaoBaoSearchViewController

- (id)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self InitNavigationBar];
    
    _CanAddRecord = YES;

    _searchRecordArray = [UserDefaultsUtils valueWithKey:@"TaoBaoSearchRecord"];
    
    if ([_searchRecordArray count]>0) {
        
        [self InitTableView];
    }
    [MobClick beginLogPageView:@"淘宝搜索"];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_SearchBarView removeFromSuperview];
    [_CancleButton removeFromSuperview];
    [MobClick endLogPageView:@"淘宝搜索"];
   
}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationItem.hidesBackButton = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
}
//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}
//取消搜索
-(void)cancleSearch:(UIButton *)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:NO];
}

//页面布局
-(void)InitNavigationBar
{
   
    if (!_SearchBar) {
        _SearchBar = [[SearchTextField alloc]initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-100, 28)];
        _SearchBar.placeholder = @"寻找宝贝/店铺";
        _SearchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        _SearchBar.returnKeyType = UIReturnKeySearch;
        _SearchBar.font = [UIFont boldSystemFontOfSize:14.0];
        _SearchBar.textColor = RGBCOLOR(112, 112, 112);
        _SearchBar.delegate = self;
        _SearchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _SearchBar.tintColor = ThemeColor;
        [_SearchBar becomeFirstResponder];
        
    }
    
   
    if (!_CancleButton) {
        _CancleButton = [[UIButton alloc] init];
        _CancleButton.frame = CGRectMake(SCREEN_WIDTH-60, 8, 50, 28);
        _CancleButton.backgroundColor = [UIColor clearColor];
        [_CancleButton setTitleColor:ThemeColor                          forState:UIControlStateNormal];
        [_CancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _CancleButton.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
        _CancleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _CancleButton.hidden = NO;
        [_CancleButton addTarget:self action:@selector(cancleSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_SearchBarView) {
        _SearchBarView = [[UIView alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-70, 28)];
        _SearchBarView.layer.cornerRadius = 5;
        _SearchBarView.layer.borderWidth = 0.4;
        _SearchBarView.layer.borderColor = [UIColor grayColor].CGColor;
        _SearchBarView.backgroundColor = [UIColor whiteColor];
        [_SearchBarView addSubview:_SearchBar];
        
    }
    
    [self.navigationController.navigationBar addSubview:_SearchBarView];
    [self.navigationController.navigationBar addSubview:_CancleButton];
    
}

-(void)InitTableView
{
    
    if (!cleanRecordButton) {
        cleanRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cleanRecordButton.frame = CGRectMake(40, 25,SCREEN_WIDTH-80, 40);
        cleanRecordButton.backgroundColor = [UIColor clearColor];
        [cleanRecordButton setTitle:@"清除历史搜索" forState:UIControlStateNormal];
        [cleanRecordButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        cleanRecordButton.layer.borderColor = ThemeColor.CGColor;
        cleanRecordButton.layer.borderWidth = 1;
        cleanRecordButton.layer.cornerRadius = 5;
        cleanRecordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cleanRecordButton addTarget:self action:@selector(cleanRecordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    if (!TabelViewFooterView) {
        TabelViewFooterView = [[UIView alloc]init];
        TabelViewFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
        TabelViewFooterView.backgroundColor = [UIColor clearColor];
        [TabelViewFooterView addSubview:cleanRecordButton];
    }
    
    //表格视图初始化
    if (!TableView) {
        
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor = [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TableView.showsVerticalScrollIndicator = YES;
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        TableView.tableFooterView = TabelViewFooterView;
        [self.view addSubview:TableView];
        
    }else
    {
        [TableView reloadData];
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
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 20);
    label.font= [UIFont boldSystemFontOfSize:15];
    label.text = @"最近搜索";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,30)] ;
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView addSubview:label];
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return  [_searchRecordArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    
    static NSString * cellID = @"Cell";
    UITableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
    }else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = [[_searchRecordArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString * keyword = [[_searchRecordArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:keyword,@"keyword", nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_RebateTbSearch pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
     
        
        NSString * code = [obj valueForKey:@"code"];
        NSString * message = [obj valueForKey:@"message"];
        _click_url = [[obj valueForKey:@"result"]valueForKey:@"click_url"];
        
        if ([code isEqualToString:@"1"]) {
            WebViewController * webVC = [[WebViewController alloc]init];
            webVC.webViewType = WebViewTypeShiYongShuo;
            webVC.requestURL = _click_url;
            webVC.webTitle  = keyword;
          
            [self.navigationController pushViewController:webVC animated:YES];
        }else if ([code isEqualToString:@"0"])
        {
            [HDHud showMessageInView:self.view title:message];
        }
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
  
}



-(void)cleanRecordButtonClick:(UIButton*)sender
{
    
    _searchRecordArray = [NSMutableArray array];
    [_searchRecordArray addObjectsFromArray:[UserDefaultsUtils valueWithKey:@"TaoBaoSearchRecord"]];
    [_searchRecordArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"TaoBaoSearchRecord"];
    [TableView removeFromSuperview];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [_SearchBar resignFirstResponder];
    
    if ([_SearchBar.text isEmpty]) {
        [HDHud showMessageInView:self.view title:@"请先输入关键词"];
    }else
    {
        [self addRecord:_SearchBar.text];
        
        NSString * keyword = _SearchBar.text;
        NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:keyword,@"keyword", nil];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_RebateTbSearch pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            
            NSString * code = [obj valueForKey:@"code"];
            NSString * message = [obj valueForKey:@"message"];
            _click_url = [[obj valueForKey:@"result"]valueForKey:@"click_url"];
            
            if ([code isEqualToString:@"1"]) {
                WebViewController * webVC = [[WebViewController alloc]init];
                webVC.webViewType = WebViewTypeShiYongShuo;
                webVC.requestURL = _click_url;
                webVC.webTitle  = keyword;
                webVC.DaiWeiQuan = @"daiweiquan";
              
                [self.navigationController pushViewController:webVC animated:YES];
            }else if ([code isEqualToString:@"0"])
            {
                [HDHud showMessageInView:self.view title:message];
            }
          
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
        
    }
    
    return YES;
    
}

-(void)addRecord:(NSString*)title;
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title", nil];
    
    if (![UserDefaultsUtils valueWithKey:@"TaoBaoSearchRecord"]) {
        _searchRecordArray = [NSMutableArray arrayWithObjects:postDict, nil];
        [UserDefaultsUtils saveValue:_searchRecordArray forKey:@"TaoBaoSearchRecord"];
    }else
    {
        NSMutableArray * array1 =  [UserDefaultsUtils valueWithKey:@"TaoBaoSearchRecord"];
        NSMutableArray * array2 = [NSMutableArray array];
        [array2 addObjectsFromArray:array1];
        for (NSDictionary * dict in array1) {
            NSString * oldTitle  = [dict valueForKey:@"title"];
            if ([oldTitle isEqualToString:title]) {
                _CanAddRecord = NO;
            }
        }
        if (_CanAddRecord) {
            [array2 addObject:postDict];
            [UserDefaultsUtils saveValue:array2 forKey:@"TaoBaoSearchRecord"];
        }else
        {
            NSLog(@"该商品之前已经记录过了");
        }
        
        
    }
    
    
}



@end
