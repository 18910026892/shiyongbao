//
//  BaseViewController.h
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDHud.h"
#import "BKNodataView.h"
#import "BKNoNetView.h"
#import <AFNetworking.h>
@class BaseTabBarController;
@interface BaseViewController : UIViewController<NoDataViewDelegate,NoNetWorkViewDelegate>
{
  
    /**无数据视图**/
    BKNodataView*         _noDataView;
    /**无网视图**/
    BKNoNetView*      _noNetWorkView;
}

@property(nonatomic,strong)UIImageView* Customview;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIButton* LeftBtn;
@property(nonatomic,strong)UIButton* RightBtn ;
@property(nonatomic,strong)UIImageView* backImageView;

@property(nonatomic,strong)BaseTabBarController* tabBar;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)BOOL isPopToRoot;



//设置title
-(void)setNavTitle:(NSString *)title;
//返回按钮 默认显示
-(void)showBackButton:(BOOL)show;
/**
 *@brief 使用alloc创建的控制器
 */
+ (instancetype)viewController;
/**
 * @brief 设置导航栏是否隐藏 默认显示
 */
- (void)setNavigationBarHide:(BOOL)isHide;

/**
 * @brief 设置Tabbar 是否隐藏 默认显示
 
 */
-(void)setTabBarHide:(BOOL)isHide;


/**
 * @brief 设置背景图片
 */
-(void)setBackImageViewWithName:(NSString *)imgName;

/**
 *  @brief 初始化View
 */
-(void)setupViews;
/**
 *  @brief 初始化Data
 */
-(void)setupDatas;


#pragma mark - 无数据的显示方法
/**
 *  显示无数据视图
 *
 *  @param frame 内容显示的frame
 */
- (void)showNoDataViewWithFrame:(CGRect)frame;
/**
 *  显示无数据视图在某个视图上
 *
 *  @param superView 无数据视图的父视图
 */
- (void)showNoDataViewInView:(UIView *)superView;
- (void)showNoDataViewInView:(UIView *)superView noDataString:(NSString *)noDataString;
- (void)showSmileNoDataViewInView:(UIView *)superView noDataString:(NSString *)noDataString;
- (void)showNoDataView;
- (void)hideNoDataView;

/**
 *  无数据展示
 *  @param isShow
 */
- (void)showLoadFailView:(BOOL)isShow noDataType:(NODataType)nodataType;

@property NSInteger nodataViewTpye;

#pragma mark - 无网络的显示方法
-(void)showNoNetWorkView:(NoNetWorkViewStyle)style;
- (void)showNoNetWorkViewWithFrame:(CGRect)frame;
-(void)showNoNetWorkView;
-(void)hideNoNetWorkView;
-(void)retryToGetData;
/**
 *  在某个视图上显示无网，此时无网络视图在此视图的中心，大小与此视图一样大小
 *
 *  @param view 显示无网络视图的父视图
 */
-(void)showNoNetWorkViewInView:(UIView *)view;


@end
