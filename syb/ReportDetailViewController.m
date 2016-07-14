//
//  ReportDetailViewController.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportDetailViewController.h"

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController
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
        [TableView.header beginRefreshing];
        self.update = NO;
    }
    [self initBackButton];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
    [MobClick beginLogPageView:@"质检报告2"];
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
    [MobClick endLogPageView:@"质检报告2"];
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
    
    NSString * qaID = _model.qa_id;
    
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:qaID,@"qaId", nil];
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getReportDetail pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        
        _objDict = [NSMutableDictionary dictionaryWithDictionary:obj];

        NSLog(@"*******%@",_objDict);
        
        
        NSArray * storeArray = [[_objDict valueForKey:@"result"] valueForKey:@"checkStore"];
        //质检通过的电商
        _SiteModelArray = [StoreModel mj_objectArrayWithKeyValuesArray:storeArray];
        
        _SiteListArray = [NSMutableArray arrayWithArray:_SiteModelArray];
     
        NSArray * eventArray = [[_objDict valueForKey:@"result"] valueForKey:@"reportContent"];

        
        _eventModelArray = [ReportDetailModel mj_objectArrayWithKeyValuesArray:eventArray];
        
        _eventListArray = [NSMutableArray arrayWithArray:_eventModelArray];
      

        [TableView.header endRefreshing];
        [TableView reloadData];
        
        
    };
    request.failureGetData = ^(void){
        
        [TableView.header endRefreshing];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
}

//添加更新控件
-(void)addRefresh
{
    
    [TableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [TableView.header setTitle:@"下拉可以刷新了" forState:MJRefreshHeaderStateIdle];
    [TableView.header setTitle:@"松开马上刷新" forState:MJRefreshHeaderStatePulling];
    [TableView.header setTitle:@"正在刷新 ..." forState:MJRefreshHeaderStateRefreshing];
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


//页面布局
-(void)PageLayout
{
    
    //图片
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(15,15, 70, 70);
        _cellImage.backgroundColor = [UIColor whiteColor];
        _cellImage.layer.cornerRadius = 3;
        _cellImage.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
        _cellImage.layer.borderWidth = .5;
        NSString * goodsImageUrl =  _model.main_image;
        

        UIImage * noimage = [UIImage imageNamed:@"noimage"];
        [_cellImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    }
    
    
    //产品标题
    if (!_cellTitle) {
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200*Proportion, 40)];
        _cellTitle.textColor = [UIColor blackColor];
        _cellTitle.font = [UIFont systemFontOfSize:16.0];
        _cellTitle.textAlignment = NSTextAlignmentLeft;
        _cellTitle.numberOfLines = 2;
        // celltitle.lineBreakMode = NSLineBreakByCharWrapping;
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.text = _model.short_title;
    }
    
    if (!_reportHeader) {
        _reportHeader = [[UIView alloc]init];
        _reportHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        [_reportHeader addSubview:_cellImage];
        [_reportHeader addSubview:_cellTitle];
        _reportHeader.backgroundColor = [UIColor whiteColor];
    }
    
    
    
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        TableView.tableHeaderView = _reportHeader;
        [self.view addSubview:TableView];
        [self addRefresh];
    }
}

#pragma mark TableView Datasorce;

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0)
    {
        
    
        
        ReportDetailModel * reportModel = _eventListArray[indexPath.row];
      
        ReportDetailTableViewCell *cell =(ReportDetailTableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        UILabel *lable = (UILabel *)[cell viewWithTag:1000+indexPath.row];
        float labelHeight = CGRectGetHeight(lable.frame)+30;
        float finalHeight = [ReportDetailTableViewCell rowHeightForObject:reportModel] + labelHeight;
        
        
        
        return finalHeight+20;
        
     
       
    }else
    return 44;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        return 0;
    }else
    return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
        _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        _sectionTitle.backgroundColor = [UIColor clearColor];
        _sectionTitle.textColor = [UIColor grayColor];
        _sectionTitle.textAlignment = NSTextAlignmentLeft;
        _sectionTitle.font = [UIFont systemFontOfSize:14.0f];
        _sectionTitle.text = [NSString stringWithFormat:@"     质检过的电商"];
    
    if ([_SiteListArray count]==0) {
        _sectionTitle.text = @"";
    }else
    {
        _sectionTitle.text = [NSString stringWithFormat:@"     质检过的电商"];
    }
    
    
      return _sectionTitle;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if(section==0)
    {
        return [_eventListArray count];
    }else
    return [_SiteListArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型

    if (indexPath.section==1) {
        StoreModel * Model = _SiteListArray[indexPath.row];
        static NSString * cellID = @"storeTableViewCell";
        StoreTableViewCell * cell = [TableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell)
        {
            cell = [[StoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }else{
            
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.StoreModel = Model;

        return cell;
    }else if (indexPath.section==0) {
        
        ReportDetailModel * reportModel = _eventListArray[indexPath.row];
        
        static NSString * celliD = @" ReportDetailTableViewCell";
        ReportDetailTableViewCell * reportDetailCell = [TableView dequeueReusableCellWithIdentifier:celliD];
        if (!reportDetailCell) {
            reportDetailCell = [[ReportDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celliD];
            reportDetailCell.reportDetailModel = reportModel;
            reportDetailCell.selected = NO;
            reportDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            reportDetailCell.contentLabel.tag = 1000+indexPath.row;
        }
        return reportDetailCell;
        
    }else
        return nil;


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
