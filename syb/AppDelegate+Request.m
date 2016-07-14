//
//  AppDelegate+Request.m
//  syb
//
//  Created by GongXin on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AppDelegate+Request.h"

@implementation AppDelegate (Request)

-(void)getShopCatList
{
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_ShopCatList pragma:nil];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            NSMutableArray * shopCatList = [response valueForKey:@"result"];
      
            [UserDefaultsUtils saveValue:shopCatList forKey:@"shopCatList"];
            
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
}

-(void)getGoodsCatList;
{
    
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_StoreGoodsFirstLevelCats pragma:nil];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
        
            NSLog(@" %@",response);
            
            NSMutableArray * goodCatList = [response valueForKey:@"result"];
            
            [UserDefaultsUtils saveValue:goodCatList forKey:@"goodCatList"];
            
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
    
    
}
@end
