//
//  JianZhengViewController.m
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "JianZhengViewController.h"
#import "VoteDetailController.h"
#import "WebViewController.h"
@implementation JianZhengViewController
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
    [self.navigationController.navigationBar addSubview:self.backButton];
    [self.navigationController.navigationBar addSubview:self.xizeButton];
    
    [MobClick beginLogPageView:@"鉴证"];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];
    [self.xizeButton removeFromSuperview];
    [MobClick endLogPageView:@"鉴正"];
    
     
}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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

-(UIButton*)xizeButton
{
    if (!_xizeButton) {
        
        _xizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _xizeButton.frame = CGRectMake(SCREEN_WIDTH-50, 0, 44, 44);
        [_xizeButton setTitle:@"细则" forState:UIControlStateNormal];
        _xizeButton.enabled = NO;
        [_xizeButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_xizeButton addTarget:self action:@selector(xizeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xizeButton;
}
-(void)xizeButtonClick:(UIButton*)sender
{
    WebViewController * webVC = [[WebViewController alloc]init];
    webVC.requestURL = _detailUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(UILabel*)HeaderLabel
{
    if (!_HeaderLabel) {
        _HeaderLabel = [[UILabel alloc]init];
        _HeaderLabel.frame = CGRectMake(20, 64, SCREEN_WIDTH-40, 79.5);
        _HeaderLabel.text = @"  投票活动每周一期，您可在跨境美妆和母婴类目下各投三票（同一商品只能投一票），我们将于每周一选取每个类目投票最多的前三款商品，进入到“正品检测认证”流程，检测结束后形成《正品检测认证报告》并在【正品检测认证】栏目公示，请您及时关注【鉴·正】动态进展。";
        _HeaderLabel.textColor = [UIColor blackColor];
        _HeaderLabel.numberOfLines = 5;
        _HeaderLabel.font = [UIFont systemFontOfSize:11];
        _HeaderLabel.backgroundColor = [UIColor clearColor];
      
    }
    return _HeaderLabel;
}

-(UIButton*)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(SCREEN_WIDTH-80,64, 80, 40);
        [_closeButton setImage:[UIImage imageNamed:@"closebutton"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(void)closeButtonClick:(UIButton*)sender
{
    [UserDefaultsUtils saveBoolValue:YES withKey:@"closeHeader"];
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [_HeaderLabel removeFromSuperview];
        [_closeButton removeFromSuperview];
        
    } completion:^(BOOL finished) {
       
        self.control.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        self.CollectionView.frame =CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    }];
    
    NSLog(@"close");
    
}
- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = NO;
        _control.height = 40.0f;
        
        if (_isShow) {
            _control.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        }else if(!_isShow)
        {
             _control.frame = CGRectMake(0, 144, SCREEN_WIDTH, 40);
        }
        
       
        _control.showsGroupingSeparators = NO;
        _control.backgroundColor = [UIColor clearColor];
        _control.tintColor = ThemeColor;
        _control.showsCount = NO;
        _control.selectionIndicatorHeight = 1.5;
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
}
-(UILabel*)horizontalLabel
{
    if (!_horizontalLabel) {
        //水平线
        _horizontalLabel = [[UILabel alloc]init];
        _horizontalLabel.frame = CGRectMake(0, 143.5, SCREEN_WIDTH, .5);
        _horizontalLabel.backgroundColor = RGBACOLOR(150,150,150,1);
    }
    return _horizontalLabel;
}

-(UICollectionView*)CollectionView
{
    if (!_CollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        if (_isShow) {
             _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,104,SCREEN_WIDTH,SCREEN_HEIGHT-104) collectionViewLayout:layout];
        }else if(!_isShow)
        {
            _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,184,SCREEN_WIDTH,SCREEN_HEIGHT-184) collectionViewLayout:layout];
        }
       
        _CollectionView.alwaysBounceVertical = YES;
        _CollectionView.backgroundColor = [UIColor whiteColor];
        [_CollectionView registerClass:[JianZhengCollectionCollectionCell class]forCellWithReuseIdentifier:@"JianZhengCollectionCollectionCell"];
        _CollectionView.dataSource = self;
        _CollectionView.delegate = self;
        _CollectionView.scrollEnabled = YES;
    }
    return _CollectionView;

}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{

    _selectIndex = control.selectedSegmentIndex;
    
    _catid = _catIdArray[_selectIndex];
    
    [self GetVoteGoodsList];
    
   
}


