//
//  ReportDetailTableViewCell.h
//  syb
//
//  Created by GongXin on 16/4/12.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhengpinDetailCollectionViewCell.h"
#import "ReportDetailModel.h"
@interface ReportDetailTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate>


@property (nonatomic,strong)ReportDetailModel * reportDetailModel;

@property (nonatomic,strong)UILabel * contentLabel;

@property (nonatomic,strong)UICollectionView * CollectionView;

@property (nonatomic,strong)NSMutableArray *ImageArr;

@property (nonatomic,strong)NSMutableArray * StoreListArr;
@property (nonatomic,strong)NSMutableArray * storeModelArr;

@property(nonatomic,strong)UIWebView * webView;



+ (CGFloat)rowHeightForObject:(id)object;


@end
