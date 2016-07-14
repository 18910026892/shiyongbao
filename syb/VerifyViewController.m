//
//  VerifyViewController.m
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "VerifyViewController.h"
@interface VerifyViewController ()

@end

@implementation VerifyViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码2/2";
    [self initAgainBtn];
    [self setLayout];
    [self setNavTitle:@"重置密码2/2"];
    [self showBackButton:YES];
 
    [self initAgainBtn];
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
    
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(80, 38, SCREEN_WIDTH-100, 1)];
    line.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    password = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 60, 20)];
    password.text = @"新密码";
    password.textAlignment = NSTextAlignmentLeft;
    password.font = [UIFont systemFontOfSize:14.0];
    password.textColor = [UIColor blackColor];
    
    
    Tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(password)+10, 50, SCREEN_WIDTH-120,20)];
    Tf.placeholder = @"6-16位数字和字母";
    Tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    Tf.autocorrectionType = UITextAutocorrectionTypeNo;
    Tf.keyboardType = UIKeyboardTypeDefault;
    Tf.returnKeyType = UIReturnKeyDefault;
    Tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    Tf.textColor = [UIColor blackColor];
    Tf.secureTextEntry = YES;
    
    
    
    
    TFView = [[UIView alloc]init];
    TFView.frame = CGRectMake(-1, 104, SCREEN_WIDTH+2, 80);
    TFView.backgroundColor = [UIColor whiteColor];
    TFView.layer.borderColor = RGBACOLOR(210, 210, 210, 1).CGColor;
    TFView.layer.borderWidth = 1;
    [TFView addSubview:verficationCodeLabel];
    [TFView addSubview:tf];
    [TFView addSubview:line];
    [TFView addSubview:password];
    [TFView addSubview:Tf];
    [self.view addSubview:TFView];
    
    //下一步按钮
    ResetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ResetBtn.frame = CGRectMake(20, VIEW_MAXY(TFView)+20, SCREEN_WIDTH-40, 35);
    ResetBtn.backgroundColor = ThemeColor;
    [ResetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [ResetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ResetBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    ResetBtn.layer.cornerRadius = 3.5;
    [ResetBtn addTarget:self action:@selector(ResetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ResetBtn];
    
}

-(void)againBtnClick:(UIBarButtonItem*)sender
{
    NSLog(@"again");
    [self startTime];
    NSDate *date = [NSDate date];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [fomatter stringFromDate:date];
    NSString * md5 = [NSString stringWithFormat:@"spyg:phone=%@date=%@",_phoneNumber,dateString];
    NSString * PostMD5 = [NSString MD5WithString:md5];

    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"for",@"bus_type",_phoneNumber,@"phone",PostMD5,@"sms_sign", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];

    
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
-(void)ResetBtnClick:(UIButton*)sender
{
    NSLog(@"Reset");
    _sendCode = [NSString stringWithFormat:@"%@",tf.text];
    _passWord = [NSString stringWithFormat:@"%@",Tf.text];
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNumber,@"username",_passWord,@"newpassword",_sendCode,@"message_code",nil];
    NSLog(@"%@",postDict);
    if ([tf.text length]!=6) {
        [HDHud showMessageInView:self.view title:@"请输入正确的验证码"];
    }else if (![_passWord isValidPassword])
    {
        [HDHud showMessageInView:self.view title:@"无效的密码"];
        
    }else
    {
        [HDHud showHUDInView:self.view title:@"修改中..."];

        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        
        
        [request RequestDataWithUrl:URL_ForgetPassWord pragma:postDict];
        
        [request getResultWithSuccess:^(id response) {
            /// 加保护
            if ([response isKindOfClass:[NSDictionary class]])
            {
                 [HDHud hideHUDInView:self.view];
                
                [HDHud showMessageInView:self.view title:@"修改成功"];
                
                [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.5];
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
-(void)backLogin
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-2] animated:YES];
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
