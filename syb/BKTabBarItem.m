//
//  BKTabBarItem.m
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BKTabBarItem.h"

@implementation Item

-(instancetype)initItemWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    if(self){
        self.title = dict[@"title"];
        self.imageStr = dict[@"imageStr"];
        self.imageStr_s = dict[@"imageStr_s"];
    }
    return self;
}
@end


@implementation BKTabBarItem
{
    UIImageView *ico;
    UILabel *titleLable;
    Item *subItem;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        ico = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-12.5, 5, 25,25)];
        ico.userInteractionEnabled = NO;
        
        [self addSubview:ico];
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-17, frame.size.width, 15)];
        titleLable.userInteractionEnabled = NO;
        titleLable.textColor = kTabBarItemNomalColor;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:11];
        [self addSubview:titleLable];
        

    }
    return self;
}



-(void)setItem:(Item *)item
{
    ico.image = [UIImage imageNamed:item.imageStr];
    titleLable.text = item.title;
    subItem = item;
}


-(void)setItemSlected:(Complete)finish;
{
    titleLable.textColor = kTabBarItemSelectColor;
    ico.image = [UIImage imageNamed:subItem.imageStr_s];
    finish();
}

-(void)setItemNomal;
{
    titleLable.textColor = kTabBarItemNomalColor;
    ico.image = [UIImage imageNamed:subItem.imageStr];
}
@end
