//
//  ZhengPinDetailViewController.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPinDetailViewController.h"
#import "Helper.h"
@interface ZhengPinDetailViewController ()

@end

@implementation ZhengPinDetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        _titleArray = @[@"报告",@"检验",@"收货",@"采购"];
        _imageArray = @[@"zhibo1",@"zhibo2",@"zhibo3",@"zhibo4"];
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
    [MobClick beginLogPageView:@"正品直播详情"];
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
    [MobClick endLogPageView:@"正品直播详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self OtherSetup];
    [self addParameter];
    [self PageLayout];
    [self InitgoToTopButton];
}
//页面设置
-(void)PageSetup
{
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"正品直播";
    
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
    NSString * qaId = _ZhengPinModel.qa_id;
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:qaId,@"qaId", nil];
    
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getQtGoodsZBDetail pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        
        
        NSArray * resultArray = [obj valueForKey:@"result"];
    

        
        
         if(resultArray)
         {
             _zhiboHeaderDict = [resultArray[0] valueForKey:@"head"];
             
    
             _contentDict = [resultArray[1] valueForKey:@"content"];

             _CheckStoreArray = [resultArray[2] valueForKey:@"checkStore"];
         }
        
        
     
        
        if (IS_DICTIONARY_CLASS(_contentDict)) {
            
            NSArray * reportItemArray = [_contentDict valueForKey:@"report"];
            
            NSArray * inspectItemArray = [_contentDict valueForKey:@"inspect"];
            
            NSArray * takeItemArray = [_contentDict valueForKey:@"take"];
            
            NSArray * purchaseItemArray = [_contentDict valueForKey:@"purchase"];
 
            //质检通过的电商的空数组
            NSArray * storeArray = @[];
 
            //整合完毕后的数组赋值
            
            _reportFinalArray = [NSMutableArray array];
            _takeFinalArray = [NSMutableArray array];
            _inspectFinalArray = [NSMutableArray array];
            _purchaseFinalArray = [NSMutableArray array];
            

            
            //报告
            for (NSDictionary * dict in reportItemArray) {
                
                NSString * event_time = [dict valueForKey:@"event_time"];
                NSString * event_title = [dict valueForKey:@"event_title"];
                NSArray * itemArray = [dict valueForKey:@"item"];
                
                if (IS_ARRAY_CLASS(itemArray)) {
                    for (NSDictionary * dict1 in itemArray) {
                        NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithDictionary:dict1];

                       
                        
                        [dict2 setObject:@"" forKey:@"event_time"];
                        [dict2 setObject:@"" forKey:@"event_title"];
                        [dict2 setObject:storeArray forKey:@"store_List"];
                        [_reportFinalArray addObject:dict2];
    
                        
                        
                        
                        NSDictionary * firstDict = [_reportFinalArray firstObject];
                        NSMutableDictionary * newfirstDict = [NSMutableDictionary dictionaryWithDictionary:firstDict];
                        [newfirstDict setObject:event_time forKey:@"event_time"];
                        [newfirstDict setObject:event_title forKey:@"event_title"];
                        NSInteger i = 0;
                        [_reportFinalArray replaceObjectAtIndex:i withObject:newfirstDict];
       
                    }
                    
                    
                    
                }
                
                
            
                
            }
            

            
            
            //检验
            for (NSDictionary * dict in inspectItemArray) {
                
                NSString * event_time = [dict valueForKey:@"event_time"];
                NSString * event_title = [dict valueForKey:@"event_title"];
                NSArray * itemArray = [dict valueForKey:@"item"];
                
                if (IS_ARRAY_CLASS(itemArray)) {
                    for (NSDictionary * dict1 in itemArray) {
                        NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithDictionary:dict1];
                        [dict2 setObject:event_time forKey:@"event_time"];
                        [dict2 setObject:event_title forKey:@"event_title"];
                        [dict2 setObject:storeArray forKey:@"store_List"];
                        [_inspectFinalArray addObject:dict2];
                        
                        
                        
//                        NSDictionary * firstDict = [_inspectFinalArray firstObject];
//                        NSMutableDictionary * newfirstDict = [NSMutableDictionary dictionaryWithDictionary:firstDict];
//                        [newfirstDict setObject:event_time forKey:@"event_time"];
//                        [newfirstDict setObject:event_title forKey:@"event_title"];
//                        NSInteger i = 0;
//                        [_inspectFinalArray replaceObjectAtIndex:i withObject:newfirstDict];
                        
                        
                    }
                }
                
            }
            
        
           //收货
            for (NSDictionary * dict in takeItemArray) {
                
                NSString * event_time = [dict valueForKey:@"event_time"];
                NSString * event_title = [dict valueForKey:@"event_title"];
                NSArray * itemArray = [dict valueForKey:@"item"];
                
                if (IS_ARRAY_CLASS(itemArray)) {
                    for (NSDictionary * dict1 in itemArray) {
                        NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithDictionary:dict1];
                        [dict2 setObject:event_time forKey:@"event_time"];
                        [dict2 setObject:event_title forKey:@"event_title"];
                        [dict2 setObject:storeArray forKey:@"store_List"];
                        [_takeFinalArray addObject:dict2];
                        
                        
                        
//                        NSDictionary * firstDict = [_takeFinalArray firstObject];
//                        NSMutableDictionary * newfirstDict = [NSMutableDictionary dictionaryWithDictionary:firstDict];
//                        [newfirstDict setObject:event_time forKey:@"event_time"];
//                        [newfirstDict setObject:event_title forKey:@"event_title"];
//                        NSInteger i = 0;
//                        [_takeFinalArray replaceObjectAtIndex:i withObject:newfirstDict];
//                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
            }
            
            //采购
            for (NSDictionary * dict in purchaseItemArray) {
                
                NSString * event_time = [dict valueForKey:@"event_time"];
                NSString * event_title = [dict valueForKey:@"event_title"];
                NSArray * itemArray = [dict valueForKey:@"item"];
                
                if (IS_ARRAY_CLASS(itemArray)) {
                    for (NSDictionary * dict1 in itemArray) {
                        NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithDictionary:dict1];
                        [dict2 setObject:event_time forKey:@"event_time"];
                        [dict2 setObject:event_title forKey:@"event_title"];
                        [dict2 setObject:storeArray forKey:@"store_List"];
                        [_purchaseFinalArray addObject:dict2];
                        
                        
//                        NSDictionary * firstDict = [_purchaseFinalArray firstObject];
//                        NSMutableDictionary * newfirstDict = [NSMutableDictionary dictionaryWithDictionary:firstDict];
//                        [newfirstDict setObject:event_time forKey:@"event_time"];
//                        [newfirstDict setObject:event_title forKey:@"event_title"];
//                        NSInteger i = 0;
//                        [_purchaseFinalArray replaceObjectAtIndex:i withObject:newfirstDict];
                        
                    }
                }
                
            }
         

        }
        
        if (_reportFinalArray&&[_reportFinalArray count]>0) {
            
            NSDictionary * lastDict = [_reportFinalArray lastObject];
            NSMutableDictionary * newLastDict = [NSMutableDictionary dictionaryWithDictionary:lastDict];
            [newLastDict setObject:_CheckStoreArray forKey:@"store_List"];
            NSInteger i = [_reportFinalArray count]-1;
            [_reportFinalArray replaceObjectAtIndex:i withObject:newLastDict];
            
           
        }


        
        _reportListArray = [ZhengPinDetailModel mj_objectArrayWithKeyValuesArray:_reportFinalArray];
        
        _inspectListArray = [ZhengPinDetailModel mj_objectArrayWithKeyValuesArray:_inspectFinalArray];
        
        _takeListArray = [ZhengPinDetailModel mj_objectArrayWithKeyValuesArray:_takeFinalArray];
        
        _purchaseListArray = [ZhengPinDetailModel mj_objectArrayWithKeyValuesArray:_purchaseFinalArray];

        
        [TableView.header endRefreshing];
        [TableView reloadData];
       
        TableView.tableHeaderView = self.zhengpinDetailHeader;
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
-(ZhengPinDetailHeader*)zhengpinDetailHeader
{
    if (!_zhengpinDetailHeader) {
        _zhengpinDetailHeader = [[ZhengPinDetailHeader alloc]init];
        _zhengpinDetailHeader.zhiboHeader = self.zhiboHeaderDict;
        _zhengpinDetailHeader.delegate = self;
        _zhengpinDetailHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
        _zhengpinDetailHeader.backgroundColor = [UIColor whiteColor];
     
        
    }
    return _zhengpinDetailHeader;
}

