//
//  AddAccountViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "AddAccountViewController.h"

@interface AddAccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UIButton *bandingBtn;

@end

@implementation AddAccountViewController
{
    SybSession *user;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton:YES];
    user = [SybSession sharedSession];
    if (self.bandingType==zhifubaoType) {
        [self setNavTitle:@"绑定支付宝"];
        self.typeName.text = @"支付宝账户";
    }else if (self.bandingType == bankType){
        [self setNavTitle:@"绑定银行卡"];
        self.typeName.text = @"银行卡号";
    }
    self.bandingBtn.cornerRadius = 5;
    self.bandingBtn.backgroundColor = kNavBackGround;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:YES];
}
- (IBAction)bandingAction:(UIButton *)sender
{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
