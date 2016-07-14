//
//  ContactUsViewController.h
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * backButton;
    
    UITableView * TableView;
    
    //cell 相关
    UIImageView * cellImageView;
    UILabel * cellTitleLabel;
    UILabel * cellContentLabel;
    
    //提示语言
    UILabel * AlertLabel;
}
@end
