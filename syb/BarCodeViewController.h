//
//  BarCodeViewController.h
//  syb
//
//  Created by GX on 15/10/22.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarCodeViewController : UIViewController<ZBarReaderViewDelegate>

@property (nonatomic,strong)ZBarReaderView * readView;

//背景视图
@property (nonatomic,strong)UIView * colView;

//返回上个页面的按钮
@property (nonatomic,strong)UIButton * backButton;

//扫描页面标题
@property (nonatomic,strong)UILabel * titleLabel;

//提示用户扫码的标签
@property (nonatomic,strong)UILabel * alertLabel;

//扫描页面中心扫描区域
@property (nonatomic,strong)UIImageView * centerImageView;

//扫描页面上下扫描的绿色的线
@property (nonatomic,strong)UIImageView * lineView;

//闪光灯
@property (nonatomic,strong)UIButton * lightButton;

@property int num;
@property BOOL upOrdown;
@property NSTimer * timer;

//扫描结果
@property (nonatomic,strong)NSString * result;
@end