#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}


//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title =@"鉴·正";
  
    _isShow = [UserDefaultsUtils boolValueWithKey:@"closeHeader"];
    

    if (!_isShow) {
        
        [self.view addSubview:self.HeaderLabel];
        
        [self.view addSubview:self.closeButton];
    }
    
        
    [self.view addSubview:self.horizontalLabel];
        
  
    [self.view addSubview:self.CollectionView];
    
    _selectIndex = 0;
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadJianZheng:)
                                                 name:@"reloadJianZheng"
                                               object:nil];
    
}

-(void)reloadJianZheng:(NSNotification *)notification
{
    [self requestData];
}
-(void)requestData
{
    [HDHud showHUDInView:self.view title:@"加载中"];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_GetGoodsCats pragma:nil ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失
        NSLog(@"******************%@",obj);
   
        _menuItems  = [NSMutableArray array];
        _catIdArray = [NSMutableArray array];
        NSArray * resultArray = [[obj valueForKey:@"result"] valueForKey:@"array"];
        
        for (NSDictionary * dict in resultArray) {
            NSString * catName = [dict valueForKey:@"name"];
            [_menuItems addObject:catName];
            
            NSString * catId = [dict valueForKey:@"cat_id"];
            [_catIdArray addObject:catId];
        }
        
        [self.view addSubview:self.control];
        
//        for (int i=0; i<[_menuItems count]-1; i++) {
//            
//            _verticalLabel = [[UILabel alloc]init];
//            _verticalLabel.frame = CGRectMake(SCREEN_WIDTH/[_menuItems count]*([_menuItems count]-1), 149, .5, 30);
//            _verticalLabel.backgroundColor = RGBACOLOR(150,150,150,1);
//            
//             [self.view addSubview:self.verticalLabel];
//            
//        }
//        
        _detailUrl =[[obj valueForKey:@"result"] valueForKey:@"detail"];
        _xizeButton.enabled = YES;
        _catid = _catIdArray[0];
        
        [self GetVoteGoodsList];
        
       
    };
    request.failureGetData = ^(void){
        
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
}

-(void)GetVoteGoodsList
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_catid,@"cat_id",nil];

    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_getVoteGoodsList_V2 pragma:postDict ImageData:nil];
    
    request.successGetData = ^(id obj){
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
        _collectionArray = [obj valueForKey:@"result"];
     
      
        NSLog(@"*****%@",_collectionArray);
        
        _collectionArray = [TouPiaoModel mj_objectArrayWithKeyValuesArray:_collectionArray];
        
        _collectionListArray = [NSMutableArray arrayWithArray:_collectionArray];
        
        [_CollectionView reloadData];
       
        
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        
    };
}

#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_collectionListArray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TouPiaoModel * toupiaoModel = _collectionListArray[indexPath.item];
    
    JianZhengCollectionCollectionCell * cell = (JianZhengCollectionCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"JianZhengCollectionCollectionCell" forIndexPath:indexPath];
   
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
     cell.backgroundColor = [UIColor whiteColor];
    
    cell.toupiaoModel = toupiaoModel;
    
    cell.cellTitle.text = toupiaoModel.short_title;
    
  
    NSString * goodsImageUrl = toupiaoModel.main_image;
    
    UIImage * noimage = [UIImage imageNamed:@"noimage"];
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    
    NSInteger rank = indexPath.item + 1;
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)rank];
    if (rank==1||rank==2||rank==3) {
        cell.rankLabel.textColor = [UIColor orangeColor];
    }
    
    NSString * count = [NSString stringWithFormat:@"%@票",toupiaoModel.vote_total];
    cell.countLabel.text = count;
    
    
    
    
    return cell;
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(90*Proportion,90*Proportion+40);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,10,5,10);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.item);
    
    TouPiaoModel * toupiaoModel = _collectionListArray[indexPath.item];
    
    VoteDetailController * vdVC = [[VoteDetailController alloc]init];
    vdVC.toupiaoModel = toupiaoModel;
    [self.navigationController pushViewController:vdVC animated:YES];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
