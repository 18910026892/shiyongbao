//
//  GXHttpRequest.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "GXHttpRequest.h"

@implementation GXHttpRequest
-(id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


//将 UTF8编码
-(NSString *)getEncodeurlStr:(NSString *)urlstr;
{
    NSString *encodeurlstr =  [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodeurlstr;
}

-(void)getResultWithSuccess:(successGetData)success DataFaiure:(failureData)datafailure Failure:(failureGetData)failure;
{
    _successBlock = success;
    _failureDataBlock = datafailure;
    _failureBlock = failure;
}

//Get 请求
-(void)RequestDataWithUrl:(NSString*)urlString;
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * requestUrl = [self getEncodeurlStr:urlString];
    
    [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([jsonDict[@"state"] integerValue]==1){
            if(_successBlock){
                id response = jsonDict[@"data"];
                self.successBlock(response);
            }
        }else{
            if(_failureDataBlock){
                self.failureDataBlock(jsonDict[@"msg"]);
            }
        }
        
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(_failureBlock){
            self.failureBlock(error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

//不带图片post请求
-(void)RequestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict;
{
    [self RequestDataWithUrl:urlString pragma:pragmaDict ImageDatas:nil imageName:nil];
}


//带图片Post 请求
-(void)RequestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict ImageDatas:(id)data imageName:(id)imageName;
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    //获取设备信息
    [self getDevuceInfo];
    
    [self isNetWork];
    
    NSMutableDictionary * postDict = [NSMutableDictionary dictionaryWithDictionary:pragmaDict];

    SybSession * userSession = [SybSession sharedSession];

    if (userSession.isLogin) {
        
         [postDict setValue:userSession.userToken forKey:@"token"];
    }else
    {
         [postDict setValue:@"" forKey:@"token"];
    }
    
   
    
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
    
    NSString * requestUrl = [self getEncodeurlStr:urlString];
    
    [manager POST:requestUrl parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(data==nil) ;
        else if([data isKindOfClass:[NSData class]]){
            [formData appendPartWithFileData:data name:imageName fileName:@"defult_placeImage.png" mimeType:@"png"];
        }else if([data isKindOfClass:[NSMutableArray class]]){
            //多张图片上传
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData *imgData = (NSData *)obj;
                NSString *imgKey = [imageName isKindOfClass:[NSString class]]?imageName:imageName[idx];
                [formData appendPartWithFileData:imgData name:imgKey fileName:@"defult_placeImage.png" mimeType:@"png"];
            }];
        }
        
    } progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([jsonDict[@"code"] integerValue]==1){
            if(_successBlock){
                id response = jsonDict;
                self.successBlock(response);
            }
        }else{
            if(_failureDataBlock){
                self.failureDataBlock(jsonDict[@"message"]);
            }
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(_failureBlock){
            self.failureBlock(error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        NSLog(@"  %@ ",error);
    }];
}

//下载
-(void)StartDownloadTaskWithUrl:(NSString*)urlString;
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        if(_FiledownloadedTo){
            self.FiledownloadedTo(filePath);
        }
        
    }];
    [downloadTask resume];
}
//上传
-(void)StartUploadTaskTaskWithUrl:(NSString*)urlString;
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
            if(_FileuploadedTo)
            {
                self.FileuploadedTo(responseObject);
            }
        }
    }];
    [uploadTask resume];
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
