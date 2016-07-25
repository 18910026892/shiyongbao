//
//  PayTheGasolineViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "PayTheGasolineViewController.h"
#import "InteralGoodsModel.h"
#import "InteralGoodsContentView.h"
#import "PayTheGasolineTableViewCell.h"
NSString * const zsyHistroies = @"zsyHistroies";
NSString * const zshHistroies = @"zshHistroies";
@interface PayTheGasolineViewController ()<UITableViewDelegate,UITableViewDataSource,InteralGoodsContentViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *zhongshiyouBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhongshihuaBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineCenter;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *bottomLIneHeights;
@property (nonatomic,assign)int typeFlag;
@property (strong,nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSArray *histroies;
@property (nonatomic,assign)NSInteger selectedRow;
@property (nonatomic,copy)NSString *number;
@end

@implementation PayTheGasolineViewController
{
    SybSession *user;
}
-(NSMutableArray *)categories
{
    if (!_categories) {
        _categories = [NSMutableArray array];
        [_categories addObject:[NSArray array]];
        [_categories addObject:[NSArray array]];
    }
    return _categories;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *zsyarray = [[NSUserDefaults standardUserDefaults] objectForKey:zsyHistroies];
    self.histroies = zsyarray;
    user = [SybSession sharedSession];
    for (NSLayoutConstraint *height in self.bottomLIneHeights) {
        height.constant = 0.5;
    }
    self.selectedRow = -1;
    [self requestCategroies];
    // Do any additional setup after loading the view from its nib.
    [self showBackButton:YES];
    [self setNavTitle:@"充油卡"];
    self.typeFlag = 1;
    
}
#pragma mark - requestCategroies
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
                    NSArray *giftArray = [response objectForKey:@"result"];
                    NSArray *zsyGifts = [InteralGoodsModel arrayWithArrays:giftArray];
                    [self.categories replaceObjectAtIndex:0 withObject:zsyGifts];
                }
            }
            [self.tableView reloadData];
        } DataFaiure:^(id error) {
            
    
        } Failure:^(id error) {
    
        }];
    
//    NSDictionary *postDict1 = @{@"gift_cat_id":self.gift_cate_id,@"gift_type":@"zsh"};
    NSDictionary *postDict1 = @{@"gift_cat_id":self.gift_cate_id};
    GXHttpRequest *request1 = [[GXHttpRequest alloc]init];
    
    [request1 RequestDataWithUrl:URL_GetGiftList pragma:postDict1];
    
    [request1 getResultWithSuccess:^(id response) {
        //加载框消失
        [HDHud hideHUDInView:self.view];
        NSLog(@"%@",response);
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            if ([[response objectForKey:@"code"] intValue]==1) {
                NSArray *giftArray = [response objectForKey:@"result"];
                NSArray *zsyGifts = [InteralGoodsModel arrayWithArrays:giftArray];
                [self.categories replaceObjectAtIndex:1 withObject:zsyGifts];
            }
        }
        [self.tableView reloadData];
    } DataFaiure:^(id error) {
        
        
    } Failure:^(id error) {
        
    }];
}
#pragma mark - end requestCategroies

- (IBAction)shiyouDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    self.selectedRow = -1;
    self.typeFlag = 1;
    self.zhongshihuaBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    NSArray *zsy = [[NSUserDefaults standardUserDefaults] objectForKey:zsyHistroies];
    self.histroies = zsy;
    [self.tableView reloadData];
    self.numberTF.text = @"";
}

- (IBAction)shihuaDidClick:(UIButton *)sender
{
    if (sender.selected) return;
    self.selectedRow = -1;
    self.typeFlag = 2;
    self.zhongshiyouBtn.selected = NO;
    sender.selected = YES;
    self.bottomLineCenter.constant = self.zhongshihuaBtn.center.x-self.zhongshiyouBtn.center.x;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    NSArray *zsh = [[NSUserDefaults standardUserDefaults] objectForKey:zshHistroies];
    self.histroies = zsh;
    [self.tableView reloadData];
    self.numberTF.text = @"";
}
#pragma mark - tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayTheGasolineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTheGasolineTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PayTheGasolineTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.gasolineNumber = self.histroies[indexPath.row];
    BOOL isSelected = indexPath.row==self.selectedRow?YES:NO;
    cell.isSelected = isSelected;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.histroies.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *categories = self.categories[self.typeFlag-1];
    if (categories.count>0) {
        InteralGoodsContentView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"InteralGoodsContentView" owner:nil options:nil] lastObject];
        footerView.datas = categories;
        footerView.delegate = self;
        return footerView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray *categories = self.categories[self.typeFlag-1];
    if (categories.count>0) {
        NSInteger hang = categories.count/3+1;
        NSInteger lie = categories.count%3;
        if (lie==0) {
            hang--;
        }
        CGFloat height = (kMainScreenWidth-50)/3+20;
        return (height+10)*hang;
    }
    
    return 0.001;
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 0.01;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    self.number = self.histroies[indexPath.row];
    self.numberTF.text = self.number;
    [self.tableView reloadData];
}
#pragma mark - end tableViewDelegate

#pragma mark - TFDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField ==self.numberTF) {
        if (self.selectedRow!=-1) {
            self.selectedRow = -1;
            [self.tableView reloadData];
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.numberTF) {
        self.number = textField.text;
    }
}
#pragma mark - end TFDelegate

#pragma mark - footerViewDelegate
- (void)itemDidClicked:(InteralGoodsModel *)goods
{
    if (self.number.length==0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入卡号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }

    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                   invertedSet ];
    NSString *strPhone = [[self.phoneTF.text componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    if (strPhone.length!=11) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"号码格式有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return ;
    }
    
    [self payAction:goods];
}
- (void)payAction:(InteralGoodsModel *)goods
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [fomatter stringFromDate:date];
    NSString * md5 = [NSString stringWithFormat:@"spyg:user_id=%@date=%@",user.userID,dateString];
    NSString * PostMD5 = [NSString MD5WithString:md5];
    NSString *phone = self.phoneTF.text;
    NSDictionary * postDict = @{@"user_sign":PostMD5,@"gift_id":goods.gift_id,@"account":self.number,@"gas_card_tel":phone};
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
            NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
            if ([[response objectForKey:@"code"] intValue]==1) {
                if (self.typeFlag==1) {
                    NSMutableArray *history = [NSMutableArray arrayWithArray:[userDF objectForKey:zsyHistroies]];
                    if (![history containsObject:self.number]) {
                        [history addObject:self.number];
                        [userDF setObject:history forKey:zsyHistroies];
                    }
                }else if (self.typeFlag==2){
                    NSMutableArray *history = [NSMutableArray arrayWithArray:[userDF objectForKey:zshHistroies]];
                    if (![history containsObject:self.number]) {
                        [history addObject:self.number];
                        [userDF setObject:history forKey:zshHistroies];
                    }
                }
            }
            [userDF synchronize];
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
#pragma mark - end footerViewDelegate
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
