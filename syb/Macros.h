//
//  Macros.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark -
#pragma mark Lib类
#import <UMMobClick/MobClick.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "HDHud.h"
#import "BKHelper.h"
#import "TimeTool.h"

#pragma mark -
#pragma mark 基类

#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import "BaseCell.h"

#pragma mark -
#pragma mark 类别
#import "NSString+Additions.h"
#import "UILabel+Additional.h"
#import "UIButton+Addtional.h"
#import "UIView+Additional.h"
#import "NSString+Validation.h"
#pragma mark -
#pragma mark 网络请求
#import "GXHttpRequest.h"



#pragma mark -
#pragma mark 持久化
#import "UserDefaultsUtils.h"

#pragma mark -
#pragma mark 单例
#import "SingleManage.h"
#import "SybSession.h"

#pragma mark -
#pragma mark 打印日志
//DEBUG  模式下打印日志,当前行
#define GTDEBUG 1
#if GTDEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif



//Layout 布局类宏命令
#define kMainScreenHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define kMainScreenWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)

//控件的尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)

//适配 利器宏命令
#define Proportion ([UIScreen mainScreen].bounds.size.width/320)

#define kTabBarHeight                        49.0f
#define kNaviBarHeight                       44.0f
#define kHeightFor4InchScreen                568.0f
#define kHeightFor3p5InchScreen              480.0f
#define kStatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define kRect(x, y, w, h)    CGRectMake(x, y, w, h)
#define kSize(w, h)                          CGSizeMake(w, h)
#define kPoint(x, y)                         CGPointMake(x, y)

#define kSeparatorCellHeight 10.0f // 分割cell的高度



//字体
#define KTitleFont   @"STHeitiSC-Medium"
#define KContentFont @"Helvetica"
#define KHeitiFont   @"Heiti SC"


//颜色
/// 通过RGBA设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC, 0.5);
#define RGBAAllColor(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0  \
green:((float)((rgb & 0xFF00) >> 8))/255.0     \
blue:((float)(rgb & 0xFF))/255.0              \
alpha:(a)/1.0]

/// 通过RGB设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC);
#define RGBAllColor(rgb) RGBAAllColor(rgb, 1.0)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define GXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]



/** 项目默认背景颜色 */
#define kDefaultBackgroundColor     RGBACOLOR(241.f, 241.f, 241.f, 1.f)

//项目主题色
#define ThemeColor [UIColor colorWithRed:240.0/255.0f green:47.0/255.0f blue:111.0/255.0f alpha:1]
/** 标签栏颜色 */
#define kTabBarBackColor     RGBACOLOR(250.f, 250.f, 250.f,1.f)
/** 标签栏文字选中颜色 */
#define kTabBarItemSelectColor     RGBACOLOR(240.f, 47.f,111.f, 1.f)
/**  标签栏文字未选中颜色 */
#define kTabBarItemNomalColor     RGBACOLOR(81.f, 88.f, 101.f, 1.f)
/**  聊天名字颜色 */
#define kNameColor     RGBACOLOR(255, 183.f, 10.f, 1.f)

/** 导航栏背景颜色 */
#define kNavBackGround  RGBACOLOR(248.f, 248.f, 248.f,1.f)
/** 导航栏按钮颜色 */
#define kNavTintColor RGBCOLOR(221.f, 221.f, 221.f)
/** 导航栏Title */
#define kNavTitleColor RGBCOLOR(1.f, 1.f,1.f)

/** 黑色输入框背景*/
#define kTextFieldColor RGBCOLOR(32.f, 33.f, 34.f)

/** 黑色输入框默认文字色*/
#define kTextFieldPlaceHolderColor RGBCOLOR(71.f, 72.f, 73.f)

/** 白色输入框边框 */
#define kTextFieldGrayLayerColor RGBCOLOR(46.f, 46.f, 46.f)

/** 滑动条红色 */
#define kSliderRedColor RGBCOLOR(216.f, 55.f, 73.f)

/** 主要文字颜色 */
#define kMainFontColor RGBCOLOR(238.f, 238.f, 238.f)

/** 辅助文字颜色 */
#define kAiderFontColor RGBCOLOR(161.f, 161.f, 161.f)


/** 高亮文字颜色 */
#define kTipsFontColor RGBCOLOR(187.f, 187.f, 187.f)


