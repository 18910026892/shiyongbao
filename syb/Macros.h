//
//  Macros.h
//  syb
//
//  Created by GX on 15/9/17.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#ifndef syb_Macros_h
#define syb_Macros_h
#pragma mark - 系统库
#import <Availability.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreData/CoreData.h>
#pragma mark -
#pragma mark 工具类
#import "GXHttpRequest.h"
#import "UserDefaultsUtils.h"
#import "HDHud.h"
#import "NSString+Validation.h"
#import "NSString+MD5.h"
#import "GTMBase64.h"
#import "GTMDefines.h"
#import "RemindFrameHandler.h"
#import "OpenUDID.h"
#import "UIColor+Foundation.h"
#import "NSDate+Tools.h"
#import "NSArray+Other.h"
#import "UIWebView+SybWebView.h"
#import "TimeTool.h"
#pragma mark -
#pragma mark Model类
#import "SingleManage.h"
#import "Config.h"
#pragma mark -
#pragma mark Lib类
#import <ZBarSDK.h>
#import <iflyMSC/iflyMSC.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MobClick.h>

#pragma mark -
#pragma mark 打印日志
//DEBUG  模式下打印日志,当前行
//#define GTDEBUG 0
#define GTDEBUG 1
#if GTDEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
#pragma mark -
#pragma mark 各种判断宏
//各种各样的判断
//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
#define ISNIL(variable) (variable==nil)
//是不是NULL类型
#define IS_NULL_CLASS(variable)    ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNull class]])
//字典数据是否有效
#define IS_DICTIONARY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSDictionary class]])&&([((NSDictionary *)variable) count]>0))
//数组数据是否有效
#define IS_ARRAY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSArray class]])&&([((NSArray *)variable) count]>0))
//数字类型是否有效
#define IS_NUMBER_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNumber class]]))
//字符串是否有效
#define IS_EXIST_STR(str) ((nil != (str)) &&([(str) isKindOfClass:[NSString class]]) && (((NSString *)(str)).length > 0))
#pragma mark -
#pragma mark 设备系统版本、尺寸、字体、颜色 相关配置

//判断机型
#define iPhone4S (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size))
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断程序的版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)
#define IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
//控件的尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)
//适配ip6 ip6+ 利器宏命令
#define Proportion ([UIScreen mainScreen].bounds.size.width/320)

#define GXRandomFont [UIFont systemFontOfSize:((arc4random() % 4) + 12)*([UIScreen mainScreen].bounds.size.width/320)]
//APP STORE 下载地址
#define AppStoreUrl @"https://itunes.apple.com/cn/app/shi-yong-bao/id988776061?mt=8"

//接口
#define MAINURL @"http://app.spygmall.com/index.php?"
#define OnLineURL @"http://api.app.spygmall.com/index.php/home/client/"
//#define OnLineURL @"http://api.app.spygmall.com/index.php/home/client/testRest"

//3.0.0 新的API
//用户注册接口 
#define URL_Register  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"Registered"]]
//用户登录接口
#define URL_Login  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SignIn"]]
//是否需要显示验证码验证
#define URL_Config [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SysConfig"]]
//验证码发送
#define URL_sendCode  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetVerificationCode"]]
//修改密码
#define URL_ChangePassWord  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ChangePassword"]]
//忘记密码 post
#define URL_ForgetPassWord  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ForgetPassword"]]

//修改个人信息
#define URL_ChangeUserInfo  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"PersonalData"]]

//我的消息
#define URL_myMessage  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"MyMessage"]]
//删除消息
#define URL_mymessagedel  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"DeleteMessage"]]

//意见反馈
#define URL_FeedBack [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"FeedBack"]]

//首页广告
#define URL_HomePageAD [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"IndexAd"]]

//首页
#define URL_HomePage [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"HomePage"]]

//URL地址
#define URL_SysHtmlInfo  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SysHtmlInfo"]]

//商品分类
#define URL_GoodsCategoryList  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GoodsCategoryList"]]

//商品列表
#define URL_ShopGoodsList  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ShopGoodsList"]]

//商品筛选条件
#define URL_GoodsFilterList  [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"InitGoodsFilterList"]]

//店铺分类
#define URL_ShopCatList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ShopCatList"]]

//店铺列表
#define URL_ShopList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ShopList"]]


//关注店铺
#define URL_DoAttentShop [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"DoAttentShop"]]

//取消关注
#define URL_UndoAttentShop [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"UndoAttentShop"]]
//关注的店铺列表
#define URL_AttentedShop [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"AttentedShop"]]
//商城分类
#define URL_MallCateList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"MallCateList"]]
//商城列表
#define URL_MallList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"MallList"]]
//淘宝搜索
#define URL_RebateTbSearch [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"RebateTbSearch"]]
//另类店铺商品列表
#define URL_ShopGoodsListByShop [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"ShopGoodsListByShop"]]
//商品搜索
#define URL_SearchShopGoodsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchShopGoodsList"]]

//商品搜索
#define URL_SearchShopList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchShopList"]]
//识用说搜索
#define URL_SearchProductList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchProductList"]]

//统计
#define URL_accessedUrlStat [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"AccessedUrlStat"]]

//返利规则接口
#define URL_Rebate_Site [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"MallRegularListInfo"]]

//新消息
#define URL_MyNewestMessage [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"MyNewestMessage"]]

//天猫订单规则
#define URL_getCommitUrlRegular [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"TmallOrderCommitUrlRegular"]]

//天猫订单ID截取
#define URL_insert_tmall_order [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"TmallOrderCommit"]]




//305 API
#define URL_GetCatsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetCatsList"]]
#define URL_GetQtGoodsToHome [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetQtGoodsToHome"]]

#define URL_GetGoodsCats [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetGoodsCats"]]

#define URL_GetVoteGoodsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetVoteGoodsList"]]

#define URL_VoteGoodsDetil [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"VoteGoodsDetil"]]

#define URL_GetSharePlatform [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetSharePlatform"]]

#define URL_GetZjHtml [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetZjHtml"]]

#define URL_GetQtGoodsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetQtGoodsList"]]

#define URL_QtGoodsDetil [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"QtGoodsDetil"]]

#define URL_SearchProductById [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchProductById"]]

#define URL_DoVoteGoods [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"DoVoteGoods"]]

//3.12版本

//认证商品列表
#define URL_getQtAuthenticationGoods [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getQtAuthenticationGoods"]]
//认证商品详情
#define URL_getQtAuthenticationGoodsDetail [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getQtAuthenticationGoodsDetail"]]


//报告列表
#define URL_getReportList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getReportList"]]

//报告详情
#define URL_getReportDetail [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getReportDetail"]]

//直播列表
#define URL_getQtGoodsZBList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getQtGoodsZBList"]]

//直播详情
#define URL_getQtGoodsZBDetail [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getQtGoodsZBDetail"]]

//广告轮播
#define URL_getAdList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getAdList"]]
//投票列表
#define URL_getVoteGoodsList_V2 [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"getVoteGoodsList_V2"]]

//投票详情
#define URL_VoteGoodsDetail_V2 [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"VoteGoodsDetail_V2"]]

//投票
#define URL_DoVoteGoods_V2 [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"DoVoteGoods_V2"]]



//320APi

//分类列表1级
#define URL_StoreGoodsFirstLevelCats [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"StoreGoodsFirstLevelCats"]]

#define URL_GetStoreGoodsByCatId [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetStoreGoodsByCatId"]]


#endif
