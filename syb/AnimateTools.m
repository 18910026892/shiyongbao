//
//  AnimateTools.m
//  MPTLive
//
//  Created by caixun on 15/12/14.
//  Copyright © 2015年 Jeakin. All rights reserved.
//

#import "AnimateTools.h"

@interface AnimateTools ()

@property (nonatomic, strong) UIView *oldView;

@end

@implementation AnimateTools

+ (void)showPiFuAnimateWithView:(UIView * __nullable)comeOutView
                 withComeInView:(UIView * __nullable)comeInView
                   withRunSpace:(float)runSpace
                 withcompletion:(void (^ __nullable)(BOOL finished))completion
{
    float comeInDelay = 0.0f;
    float comeOutDelay = 0.0f;
    
    __block BOOL isComeInSuccess = NO;
    __block BOOL isComeOutSuccess = NO;
    
    if(comeOutView != nil)
    {
        comeInDelay = 0.2f;
        
        [UIView animateWithDuration:0.7 delay:comeOutDelay usingSpringWithDamping:0.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
            
            comeOutView.layer.affineTransform = CGAffineTransformTranslate(comeOutView.transform, 0, runSpace);
            
        }
                         completion:^(BOOL finished)
         {
             isComeOutSuccess = YES;
             if(isComeInSuccess && isComeOutSuccess)
             {
                 comeOutView.transform = CGAffineTransformIdentity;
                 [comeOutView removeFromSuperview];
                 
                 completion(finished);
             }
         }];
    }
    else
    {
        isComeOutSuccess = YES;
    }
    
    if(comeInView != nil)
    {
        [UIView animateWithDuration:0.8 delay:comeInDelay usingSpringWithDamping:0.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
            
            comeInView.layer.affineTransform = CGAffineTransformTranslate(comeInView.transform, 0, runSpace);
            
        }
                         completion:^(BOOL finished)
         {
             isComeInSuccess = YES;
             if(isComeInSuccess && isComeOutSuccess)
             {
                 if(comeOutView != nil)
                 {
                     comeOutView.transform = CGAffineTransformIdentity;
                     [comeOutView removeFromSuperview];
                 }
                 
                 completion(finished);
             }
         }];
    }
    else
    {
        isComeInSuccess = YES;
    }
}

- (void)showLvJingAnimateWithView:(UIView * __nullable)fontView
                   withcompletion:(void (^ __nullable)(BOOL finished))completion
{
    fontView.layer.affineTransform = CGAffineTransformScale(fontView.transform, 0, 0);
    
    [self.oldView removeFromSuperview];
    
    self.oldView = fontView;
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        fontView.layer.affineTransform = CGAffineTransformMakeScale(1.5, 1.5);
        
    }
                     completion:^(BOOL finished)
     {
         
     }];
    
    
    [UIView animateWithDuration:0.3 delay:1.0 usingSpringWithDamping:0.5f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        fontView.alpha = 0.0f;
        
    }
                     completion:^(BOOL finished)
     {
         [fontView removeFromSuperview];
     }];
}

+ (CGFloat)scaleAdaptWidth:(CGFloat)fltWidth
{
    /// 如果宽度为0，则直接返回
    if (fltWidth == 0)
    {
        return fltWidth;
    }
    
    /// 获取屏幕的像素密度，如iPhone6Plus，一个点上有3个像素，该值为3
    CGFloat fltScale = [UIScreen mainScreen].scale;
    /// 传入的参数最小值要求为1，如果小于1，则设为1，保证像素最小值为1
    if (fltWidth < 1.0)
    {
        fltWidth = 1.0;
    }
    /// 要显示的点除以屏幕密度，为要返回的点，比实际传进来的要小
    return (fltScale > 0 ? (fltWidth / fltScale) : fltWidth);
}

@end
