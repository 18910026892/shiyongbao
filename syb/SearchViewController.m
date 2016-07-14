//
//  SearchViewController.m
//  syb
//
//  Created by GX on 15/10/20.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "SearchViewController.h"

#import "GoodsSearchResultViewController.h"
#import "ShopsSearchResultViewController.h"


@interface SearchViewController ()

@end

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setNavigationBarHide:NO];
   
    [self setTabBarHide:YES];
    
    _CanAddRecord = YES;
    
    _searchType = @"0";
    
    if([_searchType isEqualToString:@"0"])
    {
        _GoodsSearchArray = [UserDefaultsUtils valueWithKey:@"goodssearchRecord"];
        _searchRecordArray = [NSMutableArray arrayWithArray:_GoodsSearchArray];
    }else if([_searchType isEqualToString:@"1"])
    {
        _ShopsSearchArray = [UserDefaultsUtils valueWithKey:@"shopssearchRecord"];
        _searchRecordArray = [NSMutableArray arrayWithArray:_ShopsSearchArray];
    }
    
    if ([_searchRecordArray count]>0) {
        
        [self InitTableView];
    }
 
     [MobClick beginLogPageView:@"识用宝搜索"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [MobClick endLogPageView:@"识用宝搜索"];

 
}

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTypeChanged) name:@"SearchTypeChange" object:nil];
    
    [self searchTypeChanged];
    [self setupViews];
    
}


-(void)InitTableView
{

    //表格视图初始化
    if (!_TableView) {
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.backgroundColor = [UIColor clearColor];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _TableView.showsVerticalScrollIndicator = YES;
        [_TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _TableView.tableFooterView = self.TabelViewFooterView;
        [self.view addSubview:_TableView];
        
    }else
    {
        [self.TableView reloadData];
    }
    
    
}


-(void)setupViews
{
   
    [self.Customview addSubview:self.SearchBarView];
    [self.Customview addSubview:self.CancleButton];
 
    
}
- (void)searchTypeChanged
{
    NSNumber *number = [Config currentConfig].searchType;
    
    if (number.intValue == 0)
    {
        [self.SearchTypeButton setTitle:@"商品" forState:UIControlStateNormal];
        _GoodsSearchArray = [UserDefaultsUtils valueWithKey:@"goodssearchRecord"];
        _searchRecordArray = [NSMutableArray arrayWithArray:_GoodsSearchArray];
        
        
    }
    else if (number.intValue == 1)
    {
        [self.SearchTypeButton setTitle:@"店铺" forState:UIControlStateNormal];
        _ShopsSearchArray = [UserDefaultsUtils valueWithKey:@"shopssearchRecord"];
        _searchRecordArray = [NSMutableArray arrayWithArray:_ShopsSearchArray];
        
        
        
    }
    
    [self.TableView reloadData];
    
    
    _searchType = [NSString stringWithFormat:@"%@",number];
    
    [self.SearchTypeButton setImage:[UIImage imageNamed:@"downArrowGray"] forState:UIControlStateNormal];

    
}
//搜索类型的实现
- (void)searchTypeBtnTapped:(id)sender
{
    
    [ChooseSearchTypeView showOnWindow];
    [_SearchTypeButton setImage:[UIImage imageNamed:@"upArrowGray"] forState:UIControlStateNormal];
}
//取消搜索
-(void)cancleSearch:(UIButton *)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:NO];
}

