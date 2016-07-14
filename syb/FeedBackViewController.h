//
//  FeedBackViewController.h
//  syb
//
//  Created by GX on 15/10/29.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface FeedBackViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UIButton * backButton;
    UIButton * SubmitButton;
    
    UITableView * TableView;
    UILabel * label1,*label2;
    UITextView * Tv;
    CustomTextField * Tf;
    SingleManage * SM;
}

@property NSInteger count;
@property (nonatomic,strong)NSMutableDictionary * dict;

@end
