//
//  CashingViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "CashingViewController.h"
#import "AddAccountViewController.h"


@interface CashingViewController ()
@property (weak, nonatomic) IBOutlet UIView *topMiddleLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMiddleLineHeight;
@property (weak, nonatomic) IBOutlet UITextField *integralTextFild;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLineCenter;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)AccountType accountType;
@end

@implementation CashingViewController
{
    SybSession *user;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton:YES];
    user = [SybSession sharedSession];
    [self setNavTitle:@"兑现"];
    self.cashBtn.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
    self.accountType = zhifubaoType;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
}
#pragma mark - btnClick
- (IBAction)zhifubaoDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    
    self.bankBtn.selected = NO;
    sender.selected = YES;
    self.middleLineCenter.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.accountType = zhifubaoType;
}
- (IBAction)bankDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    
    self.zhifubaoBtn.selected = NO;
    sender.selected = YES;
    self.middleLineCenter.constant = self.bankBtn.center.x-self.zhifubaoBtn.center.x;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.accountType = bankType;
}
- (IBAction)addAccount:(UIButton *)sender
{
    AddAccountViewController *pushVC = [[AddAccountViewController alloc] initWithNibName:@"AddAccountViewController" bundle:nil];
    pushVC.bandingType = self.accountType;
    [self.navigationController pushViewController:pushVC animated:YES];
}
#pragma mark - end btnClick

#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AccountCell"];
    }
    cell.textLabel.text = @"哈哈哈哈哈哈";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - end tableViewDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