//页面布局
-(SearchTextField*)SearchBar
{

    if (!_SearchBar) {
        _SearchBar = [[SearchTextField alloc]initWithFrame:CGRectMake(65,0, 260*Proportion-66, 28)];
        _SearchBar.placeholder = @"搜索商品/店铺";
        _SearchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        _SearchBar.returnKeyType = UIReturnKeySearch;
        _SearchBar.font = [UIFont boldSystemFontOfSize:14.0];
        _SearchBar.textColor = RGBCOLOR(112, 112, 112);
        _SearchBar.delegate = self;
        _SearchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _SearchBar.tintColor = ThemeColor;
        [_SearchBar becomeFirstResponder];
  
    }
    return _SearchBar;
}
-(UIView*)SearchBarView
{
    if (!_SearchBarView) {
        _SearchBarView = [[UIView alloc]initWithFrame:CGRectMake(9, 28, 260*Proportion, 28)];
        _SearchBarView.layer.cornerRadius = 5;
        _SearchBarView.layer.borderWidth = 0.4;
        _SearchBarView.layer.borderColor = [UIColor grayColor].CGColor;
        _SearchBarView.backgroundColor = [UIColor whiteColor];
        [_SearchBarView addSubview:self.SearchTypeButton];
        [_SearchBarView addSubview:self.SearchBar];
        
    }
    return _SearchBarView;
}
-(UIButton*)CancleButton
{
    
    if (!_CancleButton) {
        _CancleButton = [[UIButton alloc] init];
        _CancleButton.frame = CGRectMake(SCREEN_WIDTH-50, 28, 50, 28);
        _CancleButton.backgroundColor = [UIColor clearColor];
        [_CancleButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_CancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _CancleButton.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
        _CancleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _CancleButton.hidden = NO;
        [_CancleButton addTarget:self action:@selector(cancleSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _CancleButton;
}
-(UIButton*)SearchTypeButton
{
    if (!_SearchTypeButton)
    {
        _SearchTypeButton = [[UIButton alloc] init];
        _SearchTypeButton.frame = CGRectMake(0, 0, 60, 28);
        
        if (IOS7)
        {
            _SearchTypeButton.backgroundColor = [UIColor clearColor];
            [_SearchTypeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_SearchTypeButton setTitleColor:ThemeColor forState:UIControlStateHighlighted];
        }
        else
        {
            
            _SearchTypeButton.backgroundColor = [UIColor clearColor];
            [_SearchTypeButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
            [_SearchTypeButton setTitleColor:ThemeColor forState:UIControlStateHighlighted];
            
        }
        
        [_SearchTypeButton setTitle:@"商品" forState:UIControlStateNormal];
        
        [_SearchTypeButton setImage:[UIImage imageNamed:@"downArrowGray"] forState:UIControlStateNormal];
        _SearchTypeButton.imageEdgeInsets = UIEdgeInsetsMake(0,45, 0, 0);
        _SearchTypeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _SearchTypeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _SearchTypeButton.hidden = NO;
        [_SearchTypeButton addTarget:self action:@selector(searchTypeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _SearchTypeButton;
}

-(UIButton*)cleanRecordButton
{
    
    if (!_cleanRecordButton) {
        _cleanRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cleanRecordButton.frame = CGRectMake(40, 25,SCREEN_WIDTH-80, 40);
        _cleanRecordButton.backgroundColor = [UIColor clearColor];
        [_cleanRecordButton setTitle:@"清除历史搜索" forState:UIControlStateNormal];
        [_cleanRecordButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        _cleanRecordButton.layer.borderColor = ThemeColor.CGColor;
        _cleanRecordButton.layer.borderWidth = 1;
        _cleanRecordButton.layer.cornerRadius = 5;
        _cleanRecordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cleanRecordButton addTarget:self action:@selector(cleanRecordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cleanRecordButton;
}

-(UIView*)TabelViewFooterView{
    if (!_TabelViewFooterView) {
        _TabelViewFooterView = [[UIView alloc]init];
        _TabelViewFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
        _TabelViewFooterView.backgroundColor = [UIColor clearColor];
        [_TabelViewFooterView addSubview:self.cleanRecordButton];
    }
    return _TabelViewFooterView;
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
    UITableViewCell * cell = [_TableView dequeueReusableCellWithIdentifier:cellID];
   

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
        cell.textLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        cell.textLabel.text = [[_searchRecordArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        cell.backgroundColor = [UIColor whiteColor];
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString * keyword = [[_searchRecordArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    
    if ([_searchType isEqualToString:@"0"]) {
        
        GoodsSearchResultViewController * GsrVC = [[GoodsSearchResultViewController alloc]init];
        GsrVC.KeyWord = keyword;
        GsrVC.title = keyword;
        [self.navigationController pushViewController:GsrVC animated:YES];
        
        
    } else if([_searchType isEqualToString:@"1"])
    {
        ShopsSearchResultViewController * SsrVc = [[ShopsSearchResultViewController alloc]init];
        SsrVc.KeyWord = keyword;
        SsrVc.title = keyword;
        [self.navigationController pushViewController:SsrVc animated:YES];
        
    }
    
    
}



-(void)cleanRecordButtonClick:(UIButton*)sender
{

   
    
    
    if ([_searchType isEqualToString:@"0"]) {
        
        
        _searchRecordArray = [NSMutableArray array];
        [_searchRecordArray addObjectsFromArray:[UserDefaultsUtils valueWithKey:@"goodssearchRecord"]];
        [_searchRecordArray removeAllObjects];
      
        
    }else if([_searchType isEqualToString:@"1"])
    {
        _searchRecordArray = [NSMutableArray array];
        [_searchRecordArray addObjectsFromArray:[UserDefaultsUtils valueWithKey:@"shopssearchRecord"]];
        [_searchRecordArray removeAllObjects];
      
    }
    
      [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"goodssearchRecord"];
      [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shopssearchRecord"];
  
    [_TableView reloadData];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [_SearchBar resignFirstResponder];

    if ([_SearchBar.text isEmpty]) {
        [HDHud showMessageInView:self.view title:@"请先输入关键词"];
    }else
    {
         [self addRecord:_SearchBar.text];
       
        if ([_searchType isEqualToString:@"0"]) {
            
            GoodsSearchResultViewController * GsrVC = [[GoodsSearchResultViewController alloc]init];
            GsrVC.KeyWord = _SearchBar.text;
            
            [self.navigationController pushViewController:GsrVC animated:YES];
            
            
        } else if([_searchType isEqualToString:@"1"])
        {
            ShopsSearchResultViewController * SsrVc = [[ShopsSearchResultViewController alloc]init];
            SsrVc.KeyWord =_SearchBar.text;
            
            [self.navigationController pushViewController:SsrVc animated:YES];
            
        }
       
    }
    
    return YES;
    
}

-(void)addRecord:(NSString*)title;
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title", nil];
 
    
     if ([_searchType isEqualToString:@"0"])
     {
         if (![UserDefaultsUtils valueWithKey:@"goodssearchRecord"]) {
             _GoodsSearchArray = [NSMutableArray arrayWithObjects:postDict, nil];
             [UserDefaultsUtils saveValue:_GoodsSearchArray forKey:@"goodssearchRecord"];
         }else
         {
             NSMutableArray * array1 =  [UserDefaultsUtils valueWithKey:@"goodssearchRecord"];
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
                 [UserDefaultsUtils saveValue:array2 forKey:@"goodssearchRecord"];
             }else
             {
                 NSLog(@"该商品之前已经记录过了");
             }
             
             
         }
         
         
         
     }else if ([_searchType isEqualToString:@"1"])
     {
         if (![UserDefaultsUtils valueWithKey:@"shopssearchRecord"]) {
             _ShopsSearchArray = [NSMutableArray arrayWithObjects:postDict, nil];
             [UserDefaultsUtils saveValue:_ShopsSearchArray forKey:@"shopssearchRecord"];
         }else
         {
             NSMutableArray * array1 =  [UserDefaultsUtils valueWithKey:@"shopssearchRecord"];
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
                 [UserDefaultsUtils saveValue:array2 forKey:@"shopssearchRecord"];
             }else
             {
                 NSLog(@"该店铺之前已经记录过了");
             }
             
             
         }
         
         
         
     }
    
    
    
 

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
