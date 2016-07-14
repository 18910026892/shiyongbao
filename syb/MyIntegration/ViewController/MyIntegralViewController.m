
//
//  MyIntegralViewController.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "BalanceOfPaymentsViewController.h"
#import "CashingViewController.h"
#import <UIImageView+WebCache.h>
#import "SybSession.h"
@interface MyIntegralViewController()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *userIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *lineHeights;

@end
@implementation MyIntegralViewController
{
    SybSession *user;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    [MobClick beginLogPageView:@"我的积分"];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"我的积分"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的积分"];
    [self showBackButton:YES];
    user = [SybSession sharedSession];
    
    [self.RightBtn addTarget:self action:@selector(toBalanceVC:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setUpUI];
}
- (void)setUpUI
{
    self.contentViewWidth.constant = [UIScreen mainScreen].bounds.size.width;
    // Do any additional setup after loading the view.
    self.Customview.backgroundColor = [UIColor clearColor];
    [self.RightBtn setTitle:@"收支明细" forState:UIControlStateNormal];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*********用户头像**********/
    self.userIV.cornerRadius = self.userIV.height/2;
    [self.userIV sd_setImageWithURL:[NSURL URLWithString:user.imageURL] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.userName.text = user.userName;
    
    [self.lineHeights setValue:@0.5 forKey:@"constant"];
    [self.contentView sizeToFit];
    
}
#pragma mark - btnAction
- (IBAction)cash:(UIButton *)sender
{
    CashingViewController *pushVC = [[CashingViewController alloc] initWithNibName:@"CashingViewController" bundle:nil];
    [self.navigationController pushViewController:pushVC animated:YES];
}
- (IBAction)payTheTelephone:(UIButton *)sender
{
    
}
- (IBAction)payTheGasoline:(UIButton *)sender
{
    
}

-(void)toBalanceVC:(UIButton *)sender
{
    BalanceOfPaymentsViewController *pushVC = [[BalanceOfPaymentsViewController alloc] initWithNibName:@"BalanceOfPaymentsViewController" bundle:nil];
    [self.navigationController pushViewController:pushVC animated:YES];
}
#pragma mark - end btnAction
@end
