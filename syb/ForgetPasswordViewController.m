//
//  ForgetPasswordViewController.m
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "VerifyViewController.h"
@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    [self initBackButton];
    [MobClick beginLogPageView:@"忘记密码"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [MobClick endLogPageView:@"忘记密码"];
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
    self.title = @"重置密码1/2";
    [self getConfig];
}

-(void)getConfig
{
    
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkWithUrlstr:URL_Config];
    NSLog( @"^^^^^^^%@",URL_Config);
    request.successGetData = ^(id obj){
        
        
    
        NSDictionary * dict = [obj valueForKey:@"result"];
        _needShow  = [dict valueForKey:@"is_show_captcha"];
        NSLog(@"^^^%@",_needShow);
        
        if ([_needShow isEqualToString:@"1"
             ]) {
            _isShow = YES;
            _isTest = NO;
        }else if([_needShow isEqualToString:@"0"
                  ])
        {
            _isShow = NO;
            _isTest = YES;
        }
        
        [self setLayout];
    };
    request.failureGetData = ^(void){
        
    };
    
    
    
}





//初始化控件群
-(void)setLayout
{
    phoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 20)];
    phoneNumber.text = @"手机号";
    phoneNumber.textAlignment = NSTextAlignmentLeft;
    phoneNumber.font = [UIFont systemFontOfSize:14.0];
    phoneNumber.textColor = [UIColor blackColor];
    
    tf = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(phoneNumber)+10, 10, SCREEN_WIDTH-120,20)];
    tf.placeholder = @"请输入手机号";
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDefault;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.textColor = [UIColor blackColor];
    
    
    
    
    TFView = [[UIView alloc]init];
    if (!_isShow) {
        TFView.frame = CGRectMake(-1, 84, SCREEN_WIDTH+2, 40);
    }else if (_isShow)
    {
        TFView.frame = CGRectMake(-1, 84, SCREEN_WIDTH+2, 80);
        
        //中间的线条
        line = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, SCREEN_WIDTH-80, .5)];
        line.backgroundColor = RGBACOLOR(215, 215, 215, 1);
        [TFView addSubview:line];
        
        codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 60, 20)];
        codeLabel.text = @"验证码";
        codeLabel.textAlignment = NSTextAlignmentLeft;
        codeLabel.font = [UIFont systemFontOfSize:14.0];
        codeLabel.textColor = [UIColor blackColor];
        [TFView addSubview:codeLabel];
        
        codeTF = [[CustomTextField alloc]initWithFrame:CGRectMake(VIEW_MAXX(codeLabel)+10, 50, SCREEN_WIDTH-120, 20)];
        codeTF.textColor = [UIColor blackColor];
        codeTF.placeholder = @"请输入右侧验证码";
        codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        codeTF.autocorrectionType = UITextAutocorrectionTypeNo;
        codeTF.keyboardType = UIKeyboardTypeNumberPad;
        codeTF.returnKeyType = UIReturnKeyDefault;
        codeTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        [TFView addSubview:codeTF];
        
        pooCode = [[PooCodeView alloc] initWithFrame:CGRectMake(WIDTH_VIEW(self.view)-80,40, 80, 40)];
        [TFView addSubview:pooCode];
        
        
        
    }
    
    TFView.backgroundColor = [UIColor whiteColor];
    TFView.layer.borderColor = RGBACOLOR(210, 210, 210, 1).CGColor;
    TFView.layer.borderWidth = 1;
    [TFView addSubview:phoneNumber];
    [TFView addSubview:tf];
    [TFView addSubview:tf];
    [self.view addSubview:TFView];
    
    
    //下一步按钮
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, VIEW_MAXY(TFView)+20, SCREEN_WIDTH-40, 35);
    nextBtn.backgroundColor = ThemeColor;
    [nextBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    nextBtn.layer.cornerRadius = 3.5;
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}



-(void)nextBtnClick:(UIButton*)sender
{
    _userName = [NSString stringWithFormat:@"%@",tf.text];
    
    if (_isShow) {
        if(![_userName isValidPhone])
        {
            [HDHud showMessageInView:self.view title:@"请您输入正确的手机号"];
        }else  if (![codeTF.text isEqualToString:pooCode.changeString]) {
            _isTest = NO;
            
            [HDHud showMessageInView:self.view title:@"请输入正确的验证码"];
            
        }else   if ([codeTF.text isEqualToString:pooCode.changeString]) {
            NSLog(@"一样");
            _isTest = YES;
            [codeTF resignFirstResponder];
            [self sendCode];
        }
        
        
    }else
    {
        if(![_userName isValidPhone])
        {
            [HDHud showMessageInView:self.view title:@"请您输入正确的手机号"];
        }else   if ([_userName isValidPhone]) {
            
            [codeTF resignFirstResponder];
            [self sendCode];
        }
        
    }
    
    
}
-(void)sendCode
{
   
    
    NSDate *date = [NSDate date];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [fomatter stringFromDate:date];
    NSString * md5 = [NSString stringWithFormat:@"spyg:phone=%@date=%@",_userName,dateString];
    NSString * PostMD5 = [NSString MD5WithString:md5];
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"for",@"bus_type",_userName,@"phone",PostMD5,@"sms_sign", nil];
    GXHttpRequest * request = [[GXHttpRequest alloc]init];
    [request StartWorkPostWithurlstr:URL_sendCode pragma:postDict ImageData:nil];
    request.successGetData = ^(id obj){
        
        
        
        _sendDict = [NSMutableDictionary dictionaryWithDictionary:obj];
        
        _testcode = [[obj valueForKey:@"result"]valueForKey:@"message_code"];
        
        NSLog(@"^^%@",_sendDict);
        
        NSString * code = [_sendDict valueForKey:@"code"];
        NSString * reason = [_sendDict valueForKey:@"message"];
        if([code isEqualToString:@"1"])
        {
            
            VerifyViewController * verifyVC = [[VerifyViewController alloc]init];
            verifyVC.phoneNumber = _userName;
            verifyVC.testcode = _testcode;
            [self.navigationController pushViewController:verifyVC animated:YES];
            
        }else if([code isEqualToString:@"0"])
        {
            [HDHud showMessageInView:self.view title:reason];
        }
    };
    request.failureGetData = ^(void){
        
        [HDHud hideHUDInView:self.view];
        [HDHud showNetWorkErrorInView:self.view];
    };
    
    
    
    
    
    
    
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
