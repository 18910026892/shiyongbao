//
//  IntroductionViewController.m
//  syb
//
//  Created by GX on 15/11/3.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "IntroductionViewController.h"

@implementation IntroductionViewController
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
    if (_count>100) {
        
         [HDHud showMessageInView:self.view title:@"内容不能超过100字"];
        
    }else if ([Tv.text isEmpty]) {
        
        [HDHud showMessageInView:self.view title:@"内容不能为空"];
        
    }else
    {

     [[NSNotificationCenter defaultCenter]postNotificationName:@"introduceChange" object:Tv.text];
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setlayout];
}
-(void)setlayout
{
    SM = [SingleManage shareManage];
    
    
    TvBGView  = [[UIView alloc]init];
    TvBGView.frame = CGRectMake(0,84, SCREEN_WIDTH,140);
    TvBGView.backgroundColor = [UIColor whiteColor];
    
    Tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 12, SCREEN_WIDTH-40, 110)];
    Tv.textColor = [UIColor blackColor];
    Tv.font = [UIFont systemFontOfSize:14];
    Tv.delegate = self;
    Tv.text = SM.userdesc;
    Tv.backgroundColor = [UIColor clearColor];
    Tv.returnKeyType = UIReturnKeyDefault;
    Tv.keyboardType = UIKeyboardTypeDefault;
    [TvBGView addSubview:Tv];
    
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, VIEW_MAXY(TvBGView)-20, 140, 20)];
    
    NSInteger x = [SM.userdesc length];

    label1.text = [NSString stringWithFormat:@"%ld/100字",x];
    label1.textColor = ThemeColor;
    label1.font = [UIFont systemFontOfSize:13];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor clearColor];
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(20,17, 80, 20)];
    label2.text = @"自我介绍";
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.backgroundColor = [UIColor whiteColor];
    label2.hidden = YES;
    [TvBGView addSubview:label2];
    
    [self.view addSubview:TvBGView];
    [self.view addSubview:label1];
    
    
}
-(BOOL)textView:(UITextView *)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [Tv resignFirstResponder];
        return YES;
    }
    if([[Tv text] length]>100){
        return YES;
    }
    //判断是否为删除字符，如果为删除则让执行
    char c=[text UTF8String][0];
    
    if (c=='\000') {
        _count = [[Tv text] length]-1;
        if(_count ==-1){
            _count =0;
        }
        if(_count ==0)
        {
            label2.hidden=NO;//隐藏文字
        }else{
            label2.hidden=YES;
        }
        label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
        return YES;
    }
    if([[Tv text] length]==100) {
        if(![text isEqualToString:@"\b"])
            return NO;
    }
    _count =[[Tv text] length]-[text length]+2;
    if(_count ==0)
    {
        label2.hidden=NO;//隐藏文字
    }else{
        label2.hidden=YES;
    }
    label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _count = [[Tv text] length];
    label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
