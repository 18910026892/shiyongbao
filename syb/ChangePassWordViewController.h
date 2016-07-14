//
//  ChangePassWordViewController.h
//  syb
//
//  Created by GX on 15/11/2.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface ChangePassWordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIButton * backButton;
    UIButton * CompleteButton;
    
    UITableView * TableView;
    UILabel * cellTitleLabel;
    
    CustomTextField * cellTextField;
    SingleManage * SM;
}

@property (nonatomic,copy)NSString * OldPassWord;
@property (nonatomic,copy)NSString * NewPassWord;
@property (nonatomic,copy)NSString * AgainPassWord;
@property (nonatomic,strong)NSMutableDictionary * dict;

@end
