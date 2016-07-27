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

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setNavTitle:@"注册2/2"];
    [self showBackButton:YES];
    [self initAgainBtn];
    [self setLayout];
}
-(void)initAgainBtn
{
    //重新获取验证码的按钮
 
    [self.RightBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
                [self.RightBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
                self.RightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [self.RightBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
                self.RightBtn.userInteractionEnabled = YES;
                
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.RightBtn setTitle:[NSString stringWithFormat:@"(%@)重新获取",strTime] forState:UIControlStateNormal];
                self.RightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [self.RightBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
                self.RightBtn.userInteractionEnabled = NO;
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
    
    verficationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 20)];
    verficationCodeLabel.text = @"验证码";
    verficationCodeLabel.textAlignment = NSTextAlignmentLeft;
    verficationCodeLabel.font = [UIFont systemFontOfSize:14.0];
    verficationCodeLabel.textColor = [UIColor blackColor];
    
    
   
    
    
    
    tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(verficationCodeLabel)+10, 15, SCREEN_WIDTH-120,20)];
    tf.placeholder = @"6位验证码";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDefault;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.textColor = [UIColor blackColor];
    tf.text = [NSString stringWithFormat:@"%@",_testcode];
    
    password = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, 60, 20)];
    password.text = @"密码";
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont systemFontOfSize:14.0];
    password.textColor = [UIColor blackColor];
    
    Tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(verficationCodeLabel)+10, 65, SCREEN_WIDTH-120,20)];
    Tf.placeholder = @"6-16位数字和字母";
    Tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    Tf.autocorrectionType = UITextAutocorrectionTypeNo;
    Tf.keyboardType = UIKeyboardTypeDefault;
    Tf.returnKeyType = UIReturnKeyDefault;
    Tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    Tf.textColor = [UIColor blackColor];
    Tf.secureTextEntry = YES;
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, SCREEN_WIDTH-100, 1)];
    line.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    
    
    
    invitationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 115, 60, 20)];
    invitationCodeLabel.text = @"邀请码";
    invitationCodeLabel.textAlignment = NSTextAlignmentLeft;
    invitationCodeLabel.font = [UIFont systemFontOfSize:14.0];
    invitationCodeLabel.textColor = [UIColor blackColor];
    
    line1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 100, SCREEN_WIDTH-100, 1)];
    line1.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    
    TF = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(invitationCodeLabel)+10, 115, SCREEN_WIDTH-120,20)];
    TF.placeholder = @"选填";
    TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    TF.autocorrectionType = UITextAutocorrectionTypeNo;
    TF.keyboardType = UIKeyboardTypeDefault;
    TF.returnKeyType = UIReturnKeyDefault;
    TF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TF.textColor = [UIColor blackColor];

    
    
    TFView = [[UIView alloc]init];
    TFView.frame = CGRectMake(-1, 104, SCREEN_WIDTH+2, 150);
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
  
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_sendCode pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            //加载框消失
         [HDHud showMessageInView:self.view title:@"验证码已经发送，请注意查收"];
            
            
        }
        
    } DataFaiure:^(id error) {
        [HDHud hideHUDInView:self.view];
        [HDHud showMessageInView:self.view title:error];
    } Failure:^(id error) {
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    }];
    

    

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
        
    
        
        GXHttpRequest *request = [[GXHttpRequest alloc]init];
        
        [request RequestDataWithUrl:URL_Register pragma:postDict];
        
        [request getResultWithSuccess:^(id response) {
            /// 加保护
            if ([response isKindOfClass:[NSDictionary class]])
            {
                
                //加载框消失
                [HDHud hideHUDInView:self.view];
          
                [HDHud showMessageInView:self.view title:@"注册成功"];
    
                if (!userSession) {
                    userSession = [SybSession sharedSession];
                }
                
                NSDictionary * userDict = [response valueForKey:@"result"];
                
                NSLog(@" %@ ",userDict);
                
                [userSession saveWithDictionary:userDict];
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:userDict];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                
                
                
            }
            
        } DataFaiure:^(id error) {
            [HDHud hideHUDInView:self.view];
            [HDHud showMessageInView:self.view title:error];
        } Failure:^(id error) {
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        }];
        

        
        
    }
    
    
    
    
    
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
