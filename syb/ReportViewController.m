//
//  ReportViewController.m
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportDetailViewController.h"
@implementation ReportViewController
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
    
    if (self.update == YES) {
        [CollectionView.header beginRefreshing];
        self.update = NO;
    }
    [self initBackButton];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
    [MobClick beginLogPageView:@"质检报告"];
}

-(void)initBackButton
{
    if (!backButton) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.navigationController.navigationBar addSubview:backButton];
}



-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [MobClick endLogPageView:@"质检报告"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self OtherSetup];
    [self addParameter];
    [self PageLayout];
    
}
//页面设置
-(void)PageSetup
{
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"质检报告";
    
}
//其他设置
-(void)OtherSetup
{
    self.update = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//请求数据的方法
-(void)requestDataWithPage:(int)Type
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_page,@"page", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getReportList pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
      
        
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        _reportModelArray = [ReportModel mj_objectArrayWithKeyValuesArray:[_objDict valueForKey:@"result"]];
        
        if (Type == 1) {
            _reportListArray = [NSMutableArray arrayWithArray:_reportModelArray];
            [CollectionView.header endRefreshing];
            [CollectionView reloadData];
            
        }else if(Type == 2){
            
            NSMutableArray * Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:_reportListArray];
            [Array addObjectsFromArray:_reportModelArray];
            _reportListArray = Array;
            [CollectionView.footer endRefreshing];
            [CollectionView reloadData];
        }
        
        if ([_reportListArray count]==0) {
            [HDHud showMessageInView:self.view title:@"暂无结果"];
        }else if ([_reportListArray count]>9)
        {
            [CollectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            
            [CollectionView reloadData];
            
        }
    };
    request.failureGetData = ^(void){
        
        [CollectionView.header endRefreshing];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}

//添加更新控件
-(void)addRefresh
{
    
    [CollectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [CollectionView.header setTitle:@"下拉可以刷新了" forState:MJRefreshHeaderStateIdle];
    [CollectionView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [CollectionView.header setTitle:@"正在刷新 ..." forState:MJRefreshHeaderStateRefreshing];
}
//设置请求参数
-(void)addParameter
{
    _page = @"1";
}
//更新数据
-(void)headerRereshing
{
    [self requestDataWithPage:1];
}
//加载更多数据
-(void)loadMoreData
{
    int page = [_page intValue];
    page ++;
    _page = [NSString stringWithFormat:@"%d",page];
    [self requestDataWithPage:2];
    
    
}

//页面布局
-(void)PageLayout
{
    
    if(!CollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64) collectionViewLayout:layout];
        CollectionView.alwaysBounceVertical = YES;
        CollectionView.backgroundColor = [UIColor whiteColor];
        [CollectionView registerClass:[ReportCell class]forCellWithReuseIdentifier:@"reportCell"];
        CollectionView.dataSource = self;
        CollectionView.delegate = self;
        CollectionView.scrollEnabled = YES;
        
        
        [self.view addSubview:CollectionView];
        [self addRefresh];
    }
}

#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    
    return [_reportListArray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ReportModel * model = _reportListArray[indexPath.item];
    
    ReportCell * cell = (ReportCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"reportCell" forIndexPath:indexPath];

    
    NSString *  imageurl = model.main_image;
    
    UIImage * noimage = [UIImage imageNamed:@"noimage"];

    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:noimage];
    
    
    cell.cellTitle.text = model.short_title;
    
    cell.CategoryLabel.text = model.cat_name;
    
    cell.dateLabel.text= model.create_date;
    
    
    
//    
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    
    
    
    return cell;
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(140*Proportion,200*Proportion);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hehe");
    
    ReportModel * model = _reportListArray[indexPath.item];
    ReportDetailViewController * reportDetailVc = [[ReportDetailViewController alloc]init];
    reportDetailVc.model = model;
    [self.navigationController pushViewController:reportDetailVc animated:YES];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




@end
