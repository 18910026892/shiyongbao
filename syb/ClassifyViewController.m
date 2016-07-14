//
//  ClassifyViewController.m
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "ClassifyViewController.h"
#import "GoodsViewController.h"
@interface ClassifyViewController ()

@end

@implementation ClassifyViewController
- (id)init
{
    self = [super init];
    if (self) {
    
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self PageSetup];
 
   [MobClick beginLogPageView:@"商品分类"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"商品分类"];
}
//页面设置
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self requestTableData];
    [self PageLayout];    
}


//数据请求
-(void)requestTableData
{
  
    [HDHud showHUDInView:self.view title:@"加载中..."];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id1,@"cat_id",nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GoodsCategoryList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
    
     
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        //左侧表格视图
        _TableModelArray = [ClassifyTableModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        _TableList  = [NSMutableArray arrayWithArray:_TableModelArray];
        [TableView reloadData];

        if ([_TableList count]==0) {
            NSLog(@"没数据");
        }else
        {
            [self requestCollectionData];
        }
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
    
}

-(void)requestCollectionData
{
    ClassifyTableModel * classifyTableModel = _TableList[0];
    
    _cat_id2 = classifyTableModel.cat_id;
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id2,@"cat_id",nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GoodsCategoryList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];

        
        //右侧结合视图
        _CollectionModelArray = [ClassifyCollectionModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        _CollectionList = [NSMutableArray arrayWithArray:_CollectionModelArray];
        [CollectionView reloadData];
  
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}

//页面布局
-(void)PageLayout
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 80, SCREEN_HEIGHT-113) style:UITableViewStylePlain];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor = [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TableView.showsVerticalScrollIndicator = YES;
        [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        [self.view addSubview:TableView];
    }
    
    if (!CollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80,0,SCREEN_WIDTH-80, SCREEN_HEIGHT-113) collectionViewLayout:layout];
        CollectionView.alwaysBounceVertical = YES;
        CollectionView.backgroundColor = [UIColor whiteColor];
        [CollectionView registerClass:[ClassifyCollectionCell class]
       forCellWithReuseIdentifier:@"ClassifyCollectionCell"];
        [CollectionView registerClass:[ClassifyCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyCollectionCellHeader"];
        CollectionView.dataSource = self;
        CollectionView.delegate = self;
        CollectionView.scrollEnabled = YES;
        [self.view addSubview:CollectionView];
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
    return  [_TableList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    ClassifyTableModel * classifyTableModel = _TableList[indexPath.row];
    
    static NSString * cellID = @"ClassifyCell";

    ClassifyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ClassifyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = BGColor;
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = ThemeColor;
        cell.textLabel.textColor = RGBACOLOR(51, 51, 51, 1);
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
    cell.textLabel.text = classifyTableModel.cat_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ClassifyTableModel * classifyTableModel = _TableList[indexPath.row];
  
    _cat_id3 = [NSString stringWithFormat:@"%@",classifyTableModel.cat_id];

    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_cat_id3,@"cat_id",nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GoodsCategoryList pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
   
        //右侧结合视图
        _CollectionModelArray = [ClassifyCollectionModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        _CollectionList = [NSMutableArray arrayWithArray:_CollectionModelArray];
        
        [CollectionView reloadData];
        
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}


#pragma CollectionView 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_CollectionList count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ClassifyCollectionModel * classifyCollectionModel = _CollectionList[indexPath.item];
    
    ClassifyCollectionCell * cell =  (ClassifyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyCollectionCell" forIndexPath:indexPath];
  
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.ClassifyCollectionModel = classifyCollectionModel;
    //图片视图
    ClassifyImage = [[UIImageView alloc]initWithFrame:CGRectMake(7*Proportion, 0, 56*Proportion, 56*Proportion)];
    NSString * imageUrl = cell.ClassifyCollectionModel.cat_ico;
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [ClassifyImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:noimage];
    [cell.contentView addSubview:ClassifyImage];
    
    //标题
    ClassifyTitle = [[UILabel alloc]initWithFrame:CGRectMake(12*Proportion, 76*Proportion, 56*Proportion, 20*Proportion)];
    ClassifyTitle.textAlignment = NSTextAlignmentCenter;
    ClassifyTitle.textColor = [UIColor blackColor];
    ClassifyTitle.font = [UIFont systemFontOfSize:12];
    ClassifyTitle.backgroundColor = [UIColor clearColor];
    ClassifyTitle.text = cell.ClassifyCollectionModel.cat_name;
    [cell.contentView addSubview:ClassifyTitle];
    
    

    
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
    return CGSizeMake(70*Proportion,110*Proportion);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10*Proportion,5*Proportion, 10*Proportion,5*Proportion);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(SCREEN_WIDTH-80, 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionFooter) {
        NSLog(@"footer");
    }
    ClassifyCollectionHeader * CollectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ClassifyCollectionCellHeader" forIndexPath:indexPath];
  
    return CollectionHeader;
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyCollectionModel * classifyCollectionModel = _CollectionList[indexPath.item];
    GoodsViewController * goodsVC = [[GoodsViewController alloc]init];
    goodsVC.cat_id = classifyCollectionModel.cat_id;
    goodsVC.title = classifyCollectionModel.cat_name;
    [self.navigationController pushViewController:goodsVC animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
