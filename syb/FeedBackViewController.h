//
//  FeedBackViewController.h
//  syb
//
//  Created by GX on 15/10/29.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface FeedBackViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
   

    UITableView * TableView;
    UILabel * label1,*label2;
    UITextView * Tv;
    CustomTextField * Tf;
    SybSession * userSession;
}

@property NSInteger count;
@property (nonatomic,strong)NSMutableDictionary * dict;

@end
