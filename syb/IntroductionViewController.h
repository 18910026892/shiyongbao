//
//  IntroductionViewController.h
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : BaseViewController<UITextViewDelegate>
{

    UILabel * label1,*label2;
    UITextView * Tv;
    UIView * TvBGView;
    SybSession * userSession;
}
@property NSInteger count;

@end
