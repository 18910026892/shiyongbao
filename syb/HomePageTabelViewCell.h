//
//  HomePageTabelViewCell.h
//  syb
//
//  Created by GX on 15/11/4.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageFloorDTO.h"
#import "HomePageCollectionViewCell.h"
#import "HomePageCollectionDto.h"
@class HomePageTabelViewCell;

@protocol HomePageTableViewCellDelegate <NSObject>

@optional

-(void)babyButtonClick:(HomePageTabelViewCell*)cell;
-(void)beautyButtonClick:(HomePageTabelViewCell*)cell;
-(void)attentionButtonClick:(UIButton*)sender ;
-(void)collectioncellClick:(NSString*)url WithTitle:(NSString*)title;

@end

@interface HomePageTabelViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
//数据模型
@property (nonatomic,strong)HomePageFloorDTO * homePageModel;

@property (weak, nonatomic) id <HomePageTableViewCellDelegate> delegate;


//floor1
//寻真之旅

@property (nonatomic,strong) UIImageView * xunzhenImageView;
@property (nonatomic,strong) UICollectionView * CollectionView;



//floor2
//尚品汇
@property (nonatomic,strong)UIImageView * ShangPinHuiImageView;
//母婴按钮
@property (nonatomic,strong)UIButton * babyButton;
//美妆按钮
@property (nonatomic,strong)UIButton * beautyButton;
//水平线
@property (nonatomic,strong)UILabel * horizontalLabel;
//竖直线条
@property (nonatomic,strong)UILabel * verticalLabel;


//floor3
//网店汇
@property (nonatomic,strong)UIImageView * WangDianHuiImageView;
//更多按钮
@property (nonatomic,strong)UIImageView * moreImageView;


//floor 4
//Cell 的背景视图
@property (nonatomic,strong)UIView * cellBackView;
//平台来源
@property (nonatomic,strong)UIImageView * platform;
//店铺名称
@property (nonatomic,strong)UILabel * shopName;
//质检通过标识
@property (nonatomic,strong)UIImageView * passImage;
//关注按钮
@property (nonatomic,strong)UIButton * AttentionButton;
//关注的人数量
@property (nonatomic,strong)UILabel * AttentionCount;
//店铺的商品图片1
@property (nonatomic,strong)UIImageView * goodsImage;

//线条
@property (nonatomic,strong)UILabel * cellLine;

@property(nonatomic,strong)NSMutableArray * collectionArray;


/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(HomePageFloorDTO *)HomePageModel;

@end
