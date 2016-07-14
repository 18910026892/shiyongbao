//
//  MeViewController.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "MeHeaderLoginView.h"
#import "MeHeaderLogoutView.h"
#import "SybSession.h"
@interface MeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MeHeaderLogoutViewDelegate,MeHeaderLoginViewDelegate>

{
    SybSession * userSession;
    
    //cell 相关
    UIImageView * cellImageView;
    UILabel * cellTitleLabel;
    
    //缓存大小
    UILabel * cacheCount;
    
}
@property (nonatomic,strong)UITableView * TableView;

@property (nonatomic,strong)MeHeaderLoginView * loginHeaderView;

@property (nonatomic,strong)MeHeaderLogoutView * logoutHeaderView;



@end
