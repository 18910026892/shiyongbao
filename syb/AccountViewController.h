//
//  AccountViewController.h
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * backButton;
    UILabel * AccountLabel;
    UITableView * TableView;
    UIButton * LogoutButton;
    SingleManage * SM;
    
    UIImageView * cellImageView;
    UILabel * cellTitleLabel;
    
}
@end
