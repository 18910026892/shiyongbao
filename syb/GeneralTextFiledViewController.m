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

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
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
    [self setNavTitle:_TFtype];
    [self showBackButton:YES];
    
    [self.RightBtn setTitle:@"保存" forState:UIControlStateNormal
     ];
    self.RightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.RightBtn addTarget:self action:@selector(CompleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initCustomTextField
{
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    CtfBgView  = [[UIView alloc]init];
    CtfBgView.frame = CGRectMake(0,84, SCREEN_WIDTH,44);
    CtfBgView.backgroundColor = [UIColor whiteColor];
    
    Ctf = [[CustomTextField alloc]initWithFrame:CGRectMake(20,12, SCREEN_WIDTH-40,20)];
    Ctf.TFtype = @"userinfo";
    Ctf.placeholder = [NSString stringWithFormat:@"%@(1-10位字符)",_TFtype];
    if([_TFtype isEqualToString:@"昵称"])
    {
        Ctf.text = userSession.nickName;
        
    }else if([_TFtype isEqualToString:@"宝贝昵称"])
    {
        Ctf.text = userSession.babyName;
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
