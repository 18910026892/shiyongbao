//
//  ReportViewController.h
//  syb
//
//  Created by GongXin on 16/4/5.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportCell.h"
#import "ReportModel.h"
@interface ReportViewController : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIButton * backButton;
    UICollectionView * CollectionView;
}
@property (nonatomic,strong)NSMutableArray * reportArray;
@property (nonatomic,strong)NSMutableArray * reportModelArray;
@property (nonatomic,strong)NSMutableArray * reportListArray;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;
//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

@end
