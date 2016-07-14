//
//  BKNodataView.h
//  Shell
//
//  Created by GongXin on 16/6/17.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NoDataViewDelegate;
typedef enum{
    kNoDataType_Default     = 0,
    kNoDataType_Smile       = 1,
}NODataType;

@interface BKNodataView : UIView
@property (nonatomic,strong) id<NoDataViewDelegate> delegate;



-(void)showNoDataViewController:(UIViewController *)viewController noDataType:(NODataType)type;
-(void)hide;

-(void)showNoDataView:(UIView*)superView noDataType:(NODataType)type;
-(void)setContentViewFrame:(CGRect)rect;
-(void)setColor:(UIColor*)color;
-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString;
-(void)showSmileNodataView:(UIView*)superView noDataString:(NSString *)noDataString;

@end

@protocol NoDataViewDelegate <NSObject>

-(void)didClickedNoDataButton;
@end
