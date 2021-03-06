//
//  HomePageViewController.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "CCAdsPlayView.h"
#import "ProductGoodsModel.h"
#import "ProductGoodsCell.h"
#import "SybSession.h"
#import "brandModel.h"
#import "BrandCell.h"
#import "HYSegmentedControl.h"


@interface HomePageViewController : BaseViewController<ProductGoodsCellDelegate>
{
    SybSession * userSession;
}


@property(nonatomic,strong)HYSegmentedControl * control;

@property(nonatomic,strong)NSArray * itemArray;

@property(nonatomic,strong)UIButton * searchButton;

@property(nonatomic,strong)UIButton * messageButton;

@property (nonatomic,strong)UIImageView * pointImage;

@property(nonatomic,strong)UIImageView * logoImageView;

@property (nonatomic,strong)UIButton * GoTopButton;

@property (nonatomic,strong)CCAdsPlayView * BannerView;
@end
