//
//  AnimateTools.h
//  MPTLive
//
//  Created by caixun on 15/12/14.
//  Copyright © 2015年 Jeakin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimateTools : NSObject

+ (void)showPiFuAnimateWithView:(UIView * __nullable)comeOutView
                 withComeInView:(UIView * __nullable)comeInView
                   withRunSpace:(float)runSpace
                 withcompletion:(void (^ __nullable)(BOOL finished))completion;

- (void)showLvJingAnimateWithView:(UIView * __nullable)fontView
                   withcompletion:(void (^ __nullable)(BOOL finished))completion;

+ (CGFloat)scaleAdaptWidth:(CGFloat)fltWidth;

@end
