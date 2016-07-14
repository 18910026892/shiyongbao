//
//  ClassifyViewController.h
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyTableViewCell.h"
#import "ClassifyTableModel.h"
#import "ClassifyCollectionCell.h"
#import "ClassifyCollectionModel.h"
#import "ClassifyCollectionHeader.h"
@interface ClassifyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UITableView * TableView;
    UICollectionView * CollectionView;
    
    UIImageView * ClassifyImage;
    UILabel * ClassifyTitle;
    NSString * categeryID;
    
    SingleManage * SM;
}

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;
//表格视图数据模型数组
@property (nonatomic,strong)NSArray * TableModelArray;
//表格视图数组
@property (nonatomic,strong)NSMutableArray * TableList;
//集合视图模型数组
@property (nonatomic,strong)NSArray * CollectionModelArray;
//集合视图数组
@property (nonatomic,strong)NSMutableArray * CollectionList;

//商品分类参数1
@property (nonatomic,copy)NSString * cat_id1;

//商品分类参数2
@property (nonatomic,copy)NSString * cat_id2;

//商品分类参数3
@property (nonatomic,copy)NSString * cat_id3;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;
@end
