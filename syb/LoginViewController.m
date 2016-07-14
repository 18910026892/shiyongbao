//
//  LoginViewController.m
//  syb
//
//  Created by GX on 15/8/19.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initNavigationBar];
     [MobClick beginLogPageView:@"登录"];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)PageSetup
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;  
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
     [MobClick endLogPageView:@"登录"];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.tabBarController.tabBar.hidden = YES;

    [self initTFView];
    [self initBtns];
  
}


//初始化顶部导航栏上面的控件
-(void)initNavigationBar
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
//输入区域
-(void)initTFView
{
    //账号图标
    userNameImg = [[UIImageView alloc]initWithFrame:CGRectMake(20,10, 14.5, 17)];
    userNameImg.image = [UIImage imageNamed:@"username"];
    
    //账号输入视图
    userNameTF = [[CustomTextField alloc]initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH-100,20)];
    userNameTF.placeholder = @"请输入手机号";
    userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    userNameTF.returnKeyType = UIReturnKeyDefault;
    userNameTF.delegate = self;
    userNameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userNameTF.textColor = [UIColor blackColor];
    
    //密码图标
    passWordImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 47, 14.5, 17)];
    passWordImg.image = [UIImage imageNamed:@"password"];
    
    //密码输入视图
    passWordTF = [[CustomTextField alloc]initWithFrame:CGRectMake(80, 47, SCREEN_WIDTH-100,20)];
    passWordTF.placeholder = @"请输入密码";
    passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordTF.autocorrectionType = UITextAutocorrectionTypeNo;
    passWordTF.keyboardType = UIKeyboardTypeDefault;
    passWordTF.returnKeyType = UIReturnKeyDefault;
    passWordTF.delegate = self;
    passWordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passWordTF.textColor = [UIColor blackColor];
    passWordTF.secureTextEntry = YES;
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(60, 38, SCREEN_WIDTH-80, 1)];
    line.backgroundColor = RGBACOLOR(215, 215, 215, 1);
    
    
    //输入区域父视图
    TFView = [[UIView alloc]initWithFrame:CGRectMake(-1,84, SCREEN_WIDTH+2, 75)];
    TFView.backgroundColor = [UIColor whiteColor];
    TFView.layer.borderWidth = 0.5;
    TFView.layer.borderColor = RGBACOLOR(210, 210, 210, 1).CGColor;
    
    [TFView addSubview:userNameImg];
    [TFView addSubview:passWordImg];
    [TFView addSubview:userNameTF];
    [TFView addSubview:passWordTF];
    [TFView addSubview:line];
    [self.view addSubview:TFView];
}
//初始化按钮群
-(void)initBtns;
{
    //登录
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, VIEW_MAXY(TFView)+30, SCREEN_WIDTH-40, 35);
    loginBtn.backgroundColor = ThemeColor;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    loginBtn.layer.cornerRadius = 3.5;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //注册
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, VIEW_MAXY(loginBtn)+10, SCREEN_WIDTH/2-40, 35);
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];;
    //新学习的属性
    registerBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(SCREEN_WIDTH/2+20, VIEW_MAXY(loginBtn)+10, SCREEN_WIDTH/2-40, 35);
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];    forgetBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    [forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
    
}

//登录按钮的点击事件
-(void)loginBtnClick:(UIButton*)sender
{
    NSLog(@"login");
    [userNameTF resignFirstResponder];
    [passWordTF resignFirstResponder];
    
    //用户名 密码
    _userName = [NSString stringWithFormat:@"%@",userNameTF.text];
    _passWord = [NSString stringWithFormat:@"%@",passWordTF.text];
    
   
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_userName,@"username",_passWord,@"password",nil];
 
    
    if ([_userName isValidPhone]&&![_passWord isEmpty]) {
      
    
        [HDHud showHUDInView:self.view title:@"登录中..."];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_Login pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            NSLog(@"%@-----%@",postDict,obj);
            
            
            _dict = [NSMutableDictionary dictionaryWithDictionary:obj];
            
            NSString * code = [_dict valueForKey:@"code"];
            NSString * reason = [_dict valueForKey:@"message"];
         
            if ([code isEqualToString:@"1"]) {
    
                _userDict = [_dict valueForKey:@"result"];
                [self saveUserInfo:_userDict];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:_userDict];
                NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
                [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
                
            }else if([code isEqualToString:@"0"])
            {
                NSLog(@"登录失败");
                [HDHud showMessageInView:self.view title:reason];
                
            }
            
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
            
                       
            
        };
        
        
    }else
    {
        [RemindFrameHandler addLeftRightAnimation:TFView];
    }

    
}
-(void)saveUserInfo:(NSMutableDictionary*)dict
{

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


//注册按钮的点击事件
-(void)registerBtnClick:(UIButton*)sender
{
    NSLog(@"register");
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
//忘记密码按钮的点击事件
-(void)forgetBtnClick:(UIButton*)sender
{
    NSLog(@"forget");
    ForgetPasswordViewController * fpVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:fpVC animated:YES];
}
#pragma textfeild 代理方法
//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameTF resignFirstResponder];
    [passWordTF resignFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userNameTF resignFirstResponder];
    [passWordTF resignFirstResponder];
    return YES;
    
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
