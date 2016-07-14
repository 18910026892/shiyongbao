//
//  MineViewController.m
//  syb
//
//  Created by GX on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "MyMessageViewController.h"
#import "AttentionShopsViewController.h"
#import "AccountViewController.h"
#import "ContactUsViewController.h"
#import "FeedBackViewController.h"
#import "WebViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self getMessageData];
    [self performSelector:@selector(StatusBarStyleChange) withObject:nil afterDelay:0.1];
    
    

    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@NO];
    

    
   [MobClick beginLogPageView:@"个人中心"];
    
}
-(void)StatusBarStyleChange
{
    NSLog(@"mine change");
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
//页面设置
-(void)PageSetup
{
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
   [MobClick endLogPageView:@"个人中心"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin:) name:@"userLogin" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout:) name:@"userLogout" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HiddenPoint:) name:@"HiddenPoint" object:nil];
    
    [self initTable];
    [self InitHeader];
    
    
}
//没有新消息的方法
-(void)HiddenPoint:(NSNotification*)notification
{
    id obj = [notification object];
    NSLog(@"个人中心页面这个东西隐藏%@",obj);
  
    pointImage.hidden = YES;
  
}

//请求新消息数据
-(void)getMessageData;
{
    SM = [SingleManage shareManage];
    if (SM.isLogin) {
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_MyNewestMessage pragma:nil ImageData:nil];
        
        request.successGetData = ^(id obj){
            NSLog(@"^^^^^^^^^^%@",obj);
            
            NSString * code = [obj valueForKey:@"code"];
            
            if ([code isEqualToString:@"0"]) {
                NSLog(@"....");
            }else if ([code isEqualToString:@"1"])
            {
                NSDictionary * messageDict = [obj valueForKey:@"result"];
                NSString * messageCount = [messageDict valueForKey:@"item_count"];
                if ([messageCount integerValue]>0) {
                    
                    if (pointImage) {
                        pointImage.hidden = NO;
                    }
                }else
                {
                    NSLog(@"没有新消息");
                }
                
                
            }
            
            
            
        };
        request.failureGetData = ^(void){
            
            
        };
    }else if(!SM.isLogin)
    {
        NSLog(@"不用查看");
    }
    
    
    

}

