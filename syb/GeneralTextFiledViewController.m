//
//  GeneralTextFiledViewController.m
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "GeneralTextFiledViewController.h"

@implementation GeneralTextFiledViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initNavigationBar];
}
-(void)PageSetup
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.navigationController.navigationBarHidden = NO;
}
//初始化顶部导航栏上面的控件
-(void)initNavigationBar
{
    if(!backButton)
    {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationController.navigationBar addSubview:backButton];
    
    if (!CompleteButton) {
        CompleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CompleteButton.frame = CGRectMake(SCREEN_WIDTH-54, 0, 44, 44);
        [CompleteButton setTitle:@"完成" forState:UIControlStateNormal];
        [CompleteButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [CompleteButton addTarget:self action:@selector(CompleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationController.navigationBar addSubview:CompleteButton];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [CompleteButton removeFromSuperview];
    
}
-(void)backButtonClick:(UIButton*)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)CompleteButtonClick:(UIButton*)sender
{
    NSLog(@"完成");
    if ([Ctf.text isEmpty]) {
        
        [HDHud showMessageInView:self.view title:@"昵称不能为空"];
        
    }else if([Ctf.text length]<1||[Ctf.text length]>10)
    {
         [HDHud showMessageInView:self.view title:@"昵称长度应为1-10位字符"];
    }else
    {
        if([_TFtype isEqualToString:@"昵称"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"nickNameChange" object:Ctf.text];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }else if([_TFtype isEqualToString:@"宝贝昵称"])
        {
             [[NSNotificationCenter defaultCenter]postNotificationName:@"babyNameChange" object:Ctf.text];
             [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }

    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initCustomTextField];
}
-(void)initCustomTextField
{
    SM = [SingleManage shareManage];
    
    CtfBgView  = [[UIView alloc]init];
    CtfBgView.frame = CGRectMake(0,84, SCREEN_WIDTH,44);
    CtfBgView.backgroundColor = [UIColor whiteColor];
    
    Ctf = [[CustomTextField alloc]initWithFrame:CGRectMake(20,12, SCREEN_WIDTH-40,20)];
    Ctf.TFtype = @"userinfo";
    Ctf.placeholder = [NSString stringWithFormat:@"%@(1-10位字符)",_TFtype];
    if([_TFtype isEqualToString:@"昵称"])
    {
        Ctf.text = SM.nickName;
        
    }else if([_TFtype isEqualToString:@"宝贝昵称"])
    {
        Ctf.text = SM.babyName;
    }
  
    Ctf.clearButtonMode = UITextFieldViewModeWhileEditing;
    Ctf.autocorrectionType = UITextAutocorrectionTypeNo;
    Ctf.keyboardType = UIKeyboardTypeDefault;
    Ctf.returnKeyType = UIReturnKeyDefault;
    Ctf.delegate = self;
    Ctf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    Ctf.textColor = [UIColor blackColor];
    Ctf.backgroundColor = [UIColor clearColor];
    [Ctf becomeFirstResponder];
    [CtfBgView addSubview:Ctf];
    [self.view addSubview:CtfBgView];
}
@end
