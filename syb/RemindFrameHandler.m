//
//  RemindFrameHandler.m
//  shandai
//
//  Created by 戚永超 on 14/10/27.
//
//

#import "RemindFrameHandler.h"

@implementation RemindFrameHandler
//输入信息有误，晃动文本框
+(void)addLeftRightAnimation:(UIView *)animtionView{

    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 8, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -8, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
    [UIView animateWithDuration:0.1 animations:^{
        animtionView.transform = moveLeft;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            animtionView.transform = moveRight;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                animtionView.transform = moveLeft;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    animtionView.transform = moveRight;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        animtionView.transform = resetTransform;
                    }];
                }];
            }];
        }];
    }];
    
}

+ (void)addUpDownAnimation:(UIView *)animtionView{
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    frameAnimation.fromValue = @(-5);
    frameAnimation.toValue = @5;
    frameAnimation.duration = .5;
    frameAnimation.removedOnCompletion = YES;
    frameAnimation.autoreverses = YES;
    frameAnimation.repeatCount = FLT_MAX;
    [animtionView.layer addAnimation:frameAnimation forKey:@"transform.translation.y"];
}

+ (void)remindFrameAppearScaleAnimaiton:(UIView *)remindView{
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [remindView.layer addAnimation:animation forKey:@"transform"];

}

+ (void)rotationAnimation:(UIView *)animationView Duration:(NSInteger)timeInterval{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI*2 ];
    rotationAnimation.duration = timeInterval;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = FLT_MAX;
    [animationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)remindRateAppearAnimation:(UIView *)remindTipView{
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    frameAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(258, 40)];
    frameAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(195.5, 66.5)];
    frameAnimation.removedOnCompletion = YES;
    frameAnimation.duration = .5;
    [remindTipView.layer addAnimation:frameAnimation forKey:@"position"];
    
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .5;
    animation.removedOnCompletion = YES;
    animation.repeatCount = 1;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [remindTipView.layer addAnimation:animation forKey:@"transform"];

}

+ (void)remindEnterListAppearAnimation:(UIView *)remindTipView{
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    frameAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(303, 59)];
    frameAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(245.5, 89)];
    frameAnimation.removedOnCompletion = YES;
    frameAnimation.duration = .5;
    [remindTipView.layer addAnimation:frameAnimation forKey:@"position"];
    
    CAKeyframeAnimation *animation=nil;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .5;
    animation.removedOnCompletion = YES;
    animation.repeatCount = 1;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [remindTipView.layer addAnimation:animation forKey:@"transform"];

}

@end
