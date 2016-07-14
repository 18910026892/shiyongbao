//
//  VerificationViewController.m
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "VerificationViewController.h"

@interface VerificationViewController ()

@end

@implementation VerificationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",_phoneNumber);
    self.navigationItem.hidesBackButton = YES;
    [self initBackButton];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
}
-(void)initBackButton
{
    if (!backButton) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.navigationController.navigationBar addSubview:backButton];
}
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BGColor;
    self.title = @"注册2/2";
    [self initAgainBtn];
    [self setLayout];
}
-(void)initAgainBtn
{
    //重新获取验证码的按钮
    againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    againBtn.frame = CGRectMake(0, 0, 90, 30);
    againBtn.backgroundColor = [UIColor clearColor];
    [againBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    againBI = [[UIBarButtonItem alloc]initWithCustomView:againBtn];
    [againBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = againBI;
    [self startTime];
}
#pragma 开启时间线程
-(void)startTime{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [againBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
                againBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [againBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
                againBtn.userInteractionEnabled = YES;
                
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [againBtn setTitle:[NSString stringWithFormat:@"(%@)重新获取",strTime] forState:UIControlStateNormal];
                againBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [againBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
                againBtn.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

//布局控件
-(void)setLayout
{
    phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH-40, 40)];
    phoneNumberLabel.backgroundColor = [UIColor clearColor];
    phoneNumberLabel.text = [NSString stringWithFormat:@"短信验证码发送至%@",_phoneNumber];
    phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumberLabel.font = [UIFont systemFontOfSize:14.0];
    phoneNumberLabel.textColor = [UIColor grayColor];
    [self.view addSubview:phoneNumberLabel];
    
    verficationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 20)];
    verficationCodeLabel.text = @"验证码";
    verficationCodeLabel.textAlignment = NSTextAlignmentLeft;
    verficationCodeLabel.font = [UIFont systemFontOfSize:14.0];
    verficationCodeLabel.textColor = [UIColor blackColor];
    
    
   
    
    
    
    tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(verficationCodeLabel)+10, 10, SCREEN_WIDTH-120,20)];
    tf.placeholder = @"6位验证码";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDefault;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.textColor = [UIColor blackColor];
    tf.text = [NSString stringWithFormat:@"%@",_testcode];
    
    password = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 60, 20)];
    password.text = @"密码";
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont systemFontOfSize:14.0];
    password.textColor = [UIColor blackColor];
    
    Tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(verficationCodeLabel)+10, 50, SCREEN_WIDTH-120,20)];
    Tf.placeholder = @"6-16位数字和字母";
    Tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    Tf.autocorrectionType = UITextAutocorrectionTypeNo;
    Tf.keyboardType = UIKeyboardTypeDefault;
    Tf.returnKeyType = UIReturnKeyDefault;
    Tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    Tf.textColor = [UIColor blackColor];
    Tf.secureTextEntry = YES;
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(80, 38, SCREEN_WIDTH-100, 1)];
    line.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    
    
    
    invitationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, 60, 20)];
    invitationCodeLabel.text = @"邀请码";
    invitationCodeLabel.textAlignment = NSTextAlignmentLeft;
    invitationCodeLabel.font = [UIFont systemFontOfSize:14.0];
    invitationCodeLabel.textColor = [UIColor blackColor];
    
    line1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 78, SCREEN_WIDTH-100, 1)];
    line1.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    
    TF = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(invitationCodeLabel)+10, 90, SCREEN_WIDTH-120,20)];
    TF.placeholder = @"选填";
    TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    TF.autocorrectionType = UITextAutocorrectionTypeNo;
    TF.keyboardType = UIKeyboardTypeDefault;
    TF.returnKeyType = UIReturnKeyDefault;
    TF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TF.textColor = [UIColor blackColor];

    
    
    TFView = [[UIView alloc]init];
    TFView.frame = CGRectMake(-1, 104, SCREEN_WIDTH+2, 120);
    TFView.backgroundColor = [UIColor whiteColor];
    TFView.layer.borderColor = RGBACOLOR(210, 210, 210, 1).CGColor;
    TFView.layer.borderWidth = 1;
    [TFView addSubview:verficationCodeLabel];
    [TFView addSubview:tf];
    [TFView addSubview:password];
    [TFView addSubview:Tf];
    [TFView addSubview:line];
    [TFView addSubview:line1];
    [TFView addSubview:invitationCodeLabel];
    [TFView addSubview:TF];
    [tf addSubview:againBtn];
    [self.view addSubview:TFView];
    
    //下一步按钮
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, VIEW_MAXY(TFView)+20, SCREEN_WIDTH-40, 35);
    registerBtn.backgroundColor = ThemeColor;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    registerBtn.layer.cornerRadius = 3.5;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
}

