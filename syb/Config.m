//
//  Config.m
//  syb
//
//  Created by GX on 15/10/21.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "Config.h"

@implementation Config

-(id) init {
    
    if(!(self = [super init]))
        return self;
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:1],          @"searchType",
                                     nil]];
    

    
    return self;
}

+(Config *) currentConfig {
    
    static Config *instance;
    
    if(!instance)
        
        instance = [[Config alloc] init];
    
    return instance;
}

@end
