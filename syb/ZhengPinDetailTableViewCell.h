//
//  ZhengPinDetailTableViewCell.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhengPinDetailModel.h"
#import "StoreModel.h"
#import "StoreTableViewCell.h"
@protocol ZhengPinDetailTableViewCellDelegate <NSObject>

@optional

-(void)playWithUrl:(NSURL*)url;

@end

@interface ZhengPinDetailTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate
>

@property (nonatomic,weak)id <ZhengPinDetailTableViewCellDelegate>delegate;
@property (nonatomic,strong)ZhengPinDetailModel * zhengpinDetailModel;

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * dateLabel;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UIImageView * cellImage;
@property (nonatomic,strong)UITableView * storeTableView;
@property (nonatomic,strong)UICollectionView * CollectionView;
@property (nonatomic,strong)UILabel * sectionTitle;
@property (nonatomic,strong)UILabel * timeLine;

@property (nonatomic,strong)NSMutableArray *ImageArr;
@property (nonatomic,strong)NSMutableArray * videoArr;

@property (nonatomic,strong)NSMutableArray * StoreListArr;
@property (nonatomic,strong)NSMutableArray * storeModelArr;

+ (CGFloat)rowHeightForObject:(id)object;
@end
