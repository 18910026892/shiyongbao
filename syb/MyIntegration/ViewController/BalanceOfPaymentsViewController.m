//
//  BalanceOfPaymentsViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BalanceOfPaymentsViewController.h"
#import "BalanceOfPaymentTableViewCell.h"
#import "BalanceOfPaymentModel.h"
@interface BalanceOfPaymentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineCenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (nonatomic,assign)int infoFlag;//1-收入 2-支出
@property (nonatomic,assign)int pageNum;
@property (nonatomic,strong)NSMutableArray *incomes;
@property (nonatomic,strong)NSMutableArray *payments;

@end

@implementation BalanceOfPaymentsViewController
{
    SybSession *user;
}
-(int)infoFlag
{
    if (!_infoFlag) {
        _infoFlag = 1;
    }
    return _infoFlag;
}
-(NSMutableArray *)incomes
{
    if (!_incomes) {
        _incomes = [NSMutableArray array];
    }
    return _incomes;
}
-(NSMutableArray *)payments
{
    if (!_payments) {
        _payments = [NSMutableArray array];
    }
    return _payments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBackButton:YES];
    user = [SybSession sharedSession];
    [self setNavTitle:@"收支明细"];
    // Do any additional setup after loading the view from its nib.
    [self addRefresh];
}

- (void)addRefresh
{
    MJWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        if (self.infoFlag==1) {
            [self.incomes removeAllObjects];
        }else if (self.infoFlag==2){
            [self.payments removeAllObjects];
        }
        [weakSelf requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}
- (void)requestData
{
    NSString *point_type = [NSString stringWithFormat:@"%d",self.infoFlag];
    NSDictionary *postDict = @{@"user_id":user.userID,@"point_type":point_type,@"page":@(self.pageNum),@"num":@"10"};
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetUserPointRecord pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        self.pageNum++;
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                 NSArray *datas = [response objectForKey:@"result"];
                NSArray *models = [BalanceOfPaymentModel arrayWithArrays:datas];
                if (self.infoFlag==1) {
                    [self.incomes addObjectsFromArray:models];
                }else if (self.infoFlag==2){
                    [self.payments addObjectsFromArray:models];
                }
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } DataFaiure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } Failure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];

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
    self.infoFlag = 1;
    self.payBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (IBAction)payDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    self.infoFlag = 2;
    self.incomeBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = self.payBtn.center.x-self.incomeBtn.center.x;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - end btnCLick


#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BalanceOfPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceOfPaymentTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BalanceOfPaymentTableViewCell" owner:nil options:nil] lastObject];
    }
    if (self.infoFlag==1) {
        cell.data = self.incomes[indexPath.row];
    }else if(self.infoFlag==2){
        cell.data = self.payments[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.infoFlag==1) {
        return self.incomes.count;
    }else return self.payments.count;
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