-(void)againBtnClick:(UIButton*)sender
{
    NSLog(@"again");
    [self startTime]; 
    NSDate *date = [NSDate date];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [fomatter stringFromDate:date];
    NSString * md5 = [NSString stringWithFormat:@"spyg:phone=%@date=%@",_phoneNumber,dateString];
    NSString * PostMD5 = [NSString MD5WithString:md5];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"reg",@"bus_type",_phoneNumber,@"phone",PostMD5,@"sms_sign", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_sendCode pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
          NSLog(@"%@",postDict);
        
        _sendDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        NSString * code = [_sendDict valueForKey:@"code"];
        NSString * reason = [_sendDict valueForKey:@"message"];
        if([code isEqualToString:@"1"])
        {
            
            NSLog(@"发送成功");
            [HDHud showMessageInView:self.view title:reason];
            
        }else if([code isEqualToString:@"0"])
        {
            [HDHud showMessageInView:self.view title:reason];
        }
    };
    request.failureGetData = ^(void){
        
 
        [HDHud showNetWorkErrorInView:self.view];
    };

}

-(void)registerBtnClick:(UIButton*)sender
{
    NSLog(@"register");
    
    _sendCode = [NSString stringWithFormat:@"%@",tf.text];
    _passWord = [NSString stringWithFormat:@"%@",Tf.text];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber,@"username",_passWord,@"password",_sendCode,@"message_code",TF.text, @"invitation",nil];
 
    if ([tf.text length]!=6) {
        [HDHud showMessageInView:self.view title:@"请输入正确的验证码"];
    }else
    
    if (![_passWord isValidPassword])
    {
        [HDHud showMessageInView:self.view title:@"无效的密码"];
        
    }else
    {
        [HDHud showHUDInView:self.view title:@"注册中..."];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_Register pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            _dict = [NSMutableDictionary dictionaryWithDictionary:obj];
            
            NSLog(@"%@",postDict);
         
            
            NSNumber * code = [_dict valueForKey:@"code"];
            NSString * result = [NSString stringWithFormat:@"%@",code];
            NSString * reason = [_dict valueForKey:@"message"];
            if ([result isEqualToString:@"0"]) {
                NSLog(@"注册失败");
                [HDHud showMessageInView:self.view title:reason];
            }else if([result isEqualToString:@"1"])
            {
                NSLog(@"注册成功");
                [HDHud showMessageInView:self.view title:@"注册成功"];
                _userDict = [_dict valueForKey:@"result"];
                [self saveUserInfo:_userDict];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:_userDict];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
        
        
        
    }
    
    
    
    
    
}



-(void)saveUserInfo:(NSMutableDictionary*)dict
{
    NSLog(@"……………………^_^ %@",dict);
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_name"] forKey:@"user_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_photo"] forKey:@"user_photo"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"nickname"] forKey:@"nickname"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"birthday"] forKey:@"birthday"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"sex"] forKey:@"sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"code"] forKey:@"code"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"token"] forKey:@"token"];
    [UserDefaultsUtils saveValue:_passWord forKey:@"password"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"app_money"] forKey:@"user_money"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_desc"] forKey:@"user_desc"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_name"] forKey:@"baby_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_sex"] forKey:@"baby_sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_birthday"] forKey:@"baby_birthday"];
    
    
    //单例取值
    SM = [SingleManage shareManage];
    SM.userID = [UserDefaultsUtils valueWithKey:@"user_id"];
    SM.userName = [UserDefaultsUtils valueWithKey:@"user_name"];
    SM.imageURL = [UserDefaultsUtils valueWithKey:@"user_photo"];
    SM.nickName  = [UserDefaultsUtils valueWithKey:@"nickname"];
    SM.birthday = [UserDefaultsUtils valueWithKey:@"birthday"];
    SM.userSex = [UserDefaultsUtils valueWithKey:@"sex"];
    SM.code  = [UserDefaultsUtils valueWithKey:@"code"];
    SM.userToken = [UserDefaultsUtils valueWithKey:@"token"];
    SM.passWord = [UserDefaultsUtils valueWithKey:@"password"];
    SM.userMoney = [UserDefaultsUtils valueWithKey:@"user_money"];
    SM.userdesc = [UserDefaultsUtils valueWithKey:@"user_desc"];
    SM.babyName = [UserDefaultsUtils valueWithKey:@"baby_name"];
    SM.babySex = [UserDefaultsUtils valueWithKey:@"baby_sex"];
    SM.babyBirthday = [UserDefaultsUtils valueWithKey:@"baby_birthday"];
    
    SM.isLogin = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
