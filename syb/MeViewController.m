//
//  MeViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "MyMessageViewController.h"
#import "UserInfoViewController.h"
#import "AccountViewController.h"
#import "ContactUsViewController.h"
#import "FeedBackViewController.h"
#import "SybWebViewController.h"
#import "MyIntegralViewController.h"
#import "MyAttentionViewController.h"
#import "MyOrderViewController.h"
#import "RegisterViewController.h"


@interface MeViewController ()

@end

@implementation MeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarHide:YES];
    [self setupDatas];
    [self setupViews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin:) name:@"userLogin" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout:) name:@"userLogout" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HiddenPoint:) name:@"HiddenPoint" object:nil];
    
}
-(void)setupDatas
{
    NSLog(@" update");
    [self stopLoadData];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:NO];
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getMessageData];
  

}
//没有新消息的方法
-(void)HiddenPoint:(NSNotification*)notification
{
    id obj = [notification object];
    NSLog(@"个人中心页面这个东西隐藏%@",obj);
    self.loginHeaderView.hiddenPoint = YES;
    
}

//请求新消息数据
-(void)getMessageData;
{ 

    if (userSession.isLogin) {
        GXHttpRequest *request = [[GXHttpRequest alloc]init];
        
        [request RequestDataWithUrl:URL_MyNewestMessage pragma:nil];
        
        [request getResultWithSuccess:^(id response) {
            /// 加保护
            if ([response isKindOfClass:[NSDictionary class]])
            {
                
                NSLog(@" 新消息接口 %@ ",response);
                
                NSDictionary * resultDict = [response valueForKey:@"result"];
                
                NSString * itemCount = [NSString stringWithFormat:@"%@",[resultDict valueForKey:@"item_count"]];
                
                
                if ([itemCount isEqualToString:@"0"]) {
                    self.loginHeaderView.hiddenPoint = YES;
                }else if ([itemCount isEqualToString:@"1"])
                {
                     self.loginHeaderView.hiddenPoint = NO;
                }
                
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

//用户登录后收到的通知的方法
-(void)userLogin:(NSNotification*)notification
{

    [self.logoutHeaderView removeFromSuperview];
    _TableView.tableHeaderView = self.loginHeaderView;
    
    
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    
    self.loginHeaderView.imageUrl = userSession.imageURL;
    self.loginHeaderView.nickName = userSession.nickName;
    
}
//用户登出后收到的通知的方法
-(void)userLogout:(NSNotification*)notification
{

    [self.logoutHeaderView removeFromSuperview];
    _TableView.tableHeaderView = self.logoutHeaderView;
    
}

-(void)setupViews
{
    
    [self.view addSubview:self.TableView];
}


//停止刷新
-(void)stopLoadData
{
    [HDHud hideHUDInView:self.view];
    [_TableView.mj_header endRefreshing];
    [_TableView.mj_footer endRefreshing];
}
-(MeHeaderLoginView*)loginHeaderView

{
    if (!_loginHeaderView) {
        _loginHeaderView = [[MeHeaderLoginView alloc]init];
        _loginHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, 144);
        _loginHeaderView.backgroundColor = ThemeColor;
        _loginHeaderView.delegate = self;
        
    }
    return _loginHeaderView;
}

-(void)MeHeaderClick
{
    UserInfoViewController * UserInfoVc = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:UserInfoVc animated:YES];
}
-(void)MeHeaderLoginViewMessageBtn:(UIButton *)messageBtn;
{

    MyMessageViewController * messageVc = [MyMessageViewController viewController];
    [self.navigationController pushViewController:messageVc animated:YES];
    

}
-(MeHeaderLogoutView*)logoutHeaderView
{
    if (!_logoutHeaderView) {
        _logoutHeaderView = [[MeHeaderLogoutView alloc]init];
        _logoutHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, 144);
        _logoutHeaderView.backgroundColor = ThemeColor;
        _logoutHeaderView.delegate= self;
        
        
    }
    return _logoutHeaderView;
}
-(void)MeHeaderLogoutViewLoginBtn:(UIButton *)loginBtn;
{
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)MeHeaderLogoutViewRegisterBtn:(UIButton *)registerBtn;
{
    RegisterViewController * registerVc = [RegisterViewController viewController];
    [self.navigationController pushViewController:registerVc animated:YES];
}
- (UITableView *)TableView
{
    if (!_TableView)
    {
        
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight-49) style:UITableViewStylePlain];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.scrollEnabled = YES;
        _TableView.backgroundColor = kDefaultBackgroundColor;
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
        if (!userSession) {
            userSession = [SybSession sharedSession];
        }
        
        if (userSession.isLogin) {
          
        
 
            self.loginHeaderView.imageUrl = userSession.imageURL;
            
            if (IS_EXIST_STR(userSession.nickName)) {
                self.loginHeaderView.nickName = userSession.nickName;
            }else
            {
               self.loginHeaderView.nickName = userSession.userName;
            }

            _TableView.tableHeaderView = self.loginHeaderView;
            
            
        }else
        {
            _TableView.tableHeaderView = self.logoutHeaderView;
        }
        
       
  
        
    }
    
    return _TableView;
}
#pragma TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 3;
    }else if (section==2)
    {
        return 4;
    }else
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 6.99;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cellImageView = [[UIImageView alloc]init];
        cellImageView.frame = CGRectMake(15, 10, 24, 24);
        [cell.contentView addSubview:cellImageView];
        
        cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(49, 12, 80, 20)];
        cellTitleLabel.backgroundColor = [UIColor clearColor];
        cellTitleLabel.font = [UIFont systemFontOfSize:14];
        cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        cellTitleLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:cellTitleLabel];
        
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor1"];
                    cellTitleLabel.text = @"我的积分";
                }
                    break;
                    case 1:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor2"];
                    cellTitleLabel.text = @"我的关注";
                }
                    break;
                    case 2:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor3"];
                    cellTitleLabel.text = @"我的订单";
                }
                    break;
                default:
                    break;
            }
           
        }
            break;
        case 1:
            
        {
            cellImageView.image = [UIImage imageNamed:@"floor4"];
            cellTitleLabel.text = @"账户与安全";
        }
            break;
        case 2:
            
        {
            switch (indexPath.row) {
                case 0:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor5"];
                    cellTitleLabel.text = @"意见反馈";
                }
                    break;
                case 1:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor6"];
                    cellTitleLabel.text = @"联系客服";
                }
                    break;
                case 2:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor7"];
                    cellTitleLabel.text = @"关于我们";
                    
                    
                }
                    break;
                case 3:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor8"];
                    cellTitleLabel.text = @"帮助中心";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            cellImageView.image = [UIImage imageNamed:@"floor9"];
            cellTitleLabel.text = @"清理缓存";
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cacheCount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100,12,65, 20)];
            cacheCount.backgroundColor = [UIColor clearColor];
            cacheCount.font = [UIFont systemFontOfSize:14.0];
            cacheCount.textColor = [UIColor grayColor];
            cacheCount.textAlignment = NSTextAlignmentRight;
            
            SDImageCache * sdIC = [[SDImageCache alloc]init];
            NSInteger count = [sdIC getSize];
            float count1 = count /(1024.0*1024.0);
            cacheCount.text = [NSString stringWithFormat:@"%.2fM",count1];
            
            [cell addSubview:cacheCount];
            
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if (userSession.isLogin) {
                        
                        MyIntegralViewController * inyrthtslVC = [[MyIntegralViewController alloc] initWithNibName:@"MyIntegralViewController" bundle:nil];
                        [self.navigationController pushViewController:inyrthtslVC animated:YES];
                        
                    }else if(!userSession.isLogin)
                    {
                        LoginViewController * loginVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:loginVC animated:YES];
                    }
                    
                }
                    break;
                    case 1:
                {
                    if (userSession.isLogin) {
                        
                        MyAttentionViewController * attentionVC = [[MyAttentionViewController alloc]init];
                        [self.navigationController pushViewController:attentionVC animated:YES];
                        
                    }else if(!userSession.isLogin)
                    {
                        LoginViewController * loginVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:loginVC animated:YES];
                    }
                    
                }
                    break;
                    case 2:
                {
                    if (userSession.isLogin) {
                        
                        MyOrderViewController * orderVC = [[MyOrderViewController alloc]init];
                        [self.navigationController pushViewController:orderVC animated:YES];
                        
                    }else if(!userSession.isLogin)
                    {
                        LoginViewController * loginVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:loginVC animated:YES];
                    }
                    
                }
                    break;
                default:
                    break;
            }
            
      
        }
            break;
        case 1:
        {
           if (userSession.isLogin) {
            
                AccountViewController * accountVC = [[AccountViewController alloc]init];
               [self.navigationController pushViewController:accountVC animated:YES];
            
           }else if(!userSession.isLogin)
            {
                LoginViewController * loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
          }
            
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if (userSession.isLogin) {
                        
                        FeedBackViewController * feedBackVC = [[FeedBackViewController alloc]init];
                        [self.navigationController pushViewController:feedBackVC animated:YES];
                        
                    }else if(!userSession.isLogin)
                    {
                        LoginViewController * loginVC = [[LoginViewController alloc]init];
                        [self.navigationController pushViewController:loginVC animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    ContactUsViewController * contactUSVc = [[ContactUsViewController alloc]init];
                    [self.navigationController pushViewController:contactUSVc animated:YES];
                }
                    break;
                case 2:
                {
            
                            NSString * url = @"http://static.spygmall.com/static/app/about.html";
                            SybWebViewController * webVC = [[SybWebViewController alloc]init];
                            
                            webVC.RequestUlr = url;
                            webVC.WebTitle = @"关于我们";
                            [self.navigationController pushViewController:webVC animated:YES];
       
            
                    
                }
                    break;
                case 3:
                {
                    
    
                      
                            NSString * url = @"http://static.spygmall.com/static/app/help_list.html";
          
                            SybWebViewController * webVC = [[SybWebViewController alloc]init];

                            webVC.RequestUlr = url;
                            webVC.WebTitle = @"帮助中心";
                            [self.navigationController pushViewController:webVC animated:YES];
                            

                    
              
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            SDImageCache * sdIC = [[SDImageCache alloc]init];
            [sdIC clearDisk];
            [sdIC clearMemory];
            [HDHud showMessageInView:self.view title:@"清除成功"];
            cacheCount.text = [NSString stringWithFormat:@"0.00M"];
            
        }
            break;
            
        default:
            break;
    }
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
