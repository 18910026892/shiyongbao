//
//  MineViewController.h
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+VGParallaxHeader.h>
@interface MineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    //单例对象
    SingleManage * SM;
    
    //背景表格视图
    UITableView * table;
    
    //顶部头视图
    UIImageView * HeaderView;
    //用户登录时的界面
    UIImageView * userPhotoImg;
    UILabel * userNickNameLabel;
    UILabel * babyNameLabel;
    UIButton * messageButton;
    UIImageView * pointImage;
  
    
    
    //用户未登录时候的界面
    UIButton * LoginButton;
    UIImageView * LoginImage;
    UILabel * LoginLabel;
    
    
    //cell 相关
    UIImageView * cellImageView;
    UILabel * cellTitleLabel;
    
    //缓存大小
    UILabel * cacheCount;
    
    
}

@end
