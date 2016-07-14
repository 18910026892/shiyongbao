//
//  BKTabBarItem.h
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Item : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *imageStr_s;
-(instancetype)initItemWithDictionary:(NSDictionary *)dict;

@end

typedef void(^Complete)();

@interface BKTabBarItem : UIView

@property(nonatomic,strong)Item *item;
-(void)setItemSlected:(Complete)finish;
-(void)setItemNomal;
@end
