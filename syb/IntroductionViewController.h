//
//  IntroductionViewController.h
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController<UITextViewDelegate>
{
    UIButton * backButton;
    UIButton * CompleteButton;

    UILabel * label1,*label2;
    UITextView * Tv;
    UIView * TvBGView;
    SingleManage * SM;
}
@property NSInteger count;

@end
