//
//  AccountViewController.h
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    UILabel * AccountLabel;
    UITableView * TableView;
    UIButton * LogoutButton;
     SybSession * userSession;
    
    UIImageView * cellImageView;
    UILabel * cellTitleLabel;
    
}
@end
