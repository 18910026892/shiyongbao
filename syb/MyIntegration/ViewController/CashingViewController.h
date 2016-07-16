//
//  CashingViewController.h
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
typedef enum {
    zhifubaoType =1,
    bankType
}AccountType;
@interface CashingViewController : BaseViewController
@property (nonatomic,copy)NSString *gift_cate_id;
@end
