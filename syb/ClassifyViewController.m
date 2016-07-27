//
//  ClassifyViewController.m
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ProductGoodsViewCotroller.h"
@implementation ClassifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setTabBarHide:YES];
    [MobClick beginLogPageView:@"商品分类"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"商品分类"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"商品分类"];
    [self showBackButton:YES];
    [self setupDatas];
    [self setupViews];
}
-(void)setupViews
{
    [self.view addSubview:self.TableView];
    [self.view addSubview:self.CollectionView];
}
-(void)setupDatas
{
    
    [self getGoodsCatList];

}

//获取商品分类列表
-(void)getGoodsCatList
{
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_StoreGoodsFirstLevelCats pragma:nil];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            NSLog(@" %@",response);
          
            _tableArray = [response valueForKey:@"result"];
            
            _tableModelArray = [ClassifyTableModel mj_objectArrayWithKeyValuesArray:_tableArray];
            _tableListArray  = [NSMutableArray arrayWithArray:_tableModelArray];
            
            [self.TableView reloadData];
            
            if ([_tableListArray count]>0) {
                [self getCollectionData];
            }
            
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
    
    

}


//获取商品分类列表
-(void)getCollectionData;
{
    
    NSString * catID;
    
    ClassifyTableModel * classifyTableModel = _tableListArray[0];
    
    catID = classifyTableModel.cat_id;
    
   
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:catID,@"cat_id", nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetStoreGoodsSubCats pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
 
            
            _collectionSectionArray = [response valueForKey:@"result"];

            [self.CollectionView reloadData];
            
            NSLog(@" %@ ",response);
            
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
    
    
    
}


-(UITableView*)TableView
{
    if(!_TableView)
    {
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, 80, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.backgroundColor = [UIColor clearColor];
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _TableView.showsVerticalScrollIndicator = YES;
        [_TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
      
    }
    return _TableView;
}
-(void)viewDidLayoutSubviews
{
    if ([self.TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.TableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
    return  [_tableListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    ClassifyTableModel * classifyTableModel = _tableListArray[indexPath.row];
    
    static NSString * cellID = @"ClassifyCell";
    
    ClassifyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ClassifyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = kDefaultBackgroundColor;
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = ThemeColor;
        cell.textLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        NSIndexPath * first = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.TableView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionNone];
        
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
     ClassifyTableModel * classifyTableModel = _tableListArray[indexPath.row];
    
    NSString * catID = classifyTableModel.cat_id;
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:catID,@"cat_id", nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetStoreGoodsSubCats pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
              NSLog(@" %@ ",response);
            
            _collectionSectionArray = [response valueForKey:@"result"];
            
            [self.CollectionView reloadData];
            
            
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
    

    
    
}

-(UICollectionView*)CollectionView
{
    if (!_CollectionView) {
 
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80,64,SCREEN_WIDTH-80, SCREEN_HEIGHT-64) collectionViewLayout:layout];
            _CollectionView.alwaysBounceVertical = YES;
            _CollectionView.backgroundColor = [UIColor whiteColor];
            [_CollectionView registerClass:[ClassifyCollectionCell class]
               forCellWithReuseIdentifier:@"ClassifyCollectionCell"];
            [_CollectionView registerClass:[ClassifyCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyCollectionCellHeader"];
            _CollectionView.dataSource = self;
            _CollectionView.delegate = self;
            _CollectionView.scrollEnabled = YES;

    }
    return _CollectionView;
}
#pragma CollectionView 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return [_collectionSectionArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    _collectionArray = [_collectionSectionArray[section] valueForKey:@"sub_cats"];


    return [_collectionArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    _collectionArray = [_collectionSectionArray[indexPath.section] valueForKey:@"sub_cats"];
    
    _collectionModelArray = [ClassifyCollectionModel mj_objectArrayWithKeyValuesArray:_collectionArray];
    _collectionListArray  = [NSMutableArray arrayWithArray:_collectionModelArray];
    

    ClassifyCollectionModel * classifyCollectionModel = _collectionListArray[indexPath.item];
    
    ClassifyCollectionCell * cell =  (ClassifyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyCollectionCell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    cell.ClassifyCollectionModel = classifyCollectionModel;
    //图片视图
    ClassifyImage = [[UIImageView alloc]initWithFrame:CGRectMake(7*Proportion, 0, 56*Proportion, 56*Proportion)];
    NSString * imageUrl = cell.ClassifyCollectionModel.cat_image_url;
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [ClassifyImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:noimage];
    [cell.contentView addSubview:ClassifyImage];
    
    //标题
    ClassifyTitle = [[UILabel alloc]initWithFrame:CGRectMake(12*Proportion, 76*Proportion, 46*Proportion, 20*Proportion)];
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
    
    
    
    NSDictionary * indexDict = _collectionSectionArray[indexPath.section];
    NSString * titleString = [NSString stringWithFormat:@"   %@", [indexDict valueForKey:@"cat_name"]];
    
    
    CollectionHeader.header = titleString;
    
    
    return CollectionHeader;
}

#pragma mark --UICollectionViewDelegate
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _collectionArray = [_collectionSectionArray[indexPath.section] valueForKey:@"sub_cats"];
    
    _collectionModelArray = [ClassifyCollectionModel mj_objectArrayWithKeyValuesArray:_collectionArray];
    _collectionListArray  = [NSMutableArray arrayWithArray:_collectionModelArray];
    

    ClassifyCollectionModel * classifyCollectionModel = _collectionListArray[indexPath.item];
    ProductGoodsViewCotroller * goodsVC = [ProductGoodsViewCotroller viewController];
    goodsVC.cat_id = classifyCollectionModel.cat_id;
    goodsVC.navTitle = classifyCollectionModel.cat_name;
    [self.navigationController pushViewController:goodsVC animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
