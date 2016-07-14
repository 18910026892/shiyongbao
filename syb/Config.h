//
//  Config.h
//  syb
//
//  Created by GX on 15/10/21.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject


+(Config *)  currentConfig;

@property (readwrite, retain) NSUserDefaults *defaults;
//搜索类型
@property (nonatomic, readwrite, retain) NSNumber * searchType;

@end
