//
//  GXHttpRequest.h
//  ShiHuoBang
//
//  Created by 光明天下 on 15/3/27.
//  Copyright (c) 2015年 Gongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>
@interface GXHttpRequest : NSObject

-(void)StartWorkWithUrlstr:(NSString *)str;
-(void)StartWorkPostWithurlstr:(NSString *)str pragma:(NSDictionary *)dict ImageData:(NSData *)data;
@property(nonatomic,copy)void(^successGetData)(id);
@property(nonatomic,copy)void(^failureGetData)();


//设备信息
//设备名称
@property (nonatomic,copy)NSString * deviceName;
//设备模型
@property (nonatomic,copy)NSString * deviceModel;
//设备系统名称
@property (nonatomic,copy)NSString * deviceSystemName;
//设备系统版本
@property (nonatomic,copy)NSString * deviceSystemVersion;
//设备ID
@property (nonatomic,copy)NSString * deviceID;
//分辨率
@property (nonatomic,copy)NSString * deviceResolution;

//APP版本号
@property (nonatomic,copy)NSString * appVersion;
//app biuld 号
@property (nonatomic,copy)NSString * appbuild;
//当前访问的URL
@property (nonatomic,copy)NSString * visitUrl;
//时间戳
@property (nonatomic,copy)NSString * nowDate;

@property (nonatomic,copy)NSString * networkType;
//MD5加密串
@property (nonatomic,copy)NSString * sign ;


@end
