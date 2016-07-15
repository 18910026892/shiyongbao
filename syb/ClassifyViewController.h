//
//  ClassifyViewController.h
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassifyTableViewCell.h"
#import "ClassifyTableModel.h"
#import "ClassifyCollectionCell.h"
#import "ClassifyCollectionModel.h"
#import "ClassifyCollectionHeader.h"
@interface ClassifyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIImageView * ClassifyImage;
    UILabel * ClassifyTitle;
    NSString * categeryID;
}

@property (nonatomic,strong)UITableView * TableView;
@property (nonatomic,strong)UICollectionView * CollectionView;

@property (nonatomic,strong)NSMutableArray * tableArray;

@property (nonatomic,strong)NSMutableArray * tableModelArray;

@property (nonatomic,strong)NSMutableArray * tableListArray;

@property (nonatomic,strong)NSMutableArray * collectionSectionArray;

@property (nonatomic,strong)NSMutableArray * collectionArray;

@property (nonatomic,strong)NSMutableArray * collectionModelArray;

@property (nonatomic,strong)NSMutableArray * collectionListArray;

@property (nonatomic,copy)NSString * cat_id;

@end
