//
//  RemindFrameHandler.h
//  shandai
//
//  Created by 戚永超 on 14/10/27.
//
//

#import <Foundation/Foundation.h>

@interface RemindFrameHandler : NSObject
+ (void)addLeftRightAnimation:(UIView *)animtionView;//左右抖动
+ (void)addUpDownAnimation:(UIView *)animtionView;//上下抖动的动画
+ (void)remindFrameAppearScaleAnimaiton:(UIView *)remindView;//提示不能打电话及不能投诉的弹出框出现的动画(由小变大)
+ (void)rotationAnimation:(UIView *)animationView Duration:(NSInteger)timeInterval;//旋转的动画
+ (void)remindRateAppearAnimation:(UIView *)remindTipView;//利率提示条出现时的动画
+ (void)remindEnterListAppearAnimation:(UIView *)remindTipView;//雷达页提示进列表的提示条的动画

@end
