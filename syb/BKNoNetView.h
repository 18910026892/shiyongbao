//
//  BKNoNetView.h
//  Shell
//
//  Created by GongXin on 16/6/18.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    NoNetWorkViewStyle_No_NetWork=0,
    NoNetWorkViewStyle_Load_Fail
}NoNetWorkViewStyle;
@protocol NoNetWorkViewDelegate ;
@interface BKNoNetView : UIView

@property (weak,nonatomic) id<NoNetWorkViewDelegate> delegate;
@property (nonatomic, copy) dispatch_block_t reloadDataBlock;

-(void)showInView:(UIView*)superView style:(NoNetWorkViewStyle)style;
-(void)hide;
@end

@protocol NoNetWorkViewDelegate <NSObject>

-(void)retryToGetData;
@end
