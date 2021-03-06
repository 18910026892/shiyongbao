//
//  BKNoNetView.m
//  Shell
//
//  Created by GongXin on 16/6/18.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BKNoNetView.h"
@interface BKNoNetView(){
    BOOL _isLastNoNetwork; //上次是否无网
}
@property (strong, nonatomic)  UIView *contentView;
@property (strong, nonatomic)  UIImageView *flagImageView;
@property (strong, nonatomic)  UILabel *descLabel;
@property (strong, nonatomic)  UILabel *touchScrrenLabel;


@end
@implementation BKNoNetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initNoNetView];
        
    }
    return self;
}
-(void)initNoNetView
{
  
    [self addSubview:self.contentView];
}

-(UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.frame = [UIScreen mainScreen].bounds;

        [_contentView addSubview:self.flagImageView];
        [_contentView addSubview:self.descLabel];
        [_contentView addSubview:self.touchScrrenLabel];
        
    }
    return _contentView;
}

-(UIImageView*)flagImageView
{
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc]init];
        _flagImageView.frame = CGRectMake(90, 124, 140, 140);
    }
    return _flagImageView;
}


-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth/2-53,
                                                       274,
                                                       106,
                                                       20) text:@"网络开小差喽~" textColor:HexRGBAlpha(0xa2a5a9, 1) font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
    }
    return _descLabel;
}

-(UILabel*)touchScrrenLabel
{
    if (!_touchScrrenLabel) {
        _touchScrrenLabel = [UILabel labelWithFrame:CGRectMake(kMainScreenWidth/2-72,
                                                        300,
                                                        144,
                                                        20) text:@"点击屏幕,重新加载" textColor:[UIColor redColor] font:[UIFont fontWithName:KContentFont size:16]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadBtnClicked:)];
        [self addGestureRecognizer:tap];
        
        
    }
    return _touchScrrenLabel;
}






- (void)reloadBtnClicked:(id)sender
{
    
    if (_reloadDataBlock) {
        _reloadDataBlock();
    }else if(_delegate && [_delegate respondsToSelector:@selector(retryToGetData)]){
        [_delegate retryToGetData];
    }
}
#pragma mark public method

-(void)showInView:(UIView*)superView style:(NoNetWorkViewStyle)style
{
    if (!self.superview) {
        [superView addSubview:self];
        self.height = superView.height;
        self.width = superView.width;
    }
    //    _contentView.center = self.center;
    if (style==NoNetWorkViewStyle_No_NetWork) {
        _flagImageView.image = [UIImage imageNamed:@""];
        _descLabel.text = @"网络开小差咯~";
     
    }else if(style==NoNetWorkViewStyle_Load_Fail){
        _flagImageView.image = [UIImage imageNamed:@""];
       
        _descLabel.text = @"信息获取失败!";
    }
    
    //如果上次无网络，则闪烁文字
    if(_isLastNoNetwork){
        _descLabel.alpha = 0;
        _touchScrrenLabel.alpha = 0;
        [UIView animateWithDuration:.1 animations:^{
            _descLabel.alpha = 1.0;
            _touchScrrenLabel.alpha = 1.0;
        }];
    }
    _isLastNoNetwork = YES;
}
-(void)hide
{
    _isLastNoNetwork = NO;
    [self removeFromSuperview];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
