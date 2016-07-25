//
//  CashingViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/14.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "CashingViewController.h"
#import "AddAccountViewController.h"
#import "CashingTableViewCell.h"

@interface CashingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topMiddleLine;
@property (weak, nonatomic) IBOutlet UILabel *interalLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMiddleLineHeight;
@property (weak, nonatomic) IBOutlet UITextField *integralTextFild;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLineCenter;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)AccountType accountType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

@property (nonatomic,strong)NSMutableArray *zhifubaoAccounts;
@property (nonatomic,strong)NSMutableArray *bankAccounts;

@property (nonatomic,assign)NSInteger selectRow;
@property (nonatomic,copy)NSString *gift_id;
@property (nonatomic,copy)NSString *accountNumber;
@end

@implementation CashingViewController
{
    SybSession *user;
}

-(NSMutableArray *)zhifubaoAccounts
{
    if (!_zhifubaoAccounts) {
        _zhifubaoAccounts = [NSMutableArray array];
    }
    return _zhifubaoAccounts;
}
-(NSMutableArray *)bankAccounts
{
    if (!_bankAccounts) {
        _bankAccounts = [NSMutableArray array];
    }
    return _bankAccounts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interalLabel.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"GetMyInteral"]];
    self.bottomLineHeight.constant = 0.5;
    [self showBackButton:YES];
    self.selectRow = -1;
    user = [SybSession sharedSession];
    [self setNavTitle:@"兑现"];
    self.cashBtn.cornerRadius = 5;
    self.cashBtn.backgroundColor = ThemeColor;
    // Do any additional setup after loading the view from its nib.
    self.accountType = zhifubaoType;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
    [self requestData];
    [self requestMyIntegral];
    [self requestCategroies];
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
            self.interalLabel.text = [NSString stringWithFormat:@"%@",[userInfo valueForKey:@"point_num"]];
            [[NSUserDefaults standardUserDefaults] setObject:[userInfo valueForKey:@"point_num"] forKey:@"GetMyInteral"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
}
- (void)requestData
{
    NSDictionary *postDict = @{@"user_id":user.userID,@"type":@(self.accountType)};
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetUserAccountInfo pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                if (self.accountType==zhifubaoType) {
                    [self.zhifubaoAccounts removeAllObjects];
                    NSArray *result = [response objectForKey:@"result"];
                    [self.zhifubaoAccounts addObjectsFromArray:result];
                }else{
                    [self.bankAccounts removeAllObjects];
                    NSArray *result = [response objectForKey:@"result"];
                    [self.bankAccounts addObjectsFromArray:result];
                }
                [self.tableView reloadData];
            }
        }
        
    } DataFaiure:^(id error) {
        //加载框消失
        [HDHud showMessageInView:self.view title:error];
        
    } Failure:^(id error) {
        //加载框消失
        [HDHud showMessageInView:self.view title:error];
        
    }];

}

- (void)requestCategroies
{
    //        NSDictionary *postDict = @{@"gift_cat_id":self.gift_cate_id,@"gift_type":@"zsy"};
    NSDictionary *postDict = @{@"gift_cat_id":self.gift_cate_id};
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetGiftList pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
        NSLog(@"%@",response);
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                NSArray *result = [response objectForKey:@"result"];
                if (result.count>0) {
                    NSDictionary *dic = result[0];
                    self.gift_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gift_id"]];
                }
            }
        }
    } DataFaiure:^(id error) {
        
        
    } Failure:^(id error) {
        
    }];
}
#pragma mark - btnClick
- (IBAction)zhifubaoDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    self.selectRow = -1;
    self.bankBtn.selected = NO;
    sender.selected = YES;
    self.middleLineCenter.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.accountType = zhifubaoType;
    [self requestData];
    [self.tableView reloadData];
}
- (IBAction)bankDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    self.selectRow = -1;
    self.zhifubaoBtn.selected = NO;
    sender.selected = YES;
    self.middleLineCenter.constant = self.bankBtn.center.x-self.zhifubaoBtn.center.x;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.accountType = bankType;
    [self requestData];
    [self.tableView reloadData];
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
    CashingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashingTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CashingTableViewCell" owner:nil options:nil] lastObject];
    }
    NSDictionary *accountInfo = nil;
    if (self.accountType==zhifubaoType) {
        accountInfo = self.zhifubaoAccounts[indexPath.row];
    }else if(self.accountType==bankType){
        accountInfo = self.bankAccounts[indexPath.row];
    }
    cell.accountInfo = accountInfo;
    cell.isSelected = indexPath.row==self.selectRow?YES:NO;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.accountType==1) {
        return self.zhifubaoAccounts.count;
    }else return self.bankAccounts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectRow = indexPath.row;
    NSDictionary *accountInfo = nil;
    if (self.accountType==zhifubaoType) {
        accountInfo = self.zhifubaoAccounts[indexPath.row];
    }else if(self.accountType==bankType){
        accountInfo = self.bankAccounts[indexPath.row];
    }
    NSDictionary *infoDic = [accountInfo objectForKey:@"binding_info"];
    self.accountNumber = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"account"]];
    [self.tableView reloadData];
}
#pragma mark - end tableViewDelegate
- (IBAction)cashAction:(UIButton *)sender
{
    if (self.selectRow==-1) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择账户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    if (self.integralTextFild.text.floatValue==0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入兑换数量" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    if (self.integralTextFild.text.floatValue>self.interalLabel.text.floatValue) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"兑换数量有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    [self cash];
}
- (void)cash
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [fomatter stringFromDate:date];
    NSString * md5 = [NSString stringWithFormat:@"spyg:user_id=%@date=%@",user.userID,dateString];
    NSString * PostMD5 = [NSString MD5WithString:md5];
    NSDictionary * postDict = @{@"user_sign":PostMD5,@"gift_id":self.gift_id,@"user_ext_id":self.accountNumber,@"money":self.integralTextFild.text};
    GXHttpRequest *request1 = [[GXHttpRequest alloc]init];
    [HDHud showHUDInView:self.view title:@"换购中..."];
    [request1 RequestDataWithUrl:URL_PurchaseGift pragma:postDict];
    
    [request1 getResultWithSuccess:^(id response) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
        NSLog(@"%@",response);
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } DataFaiure:^(id error) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
        
    } Failure:^(id error) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
    }];

    
}
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
