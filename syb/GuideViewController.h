//
//  GuideViewController.h
//  syb
//
//  Created by GongXin on 16/7/20.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
@protocol GuideViewControllerDelegate;

@interface GuideViewController : BaseViewController
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,weak) id<GuideViewControllerDelegate>delegate;
@end

@protocol GuideViewControllerDelegate <NSObject>

-(void)GuideViewControllerSureBtnClicked;
@end
