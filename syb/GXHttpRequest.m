//
//  GXHttpRequest.m
//  ShiHuoBang
//
//  Created by 光明天下 on 15/3/27.
//  Copyright (c) 2015年 Gongxin. All rights reserved.
//

#import "GXHttpRequest.h"

@implementation GXHttpRequest
//将urlstr UTF8编码
-(NSString *)getEncodeurlStr:(NSString *)urlstr;
{
    NSString *encodeurlstr =  [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodeurlstr;
}
//GET 请求
-(void)StartWorkWithUrlstr:(NSString *)str
{
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[self getEncodeurlStr:str] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(_successGetData){
            self.successGetData(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(_failureGetData){
            self.failureGetData();
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];

    
}
//Post 请求

-(void)StartWorkPostWithurlstr:(NSString *)str pragma:(NSDictionary *)dict ImageData:(NSData *)data;
{
    //状态栏旁边的菊花指示器转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
    //获取设备信息
    [self getDevuceInfo];
    
    [self isNetWork];
    
    NSMutableDictionary * postDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSString * token;
    
    SingleManage * SM = [SingleManage shareManage];
    
  
    
    if ([SM.userToken isEmpty]) {
        token = @"";
    }else
    {
        token = SM.userToken;
    }
    
    [postDict setValue:token forKey:@"token"];
    
    //渠道
    [postDict setValue:@"AppStore" forKey:@"re"];
    
    //用户设备号
    [postDict setValue:_deviceName forKey:@"d_brand"];
    
    //用户设备模型
    [postDict setValue:_deviceModel forKey:@"d_model"];
    
    //用户设备ID
    [postDict setValue:_deviceID forKey:@"uuid"];
    
    //app 版本号
    [postDict setValue:_appVersion forKey:@"client_version"];
    
    //app build 号
    [postDict setValue:_appbuild forKey:@"build"];
    
    //系统名称
    [postDict setValue:_deviceSystemName forKey:@"client"];
    
    //系统版本号
    [postDict setValue:_deviceSystemVersion forKey:@"os_version"];
    
    //系统分辨率
    [postDict setValue:_deviceResolution forKey:@"screen"];
    
    [postDict setValue:_networkType forKey:@"network_type"];
    
    //加密字符串
    [postDict setValue:_sign forKey:@"sign"];
    
    //时间戳
    [postDict setValue:_nowDate forKey:@"st"];
    


    
    
    [manager POST:[self getEncodeurlStr:str]  parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(data==nil) ;else{
            [formData appendPartWithFileData:data name:@"user_photo" fileName:@"defult_placeImage.png" mimeType:@"png"];
        }
    }success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(_successGetData){
            self.successGetData(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(_failureGetData){
            self.failureGetData();
            
                NSLog(@"Error: %@", error.userInfo);
            
       
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

//获取设备信息
-(void)getDevuceInfo
{
    UIDevice *device = [[UIDevice alloc] init];
    _deviceName = device.name;
    _deviceModel = device.name;
    _deviceSystemName = device.systemName;
    _deviceSystemVersion= device.systemVersion;
    _deviceID = [OpenUDID value];
    
   
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = rect.size.width * scale;
    CGFloat height = rect.size.height * scale;
    _deviceResolution = [NSString stringWithFormat:@"%.0f*%.0f",width,height];
    _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    _appbuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    _nowDate = [self getCurrentDateString];
    
    NSString * sign = [NSString stringWithFormat:@"spyg:%@",_nowDate];
    _sign = [NSString MD5WithString:sign];
    


    
}
//时间戳
- (NSString *)getCurrentDateString
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval delta = [zone secondsFromGMTForDate:[NSDate date]];
    NSString *string = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] + delta];
    double a = [string doubleValue];
    double b = a * 1000;
    NSString * string1 = [NSString stringWithFormat:@"%f",b];
    
    NSString *dateString = [[string1 componentsSeparatedByString:@"."]objectAtIndex:0];
    
    return dateString;
}
-(void)isNetWork
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
     
        
        if (status==0) {
            _networkType = @"noNetwork";
            
        }else if(status==1)
        {
            _networkType = @"3G";
        }else if(status==2)
        {
            _networkType = @"wifi";
        }
        
    }];
    
  
    
}

@end
