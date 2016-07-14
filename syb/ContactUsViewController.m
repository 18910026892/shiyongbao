//
//  ContactUsViewController.m
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "ContactUsViewController.h"

@implementation ContactUsViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"联系客服";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initBackButton];
     [MobClick beginLogPageView:@"联系客服"];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [MobClick endLogPageView:@"联系客服"];
  
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

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self initAlertLabel];
}
-(void)initAlertLabel
{
    if (!AlertLabel)
    {
        AlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 25, SCREEN_WIDTH, 20)];
        AlertLabel.backgroundColor = [UIColor clearColor];
        AlertLabel.textAlignment = NSTextAlignmentCenter;
        AlertLabel.textColor = [UIColor blackColor];
        AlertLabel.font = [UIFont systemFontOfSize:13];
        AlertLabel.text = @"工作时间  周一到周五 8：30--17：30";
    }
    [self.view addSubview:AlertLabel];
}
-(void)initTableView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, 120) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor = [UIColor clearColor];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        
        cellImageView = [[UIImageView alloc]init];
        cellImageView.frame = CGRectMake(15, 10, 24, 24);
        [cell.contentView addSubview:cellImageView];
        
        cellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(49, 12, 80, 20)];
        cellTitleLabel.backgroundColor = [UIColor clearColor];
        cellTitleLabel.font = [UIFont systemFontOfSize:14];
        cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        cellTitleLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:cellTitleLabel];
        
        cellContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160,12,150, 20)];
        cellContentLabel.backgroundColor = [UIColor clearColor];
        cellContentLabel.font = [UIFont systemFontOfSize:13.0];
        cellContentLabel.textColor = [UIColor grayColor];
        cellContentLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:cellContentLabel];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cellImageView.image = [UIImage imageNamed:@"message"];
            cellTitleLabel.text = @"在线客服";
            cellContentLabel.text = @"在线即时为您解决问题";
      
        }
            break;
            case 1:
        {
             cellImageView.image = [UIImage imageNamed:@"phone"];
            cellTitleLabel.text = @"官方电话";
            cellContentLabel.text = @"400-1858-600";
        
        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSURL *requestURL =  [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2750469277&version=1&src_type=web"];
            [[UIApplication sharedApplication] openURL: requestURL];
        }
            break;
            case 1:
        {
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-1858-600"]];
        }
            break;
        default:
            break;
    }
}
@end
