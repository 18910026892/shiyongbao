//
//  BalanceOfPaymentsViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BalanceOfPaymentsViewController.h"
#import "BalanceOfPaymentTableViewCell.h"
@interface BalanceOfPaymentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineCenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation BalanceOfPaymentsViewController
{
    SybSession *user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton:YES];
    user = [SybSession sharedSession];
    [self setNavTitle:@"收支明细"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
#pragma mark - btnCLick
- (IBAction)incomeDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    
    self.payBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)payDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    
    self.incomeBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = self.payBtn.center.x-self.incomeBtn.center.x;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - end btnCLick


#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BalanceOfPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceOfPaymentTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BalanceOfPaymentTableViewCell" owner:nil options:nil] lastObject];
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
