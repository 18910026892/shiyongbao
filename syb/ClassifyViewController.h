//
//  ClassifyViewController.h
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"

@interface ClassifyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong)UITableView * TableView;
@property (nonatomic,strong)UICollectionView * CollectionView;

@property (nonatomic,strong)NSMutableArray * tableArray;
@property (nonatomic,strong)NSMutableArray * collectionArray;

@end