/** 分割线 */
#define kSeparatorLineColor RGBCOLOR(230.0f, 230.0f, 230.0f)

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
#define ISNIL(variable) (variable==nil)
//是不是NULL类型
#define IS_NULL_CLASS(variable)    ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNull class]])
//字典数据是否有效
#define IS_DICTIONARY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSDictionary class]])&&([((NSDictionary *)variable) count]>0))
//数组数据是否有效
#define IS_ARRAY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSArray class]]))
//数字类型是否有效
#define IS_NUMBER_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNumber class]]))
//字符串是否有效
#define IS_EXIST_STR(str) ((nil != (str)) &&([(str) isKindOfClass:[NSString class]]) && (((NSString *)(str)).length > 0))

#pragma mark -
#pragma mark 设备系统版本、尺寸、字体、颜色 相关配置
//判断程序的版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)

//格式转化
#define Int2String(para)  [NSString stringWithFormat:@"%i", (int)para]
#define Float12String(float)  [NSString stringWithFormat:@"%.1f", float]
#define Float22String(float)  [NSString stringWithFormat:@"%.2f", float]
#define Long2String(long)  [[NSNumber numberWithLongLong:long] stringValue]
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))



#define TEXT_SPACING_FOR_LINE           4.5f    //文本行间距
//字体
#define FONT_NAME                       [UIFont systemFontOfSize:17.0f].familyName
#define FONT_NAME_FOR_NUMBER            @"HelveticaNeue-Thin"
#define FONT_NAME_FOR_SCORE             @"HelveticaNeue-Thin"
/**********  系统通用宏  **********/

#define LOGIN_NAVIGATIONCONTROLLER ((AppDelegate *)[UIApplication sharedApplication].delegate).loginNavigationController
#define MAIN_NAVIGATIONCONTROLLER ((AppDelegate *)[UIApplication sharedApplication].delegate).mainNavigationController

//设备
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

enum {
    FrameTypeX = 0,                         //x
    FrameTypeY = 1,                         //y
    FrameTypeWidth = 2,                     //width
    FrameTypeHeight = 3                     //height
};
typedef NSUInteger FrameType;

#define Proportion375 (kMainScreenWidth/375)

#define SCREEN_MAX_LENGTH (MAX(kMainScreenWidth, kMainScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(kMainScreenWidth, kMainScreenHeight))
//析构
#define RELEASE_MEMORY(__POINTER)   { if((__POINTER) != nil) { __POINTER = nil;  __POINTER = 0;} }//初始化
#define DEFAULTS [NSUserDefaults standardUserDefaults]
#define HOTSPOT_STATUSBAR_HEIGHT            20
#define APP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define IS_HOTSPOT_CONNECTED                (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)


//HTTP服务器域名
#define OnLineURL @"http://api.app.spygmall.com/index.php/home/client/"
//#define OnLineURL @"http://api.app.spygmall.com/index.php/home/client/testRest"

//#define OnLineURL @"http://192.168.201.5/yg-rest/rest/api"

//*登陆

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

//商品搜索
#define URL_SearchStoreGoodsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchStoreGoodsList"]]

//店铺搜索
#define URL_SearchStoreList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"SearchStoreList"]]

//订单列表
#define URL_GoodsOrderRecord [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GoodsOrderRecord"]]

//店铺列表
#define URL_StoreListByCat [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"StoreListByCat"]]

//商品关注列表
#define URL_AttentedStoreGoodsList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"AttentedStoreGoodsList"]]

//品牌商品
#define URL_GetStoreGoodsByGroupId [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetStoreGoodsByGroupId"]]

//关注商品
#define URL_DoAttentStoreGoods [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"DoAttentStoreGoods"]]
//取消关注商品
#define URL_UndoAttentStoreGoods [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"UndoAttentStoreGoods"]]




/*********获取我的积分**********/
#define URL_GetUserIntegral [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetUserIntegral"]]
/*********获取积分收入支出明细**********/
#define URL_GetUserPointRecord [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetUserPointRecord"]]
/*********绑定账户**********/
#define URL_BindingUserAccountInfo [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"BindingUserAccountInfo"]]

/*********用户账户信息**********/
#define URL_GetUserAccountInfo [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetUserAccountInfo"]]

/*********换购品分类**********/
#define URL_GetGiftCategory [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetGiftCategory"]]
/*********获取积分兑换商品接口**********/
#define URL_GetGiftList [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetGiftList"]]
/*********兑换**********/
#define URL_PurchaseGift [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"PurchaseGift"]]
/********验证手机号归属地**********/
#define URL_GetMobileTelInfo [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetMobileTelInfo"]]
//商品分类
#define URL_GetStoreGoodsSubCats [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetStoreGoodsSubCats"]]

//商品列表
#define URL_GetStoreGoodsByCatId [OnLineURL stringByAppendingString:[NSString stringWithFormat:@"GetStoreGoodsByCatId"]]




#endif /* Macros_h */
