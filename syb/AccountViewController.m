//
//  AccountViewController.m
//  syb
//
//  Created by GX on 15/10/26.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "AccountViewController.h"
#import "ChangePassWordViewController.h"
@implementation AccountViewController
- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [MobClick beginLogPageView:@"账户与安全"];
        [self setTabBarHide:YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"账户与安全"];

}



-(void)viewDidLoad
{
    [super viewDidLoad];
    [self InitTabelView];
    [self InitLogoutButton];
    
    [self setNavTitle:@"账户与安全"];
    [self showBackButton:YES];
}

-(void)InitLogoutButton
{
    if (!LogoutButton) {
        LogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        LogoutButton.frame = CGRectMake(20,VIEW_MAXY(TableView), WIDTH_VIEW(self.view)-40, 40);
        LogoutButton.layer.cornerRadius = 5;
        LogoutButton.backgroundColor = ThemeColor;
        [LogoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [LogoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        LogoutButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [LogoutButton addTarget:self action:@selector(LogoutClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:LogoutButton];
    }
    
}
-(void)InitTabelView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, 188) style:UITableViewStyleGrouped];
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
    return 3;
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
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cellImageView.hidden = YES;
        
            cellTitleLabel.frame = CGRectMake(24, 12, 200, 20);
            cellTitleLabel.text = [NSString stringWithFormat:@"账号:%@",userSession.userName];
        }
            break;
            case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cellImageView.hidden = YES;
            
            cellTitleLabel.frame = CGRectMake(24, 12, 200, 20);
            cellTitleLabel.text = [NSString stringWithFormat:@"邀请码:%@",userSession.code];
        }
            break;
            case 2:
        {
            
             cellImageView.image = [UIImage imageNamed:@"changepassword"];            
              cellTitleLabel.text = @"修改密码";
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2)
    {
        ChangePassWordViewController * ChangePassWordVc = [[ChangePassWordViewController alloc]init];
        [self.navigationController pushViewController:ChangePassWordVc animated:YES];
    }
 
}
-(void)LogoutClick:(UIButton*)sender
{
    if (!userSession) {
        userSession = [SybSession sharedSession];
    }
    
    [userSession removeUserInfo];
  
        
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogout" object:@"logout"];
  
    
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
 
}

@end
