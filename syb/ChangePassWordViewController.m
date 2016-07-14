//
//  ChangePassWordViewController.m
//  syb
//
//  Created by GX on 15/11/2.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ChangePassWordViewController.h"
@implementation ChangePassWordViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"密码修改";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initNavigationBar];
    [MobClick beginLogPageView:@"密码修改"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [CompleteButton removeFromSuperview];
     [MobClick endLogPageView:@"密码修改"];
}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    
}

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
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}
-(void)CompleteButtonClick:(UIButton*)sender
{
    
    CustomTextField * ctf1 = (CustomTextField*)[self.view viewWithTag:1000];
    CustomTextField * ctf2 = (CustomTextField*)[self.view viewWithTag:1001];
    CustomTextField * ctf3 = (CustomTextField*)[self.view viewWithTag:1002];

    
    [ctf1 resignFirstResponder];
    [ctf2 resignFirstResponder];
    [ctf3 resignFirstResponder];
    

    SM = [SingleManage shareManage];
 
    _OldPassWord = [NSString stringWithFormat:@"%@",ctf1.text];
    _NewPassWord = [NSString stringWithFormat:@"%@",ctf2.text];
    _AgainPassWord = [NSString stringWithFormat:@"%@",ctf3.text];
    

    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:_OldPassWord,@"oldpassword",_NewPassWord,@"newpassword",nil];
 
    if([_OldPassWord isEmpty]||[_NewPassWord isEmpty]||[_AgainPassWord isEmpty])
    {
        [HDHud showMessageInView:self.view title:@"密码不能为空"];
        
    }else if(![_OldPassWord isValidPassword]||![_NewPassWord isValidPassword]||![_AgainPassWord isValidPassword])
    {
        [HDHud showMessageInView:self.view title:@"密码格式错误"];
    }else if(![_OldPassWord isEqualToString:SM.passWord])
    {
        [HDHud showMessageInView:self.view title:@"老密码不正确"];
        
    }else if (![_NewPassWord isEqualToString:_AgainPassWord])
    {
        [HDHud showMessageInView:self.view title:@"新密码和确认密码不一致"];
    }else if ([_OldPassWord isValidPassword]&&[_NewPassWord isValidPassword]&&[_AgainPassWord isValidPassword]&&[_NewPassWord isEqualToString:_AgainPassWord]) {
        NSLog(@"changePassword");
        [HDHud showHUDInView:self.view title:@"修改中"];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_ChangePassWord pragma:postDict ImageData:nil];
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            _dict = [NSMutableDictionary dictionaryWithDictionary:obj];

            NSString * reason = [NSString stringWithFormat:@"%@",[_dict valueForKey:@"message"]];
            NSString * ok = [NSString stringWithFormat:@"%@",[_dict valueForKey:@"code"]];
            if ([ok isEqualToString:@"0"]) {
                NSLog(@"修改失败");
                [HDHud showMessageInView:self.view title:reason];
            }else if([ok isEqualToString:@"1"])
            {
                NSLog(@"修改成功");
                [HDHud showMessageInView:self.view title:@"修改成功"];
                
                [self performSelector:@selector(goLogin) withObject:nil afterDelay:1.5];                
                
            }
            
          
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
        
    
        
    }
    
    
}

-(void)goLogin
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_photo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"code"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_money"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_desc"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"baby_name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"baby_sex"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"baby_birthday"];
    
    
    SM = [SingleManage shareManage];
    SM.isLogin = NO;
    SM.userID = nil;
    SM.userName = nil;
    SM.nickName = nil;
    SM.birthday = nil;
    SM.imageURL = nil;
    SM.userSex = nil;
    SM.userToken = nil;
    SM.passWord = nil;
    SM.userMoney = nil;
    SM.userdesc = nil;
    SM.babySex = nil;
    SM.babyBirthday = nil;
    SM.babyName = nil;
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogout" object:@"logout"];
    
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-2] animated:YES];
}
//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initTableView];
    
}
-(void)initTableView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  BGColor;
        TableView.scrollEnabled = NO;
        [self.view addSubview:TableView];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 9.9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 20)];
        cellTitleLabel.backgroundColor = [UIColor clearColor];
        cellTitleLabel.font = [UIFont systemFontOfSize:14];
        cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        cellTitleLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:cellTitleLabel];
        
        
        
        cellTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(100, 12, SCREEN_WIDTH-120, 20)];
        cellTextField.textColor = [UIColor blackColor];
        cellTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        cellTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        cellTextField.keyboardType = UIKeyboardTypeDefault;
        cellTextField.returnKeyType = UIReturnKeyDefault;
        cellTextField.delegate = self;
        cellTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        cellTextField.tag = 1000+indexPath.row;
        cellTextField.placeholder = @"6-16位字符";
        cellTextField.secureTextEntry = YES;
        [cell.contentView addSubview:cellTextField];
        
    
        
        
    }
    switch (indexPath.row) {
        case 0:
        {
            cellTitleLabel.text = @"当前密码";

    
        }
            break;
            case 1:
        {
            cellTitleLabel.text = @"新密码";
        }
            break;
            case 2:
        {
            cellTitleLabel.text = @"确认密码";
        }
            break;
        default:
            break;
    }
    
    

    return cell;
}

//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [cellTextField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
}
#pragma tf delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [cellTextField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
    
    return YES;
}


@end