//用户登录后收到的通知的方法
-(void)userLogin:(NSNotification*)notification
{
    id obj = [notification object];
    NSLog(@"obj==%@",obj);
    
    //头像视图
    userPhotoImg = [[UIImageView alloc]init];
    userPhotoImg.frame = CGRectMake(20, 61.5, 65, 65);
    userPhotoImg.layer.cornerRadius = 32.5;
    userPhotoImg.layer.borderColor = [UIColor whiteColor].CGColor;
    userPhotoImg.layer.borderWidth = 1;
    userPhotoImg.layer.masksToBounds = YES;
    NSString * photoImage = [NSString stringWithFormat:@"%@",SM.imageURL];
    NSURL * userimg = [NSURL URLWithString:photoImage];
    [userPhotoImg sd_setImageWithURL:userimg placeholderImage:[UIImage imageNamed:@"face"]];
    userPhotoImg.userInteractionEnabled = YES;
    
 
     SM = [SingleManage shareManage];
    
    //用户昵称
    
    userNickNameLabel = [[UILabel alloc]init];
    userNickNameLabel.frame = CGRectMake(VIEW_MAXX(userPhotoImg)+10, 69, 160*Proportion, 20);;
    if ([SM.nickName isEmpty]) {
         userNickNameLabel.text = SM.userName;
    }else
    {
         userNickNameLabel.text = SM.nickName;
    }

    userNickNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    userNickNameLabel.backgroundColor = [UIColor clearColor];
    userNickNameLabel.textColor = [UIColor whiteColor];
    userNickNameLabel.textAlignment = NSTextAlignmentLeft;
    userNickNameLabel.userInteractionEnabled = YES;
    
    babyNameLabel = [[UILabel alloc]init];
    babyNameLabel.frame = CGRectMake(VIEW_MAXX(userPhotoImg)+10,94, 160*Proportion, 20);;
    babyNameLabel.text = SM.babyName;
    babyNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    babyNameLabel.backgroundColor = [UIColor clearColor];
    babyNameLabel.textColor = [UIColor whiteColor];
    babyNameLabel.textAlignment = NSTextAlignmentLeft;
    babyNameLabel.userInteractionEnabled = YES;
    

    UIImage * messageImage = [UIImage imageNamed:@"message_white"];
    messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
    [messageButton setImage:messageImage forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!pointImage) {
        pointImage = [[UIImageView alloc]init];
        pointImage.backgroundColor = [UIColor whiteColor];
        pointImage.layer.cornerRadius = 4.5;
        pointImage.frame = CGRectMake(SCREEN_WIDTH-16,30, 9, 9);
        pointImage.hidden = YES;
        
    }
 
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
    singleRecognizer.numberOfTapsRequired = 1;
    
    
    HeaderView = [[UIImageView alloc]init];
    HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
    HeaderView.backgroundColor = ThemeColor;
    HeaderView.layer.masksToBounds = YES;
    HeaderView.userInteractionEnabled = YES;
    [HeaderView addGestureRecognizer:singleRecognizer];
    
    
    
    [HeaderView addSubview:userPhotoImg];
    [HeaderView addSubview:userNickNameLabel];
    [HeaderView addSubview:babyNameLabel];
    [HeaderView addSubview:messageButton];
    [HeaderView addSubview:pointImage];
    [table setParallaxHeaderView:HeaderView
                            mode:VGParallaxHeaderModeFill
                          height:144];

    
    [table reloadData];
}
//用户登出后收到的通知的方法
-(void)userLogout:(NSNotification*)notification
{
    id obj = [notification object];
     NSLog(@"走没走登出的方法obj==%@",obj);
    
    //提示登录的图片
    
    LoginImage = [[UIImageView alloc]init];
    LoginImage.frame = CGRectMake(SCREEN_WIDTH/2-32.5, 35, 65, 65);
    LoginImage.layer.cornerRadius = 32.5;
    LoginImage.layer.borderColor = [UIColor whiteColor].CGColor;
    LoginImage.layer.borderWidth = 1;
    LoginImage.layer.masksToBounds = YES;
    LoginImage.image = [UIImage imageNamed:@"face"];
    LoginImage.userInteractionEnabled = YES;
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginClick:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [LoginImage addGestureRecognizer:singleRecognizer];
    
    
    
    
    //提示登录的图片
    
    LoginLabel = [[UILabel alloc]init];
    LoginLabel.frame = CGRectMake(SCREEN_WIDTH/2-40,114, 80, 20);;
    LoginLabel.text = [NSString stringWithFormat:@"请点击登录"];
    LoginLabel.font = [UIFont boldSystemFontOfSize:16.0];
    LoginLabel.backgroundColor = [UIColor clearColor];
    LoginLabel.textColor = [UIColor whiteColor];
    LoginLabel.textAlignment = NSTextAlignmentCenter;
    LoginLabel.userInteractionEnabled = YES;
    
    UIImage * messageImage = [UIImage imageNamed:@"message_white"];
    messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
    [messageButton setImage:messageImage forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    
    HeaderView = [[UIImageView alloc]init];
    HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
    HeaderView.userInteractionEnabled = YES;
    HeaderView.backgroundColor = ThemeColor;
    HeaderView.layer.masksToBounds = YES;
    
    [HeaderView addSubview:LoginImage];
    [HeaderView addSubview:LoginLabel];
    [HeaderView addSubview:messageButton];
    
    
    [table setParallaxHeaderView:HeaderView
                            mode:VGParallaxHeaderModeFill
                          height:144];

    [table reloadData];
}



-(void)InitHeader
{
    SM = [SingleManage shareManage];
    if (SM.isLogin)
    {
        //头像视图
        userPhotoImg = [[UIImageView alloc]init];
        userPhotoImg.frame = CGRectMake(20, 61.5, 65, 65);
        userPhotoImg.layer.cornerRadius = 32.5;
        userPhotoImg.layer.borderColor = [UIColor whiteColor].CGColor;
        userPhotoImg.layer.borderWidth = 1;
        userPhotoImg.layer.masksToBounds = YES;
        NSString * photoImage = [NSString stringWithFormat:@"%@",SM.imageURL];
        NSURL * userimg = [NSURL URLWithString:photoImage];
        [userPhotoImg sd_setImageWithURL:userimg placeholderImage:[UIImage imageNamed:@"face"]];
        userPhotoImg.userInteractionEnabled = YES;
        
      
        
        
        //用户昵称
        
        userNickNameLabel = [[UILabel alloc]init];
        userNickNameLabel.frame = CGRectMake(VIEW_MAXX(userPhotoImg)+10, 69, 160*Proportion, 20);;
        if ([SM.nickName isEmpty]) {
            userNickNameLabel.text = SM.userName;
        }else
        {
            userNickNameLabel.text = SM.nickName;
        }
        userNickNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
        userNickNameLabel.backgroundColor = [UIColor clearColor];
        userNickNameLabel.textColor = [UIColor whiteColor];
        userNickNameLabel.textAlignment = NSTextAlignmentLeft;
        userNickNameLabel.userInteractionEnabled = YES;
        
        
        babyNameLabel = [[UILabel alloc]init];
        babyNameLabel.frame = CGRectMake(VIEW_MAXX(userPhotoImg)+10,94, 160*Proportion, 20);;
        babyNameLabel.text = SM.babyName;
        babyNameLabel.font = [UIFont boldSystemFontOfSize:17.0];
        babyNameLabel.backgroundColor = [UIColor clearColor];
        babyNameLabel.textColor = [UIColor whiteColor];
        babyNameLabel.textAlignment = NSTextAlignmentLeft;
        babyNameLabel.userInteractionEnabled = YES;
        
        
        UIImage * messageImage = [UIImage imageNamed:@"message_white"];
        messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
        [messageButton setImage:messageImage forState:UIControlStateNormal];
        [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!pointImage) {
            pointImage = [[UIImageView alloc]init];
            pointImage.backgroundColor = [UIColor whiteColor];
            pointImage.layer.cornerRadius = 4.5;
            pointImage.frame = CGRectMake(SCREEN_WIDTH-16, 30, 9, 9);
            pointImage.hidden = YES;
            
        }
        

        
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
        singleRecognizer.numberOfTapsRequired = 1;
        

        HeaderView = [[UIImageView alloc]init];
        HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
        HeaderView.userInteractionEnabled = YES;
        HeaderView.backgroundColor = ThemeColor;
        HeaderView.layer.masksToBounds = YES;
        // 单击的 Recognizer
        [HeaderView addGestureRecognizer:singleRecognizer];
        
        
        [HeaderView addSubview:userPhotoImg];
        [HeaderView addSubview:userNickNameLabel];
        [HeaderView addSubview:babyNameLabel];
        [HeaderView addSubview:messageButton];
        [HeaderView addSubview:pointImage]; 
        [table setParallaxHeaderView:HeaderView
                                         mode:VGParallaxHeaderModeFill
                                       height:144];
        

        
    }else if (!SM.isLogin) {
        
        //提示登录的图片
        
        LoginImage = [[UIImageView alloc]init];
        LoginImage.frame = CGRectMake(SCREEN_WIDTH/2-32.5, 35, 65, 65);
        LoginImage.layer.cornerRadius = 32.5;
        LoginImage.layer.borderColor = [UIColor whiteColor].CGColor;
        LoginImage.layer.borderWidth = 1;
        LoginImage.layer.masksToBounds = YES;
        LoginImage.image = [UIImage imageNamed:@"face"];
        LoginImage.userInteractionEnabled = YES;
        
        // 单击的 Recognizer
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginClick:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [LoginImage addGestureRecognizer:singleRecognizer];
        
        
        //提示登录的图片
        
        LoginLabel = [[UILabel alloc]init];
        LoginLabel.frame = CGRectMake(SCREEN_WIDTH/2-40,114, 80, 20);;
        LoginLabel.text = [NSString stringWithFormat:@"请点击登录"];
        LoginLabel.font = [UIFont boldSystemFontOfSize:16.0];
        LoginLabel.backgroundColor = [UIColor clearColor];
        LoginLabel.textColor = [UIColor whiteColor];
        LoginLabel.textAlignment = NSTextAlignmentCenter;
        LoginLabel.userInteractionEnabled = YES;
        
        UIImage * messageImage = [UIImage imageNamed:@"message_white"];
        messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
        [messageButton setImage:messageImage forState:UIControlStateNormal];
        [messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        HeaderView = [[UIImageView alloc]init];
        HeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
        HeaderView.userInteractionEnabled = YES;
        HeaderView.backgroundColor = ThemeColor;
        HeaderView.layer.masksToBounds = YES;
        
        
        [HeaderView addSubview:LoginImage];
        [HeaderView addSubview:LoginLabel];
        [HeaderView addSubview:messageButton];
        
        
        [table setParallaxHeaderView:HeaderView
                                mode:VGParallaxHeaderModeFill
                              height:144];
    }
    
  
  
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [table shouldPositionParallaxHeader];
    
    // Log Parallax Progress
    //NSLog(@"Progress: %f", scrollView.parallaxHeader.progress);
}
//初始化表格视图
-(void)initTable
{
    if(!table)
    {
        table = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = [UIColor clearColor];
        table.scrollEnabled = YES;
        [self.view addSubview:table];
    }
 
}
//Table Delegate;

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
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==2) {
        return 4;
    }
    return 1;
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
            cellImageView.image = [UIImage imageNamed:@"floor1"];
            cellTitleLabel.text = @"关注的店铺";
        }
            break;
            case 1:
            
        {
             cellImageView.image = [UIImage imageNamed:@"floor2"];
            cellTitleLabel.text = @"账户与安全";
        }
            break;
            case 2:
            
        {
            switch (indexPath.row) {
                case 0:
                {
                     cellImageView.image = [UIImage imageNamed:@"floor3"];
                    cellTitleLabel.text = @"意见反馈";
                }
                    break;
                    case 1:
                {
                     cellImageView.image = [UIImage imageNamed:@"floor4"];
                    cellTitleLabel.text = @"联系客服";
                }
                    break;
                    case 2:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor5"];
                    cellTitleLabel.text = @"关于我们";
                    
                  
                }
                    break;
                    case 3:
                {
                    cellImageView.image = [UIImage imageNamed:@"floor6"];
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
            cellImageView.image = [UIImage imageNamed:@"floor7"];
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
    SM = [SingleManage shareManage];
    
    switch (indexPath.section) {
        case 0:
        {
            if (SM.isLogin) {
                
                AttentionShopsViewController * attentionShopsVc = [[AttentionShopsViewController alloc]init];
                [self.navigationController pushViewController:attentionShopsVc animated:YES];
                
            }else if(!SM.isLogin)
            {
                LoginViewController * loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
            break;
            case 1:
        {
            if (SM.isLogin) {
                
                AccountViewController * accountVC = [[AccountViewController alloc]init];
                [self.navigationController pushViewController:accountVC animated:YES];
                
            }else if(!SM.isLogin)
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
                    if (SM.isLogin) {
                        
                        FeedBackViewController * feedBackVC = [[FeedBackViewController alloc]init];
                        [self.navigationController pushViewController:feedBackVC animated:YES];
                        
                    }else if(!SM.isLogin)
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
                { GXHttpRequest * request = [[GXHttpRequest alloc]init];
                    [request StartWorkPostWithurlstr:URL_SysHtmlInfo pragma:nil ImageData:nil];
                    
                    request.successGetData = ^(id obj){
                        
                        
                        NSArray * urlArray = [obj valueForKey:@"result"];
                        
                        NSString * url;
                        for (NSDictionary * dict in urlArray) {
                            NSString * key = @"url_key";
                            if ([[dict valueForKey:key] isEqualToString:@"sys_about"]) {
                                url = [dict valueForKey:@"url_link"];
                            }
                        }
                        
                        WebViewController * webVC = [[WebViewController alloc]init];
                        webVC.webViewType = WebViewTypeNormal;
                        webVC.requestURL = url;
                        webVC.webTitle = @"关于我们";
                        [self.navigationController pushViewController:webVC animated:YES];
                        
                        
                        
                    };
                    request.failureGetData = ^(void){
                        
                        
                    };
                    
                }
                    break;
                    case 3:
                {
                    GXHttpRequest * request = [[GXHttpRequest alloc]init];
                    [request StartWorkPostWithurlstr:URL_SysHtmlInfo pragma:nil ImageData:nil];
                    
                    request.successGetData = ^(id obj){
                        
                        
                        NSArray * urlArray = [obj valueForKey:@"result"];
                        
                        NSString * url;
                        for (NSDictionary * dict in urlArray) {
                            NSString * key = @"url_key";
                            if ([[dict valueForKey:key] isEqualToString:@"sys_help"]) {
                                url = [dict valueForKey:@"url_link"];
                            }
                        }
                        
                        WebViewController * webVC = [[WebViewController alloc]init];
                        webVC.webViewType = WebViewTypeNormal;
                        webVC.requestURL = url;
                        webVC.webTitle = @"帮助中心";
                        [self.navigationController pushViewController:webVC animated:YES];
                        
                        
                        
                    };
                    request.failureGetData = ^(void){
                        
                        
                    };
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
-(void)headerClick:(id)sender;
{
    NSLog(@"UserInfoChange");
    if (SM.isLogin) {
        
        UserInfoViewController * UserInfoVc = [[UserInfoViewController alloc]init];
        [self.navigationController pushViewController:UserInfoVc animated:YES];
    
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
   
}
-(void)shopsClick:(UIButton*)sender;
{
    NSLog(@"shops");
    if (SM.isLogin) {
        AttentionShopsViewController * attentionShopsVC = [[AttentionShopsViewController alloc]init];
        [self.navigationController pushViewController:attentionShopsVC animated:YES];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

-(void)messageClick:(UIButton*)sender
{
    if (SM.isLogin) {
        MyMessageViewController * myMessageVc = [[MyMessageViewController alloc]init];
        [self.navigationController pushViewController:myMessageVc animated:YES];
        
    }else if(!SM.isLogin)
    {
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

-(void)LoginClick:(id)sender;
{
    NSLog(@"Login");
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
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
