//
//  JianZhengViewController.h
//  syb
//
//  Created by GongXin on 16/2/24.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNSegmentedControl.h>
#import "JianZhengCollectionCollectionCell.h"
#import "TouPiaoModel.h"
@interface JianZhengViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,DZNSegmentedControlDelegate>

@property (nonatomic,strong)UIButton * backButton;

@property (nonatomic,strong)UIButton * xizeButton;;

@property (nonatomic,strong)UILabel * HeaderLabel;

//水平线
@property (nonatomic,strong)UILabel * horizontalLabel;
//竖直线条
@property (nonatomic,strong)UILabel * verticalLabel;

@property (nonatomic,strong)DZNSegmentedControl * control;

@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic,strong)NSMutableArray * catIdArray;

@property (nonatomic,strong)UICollectionView * CollectionView;

@property (nonatomic,strong)NSMutableArray * array1;
@property (nonatomic,strong)NSMutableArray * array2;
@property (nonatomic,strong)NSMutableArray * collectionArray;
@property (nonatomic,strong)NSMutableArray * collectionModelArray;
@property (nonatomic,strong)NSMutableArray * collectionListArray;


@property (nonatomic,strong)NSString * detailUrl;

@property (nonatomic,copy)NSString * catid;
@property NSInteger selectIndex;


@property (nonatomic,strong)UIButton * closeButton;

@property BOOL isShow;

@end
