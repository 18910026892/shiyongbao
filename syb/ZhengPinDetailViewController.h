//
//  ZhengPinDetailViewController.h
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenPin312Model.h"
#import "ZhengPinDetailTableViewCell.h"
#import "ZhengPinDetailModel.h"
#import "StoreModel.h"
#import "StoreTableViewCell.h"
#import "ZhengPinDetailHeader.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ZhengPinDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZhengPinDetailTableViewCellDelegate,ZhengPinDetailHeaderDelegate>
{
    UIButton * backButton;
  
    UITableView * TableView;
    
    //Go Top Button
    UIButton * GoTopButton;
}

@property (nonatomic,strong)ZhengPinDetailHeader * zhengpinDetailHeader;
@property (nonatomic,strong)ZhenPin312Model * ZhengPinModel;

@property (nonatomic,strong)NSDictionary * zhiboHeaderDict;
@property (nonatomic,strong)NSDictionary * contentDict;
@property (nonatomic,strong)NSMutableArray * CheckStoreArray;

@property (nonatomic,strong)UIImageView * sectionImage;
@property (nonatomic,strong)UILabel * sectionTitle;
@property (nonatomic,strong)UIView * sectionHeader;

@property (nonatomic,strong)NSMutableArray * SiteArray;

//四个Section 的数组

//报告整合完毕的
@property (nonatomic,strong)NSMutableArray * reportFinalArray;
//检验整合完毕的
@property (nonatomic,strong)NSMutableArray * inspectFinalArray;
//收货整合完毕的
@property (nonatomic,strong)NSMutableArray * takeFinalArray;
//采购整合完毕的
@property (nonatomic,strong)NSMutableArray * purchaseFinalArray;

//报告模型数组
@property (nonatomic,strong)NSMutableArray * reportListArray;
//检验模型数组
@property (nonatomic,strong)NSMutableArray * inspectListArray;
//收货模型数组
@property (nonatomic,strong)NSMutableArray * takeListArray;
//采购模型数组
@property (nonatomic,strong)NSMutableArray * purchaseListArray;

//是否刷新的标志
@property(nonatomic,assign)BOOL update;
//页面参数
@property (nonatomic,copy)NSString * page;

//解析到的对象字典
@property (nonatomic,strong)NSMutableDictionary * objDict;

@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * imageArray;


@end
