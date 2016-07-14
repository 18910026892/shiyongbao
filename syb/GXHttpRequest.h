//
//  GXHttpRequest.h
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenUDID.h"
#import "SybSession.h"
#import "NSString+MD5.h"
@interface GXHttpRequest : NSObject

typedef void(^successGetData)(id response);
typedef void(^failureData)(id error);
typedef void(^failureGetData)(id error);

@property(nonatomic,strong) successGetData successBlock;
@property(nonatomic,strong) failureData failureDataBlock;
@property(nonatomic,strong) failureGetData failureBlock;

@property(nonatomic,copy)void(^FiledownloadedTo)(NSURL*);
@property(nonatomic,copy)void(^FileuploadedTo)(id);


//Get请求
-(void)RequestDataWithUrl:(NSString*)urlString;
//post请求
-(void)RequestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict;
//带图片Post请求
-(void)RequestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict ImageDatas:(id)data imageName:(id)imageName;
//下载
-(void)StartDownloadTaskWithUrl:(NSString*)urlString;
//上传
-(void)StartUploadTaskTaskWithUrl:(NSString*)urlString;

//结果回调
-(void)getResultWithSuccess:(successGetData)success DataFaiure:(failureData)datafailure Failure:(failureGetData)failure;


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
