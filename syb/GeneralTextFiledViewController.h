//
//  GeneralTextFiledViewController.h
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@interface GeneralTextFiledViewController : BaseViewController<UITextFieldDelegate>
{
  
    CustomTextField * Ctf;
    UIView * CtfBgView;
    SybSession * userSession;
}
@property (nonatomic,copy)NSString * TFtype;
@end
