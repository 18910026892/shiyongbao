//
//  GeneralTextFiledViewController.h
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface GeneralTextFiledViewController : UIViewController<UITextFieldDelegate>
{
    UIButton * backButton;
    UIButton * CompleteButton;
    
    CustomTextField * Ctf;
    UIView * CtfBgView;
    SingleManage * SM;
}
@property (nonatomic,copy)NSString * TFtype;
@end
