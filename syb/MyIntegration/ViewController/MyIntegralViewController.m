
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
#import "PayTheGasolineViewController.h"
#import <UIImageView+WebCache.h>
#import "SybSession.h"
#import "MobilePhoneRechargeViewController.h"
@interface MyIntegralViewController()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *userIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *lineHeights;
@property (nonatomic,copy)NSString *myIntegral;
@property (strong,nonatomic) NSArray *category;
@end
@implementation MyIntegralViewController
{
    SybSession *user;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestMyIntegral];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavTitle:@"我的积分"];
    [self showBackButton:YES];
    self.myIntegral = @"0";
    [self.LeftBtn setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    user = [SybSession sharedSession];
    [self.RightBtn addTarget:self action:@selector(toBalanceVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self requestCategory];
}
- (void)requestMyIntegral
{
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"user_id",user.userID,nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetUserIntegral pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            NSLog(@" %@",response);
            
            NSDictionary *userInfo = [response objectForKey:@"result"];
            self.scoreLabel.text = [NSString stringWithFormat:@"%@积分",[userInfo valueForKey:@"point_num"]];
            self.myIntegral = [NSString stringWithFormat:@"%@",[userInfo valueForKey:@"point_num"]];
            [[NSUserDefaults standardUserDefaults] setObject:[userInfo valueForKey:@"point_num"] forKey:@"GetMyInteral"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } DataFaiure:^(id error) {
        self.scoreLabel.text = [NSString stringWithFormat:@"0积分"];
    } Failure:^(id error) {
        self.scoreLabel.text = [NSString stringWithFormat:@"0积分"];
    }];
}

- (void)requestCategory
{
//    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"user_id",user.userID,nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetGiftCategory pragma:@{}];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                self.category = [response objectForKey:@"result"];
            }
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];

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
//
    [self.RightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    if (self.category.count<3) {
        return;
    }
    CashingViewController *pushVC = [[CashingViewController alloc] initWithNibName:@"CashingViewController" bundle:nil];
    pushVC.gift_cate_id = [self.category[0] objectForKey:@"gift_cat_id"];
    [self.navigationController pushViewController:pushVC animated:YES];
}
- (IBAction)payTheTelephone:(UIButton *)sender
{
    if (self.category.count<3) {
        return;
    }
    MobilePhoneRechargeViewController *pushVC = [[MobilePhoneRechargeViewController alloc] initWithNibName:@"MobilePhoneRechargeViewController" bundle:nil];
    pushVC.gift_cate_id = [self.category[1] objectForKey:@"gift_cat_id"];
    [self.navigationController pushViewController:pushVC animated:YES];
}
- (IBAction)payTheGasoline:(UIButton *)sender
{
    if (self.category.count<3) {
        return;
    }
    PayTheGasolineViewController *pushVC = [[PayTheGasolineViewController alloc] initWithNibName:@"PayTheGasolineViewController" bundle:nil];
    pushVC.gift_cate_id = [self.category[2] objectForKey:@"gift_cat_id"];
    [self.navigationController pushViewController:pushVC animated:YES];
}

-(void)toBalanceVC:(UIButton *)sender
{
    BalanceOfPaymentsViewController *pushVC = [[BalanceOfPaymentsViewController alloc] initWithNibName:@"BalanceOfPaymentsViewController" bundle:nil];
    [self.navigationController pushViewController:pushVC animated:YES];
}
#pragma mark - end btnAction
@end