//页面布局
-(void)PageLayout
{


    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  [UIColor clearColor];
        TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:TableView];
        [self addRefresh];
    }
}

-(void)stateButtonClick:(UIButton*)sender;
{

    UIButton * btn = (UIButton*)sender;
    
    NSInteger i = 3-btn.tag;
    
    NSInteger j1 = [_reportListArray count];
    NSInteger j2 = [_inspectListArray count];
    NSInteger j3 = [_takeListArray count];
    NSInteger j4 = [_purchaseListArray count];
    
    switch (i) {
        case 0:
        {
            if (j1==0) {
                NSLog(@"这里不能滑动");
            }else
            {
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:i];
                [TableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
        }
            break;
            case 1:
        {
            if (j2==0) {
                NSLog(@"这里不能滑动");
            }else
            {
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:i];
                [TableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
            break;
            case 2:
        {
            if (j3==0) {
                NSLog(@"这里不能滑动");
            }else
            {
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:i];
                [TableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
            break;
            case 3:
        {
            if (j4==0) {
                NSLog(@"这里不能滑动");
            }else
            {
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:i];
                [TableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
            break;
        default:
            break;
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
    ZhengPinDetailModel * model;
    
    if (indexPath.section==0) {
        
        if (IS_ARRAY_CLASS(_reportListArray)) {
           
            NSInteger i = indexPath.row;
            
            NSLog(@"输出一下这个页面的 个数是 %d",i);
            
            model = _reportListArray[indexPath.row];
            
            
        }
      
        
    }else if(indexPath.section==1)
    {
        if (IS_ARRAY_CLASS(_inspectListArray)) {
            model = _inspectListArray[indexPath.row];
        }
        
        
    }else if(indexPath.section==2)
    {
        if (IS_ARRAY_CLASS(_takeListArray)) {
            model = _takeListArray[indexPath.row];
        }
        
    }else if(indexPath.section==3)
    {
        if (IS_ARRAY_CLASS(_purchaseListArray)) {
            model = _purchaseListArray[indexPath.row];
        }
        
    }


    //文本内容的高度
    float labelHeight;
    

        if ([model.content_text isEqualToString:@""]||!model.content_text||[model.content_text length]==0||[model.content_text isEmpty]) {
            labelHeight = 0;
        }else
        {
        
            if (IOS_9) {
                NSInteger tag = indexPath.section*10000+indexPath.row;
                UITableViewCell * cell = (UITableViewCell *)[tableView viewWithTag:tag];
                
                UILabel * lable = (UILabel*)[cell viewWithTag:88888];
                 labelHeight = CGRectGetHeight(lable.frame)+10;
            }else
                
            {
              
                
                NSString * htmlString = [self htmlEntityDecode:model.content_text];
                
                NSString * html  = [self filterHTML:htmlString];
                
 
                labelHeight = [Helper heightForLabelWithString:html withFontSize:14.0 withWidth:SCREEN_WIDTH-20 withHeight:1000]+25;
            }
        }

    //文本标题的高度
    float TitleHeight;
    
    NSString * event_title = model.event_title;
    NSString * event_time  = model.event_time;
    
    if ([event_time isEqualToString:@""]&&[event_title isEqualToString:@""] ) {
        TitleHeight = 0;
    }else if(!event_time&!event_title)
    {
        TitleHeight = 0;
    }else
    {
        TitleHeight = 30;
    }
    
    NSInteger imgNum =  [model.image_list count];
    NSInteger vedioNum = [model.video_list count];
    
    
    
    
    int i ;
    if (imgNum==0) {
        i=0;
    }else if (imgNum>0&&imgNum <4)
    {
        i=1;
    }else if (imgNum>3)
    {
        i=2;
    }
    
    int j ;
    if (vedioNum==0) {
        j=0;
    }else if (vedioNum>0&&vedioNum<4)
    {
        j=1;
    }
    
    int z = i+j;
    
    //集合视图的高度
    float collectionHeight;
    
        if (z==0) {
            
          
            collectionHeight = 0;
        }else
        {
        
            collectionHeight =90*Proportion *z+20*(z-1)+10;
        }
  
    
    
    //店铺列表高度
    NSInteger count  = [model.store_List count];
    float storeListHeight;
    if(count==0)
    {
        storeListHeight = 0;
    }else
    {
       storeListHeight = count * 44+30;
    }
    

    float finalHeight = labelHeight +  TitleHeight+ collectionHeight+ storeListHeight;

  
    return finalHeight;

  

    
    
}
//转码
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return string;
}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
 
    return html;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
   
    return 30;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
    _sectionImage = [[UIImageView alloc]init];
    _sectionImage.frame = CGRectMake(5, 5, 20, 20);
    [_sectionImage setImage:[UIImage imageNamed:_imageArray[section]]];

    _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
    _sectionTitle.backgroundColor = [UIColor clearColor];
    _sectionTitle.textColor = [UIColor grayColor];
    _sectionTitle.textAlignment = NSTextAlignmentLeft;
    _sectionTitle.font = [UIFont systemFontOfSize:14.0f];
    _sectionTitle.text = [NSString stringWithFormat:@" %@",_titleArray[section]];

 
    _sectionHeader = [[UIView alloc]init];
    _sectionHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    _sectionHeader.backgroundColor = [UIColor whiteColor];
    [_sectionHeader addSubview:_sectionImage];
    [_sectionHeader addSubview:_sectionTitle];
   
    
    return _sectionHeader;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   
    if (section==0) {
        return [_reportListArray count];
    }else if(section==1)
    {
        return [_inspectListArray count];
    }else if(section==2)
    {
        return [_takeListArray count];
    }else if(section==3)
    {
        return [_purchaseFinalArray count];
    }else
        return 0;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型

    ZhengPinDetailModel * model;
    
    if (indexPath.section==0) {
        
        if (IS_ARRAY_CLASS(_reportListArray)) {
            model = _reportListArray[indexPath.row];
        }
        
        
    }else if(indexPath.section==1)
    {
        if (IS_ARRAY_CLASS(_inspectListArray)) {
            model = _inspectListArray[indexPath.row];
        }
        
        
    }else if(indexPath.section==2)
    {
        if (IS_ARRAY_CLASS(_takeListArray)) {
            model = _takeListArray[indexPath.row];
        }
        
    }else if(indexPath.section==3)
    {
        if (IS_ARRAY_CLASS(_purchaseListArray)) {
            model = _purchaseListArray[indexPath.row];
        }
        
    }
    
     static NSString * cellID = @"cellID";
   
    ZhengPinDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[ZhengPinDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.delegate = self;

        NSInteger tag = indexPath.section*10000+indexPath.row;
         cell.tag = tag;

        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.zhengpinDetailModel = model;

    
    return cell;
}

#pragma cellDelegate

-(void)playWithUrl:(NSURL*)url;
{


    MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    //弹出播放器
    [self presentMoviePlayerViewControllerAnimated:movieVc];
}

//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0,64,SCREEN_WIDTH, SCREEN_HEIGHT-64);
        TableView.frame = frame;
        
    }completion:^(BOOL finished){
    }];
    
    [TableView setContentOffset:CGPointZero animated:YES];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //下面tableview移到大概4个cell时显示向上按钮
    if ( scrollView.contentOffset.y > 600) {
        GoTopButton.alpha = .8;
    } else {
        GoTopButton.alpha = 0;
    }
    
}

- (void)InitgoToTopButton
{
    if(!GoTopButton)
    {
        GoTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        GoTopButton.backgroundColor = [UIColor clearColor];
        GoTopButton.frame = CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-107, 50, 50);
        GoTopButton.alpha = 1;
       [GoTopButton setImage:[UIImage imageNamed:@"gotop"] forState:UIControlStateNormal];
        [GoTopButton addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
      
        
        NSLog(@"GoTopButton");
      
        
    }
      [self.view addSubview:GoTopButton];
    
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
