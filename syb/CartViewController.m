//
//  CartViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "CartViewController.h"
#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>
@interface CartViewController ()
@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;

@end

@implementation CartViewController

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;

    
    [self initAli];
}

-(void)hehe

{
    NSLog(@"呵呵");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setupViews];
}
-(void)setupViews
{
   
}

-(void)initAli
{

    _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];

    [self myCartsPage];
    
}

-(void)myCartsPage{

    TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
    ALBBTradePage * page = [ALBBTradePage myCartsPage];
    [_tradeService  show:self.navigationController isNeedPush:YES webViewUISettings:viewSettings page:page taoKeParams:nil tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
}

-(TaeWebViewUISettings *)getWebViewSetting{
    
    TaeWebViewUISettings *settings = [[TaeWebViewUISettings alloc] init];
    settings.titleColor = [UIColor blueColor];
    settings.tintColor = [UIColor redColor];
    settings.barTintColor = kNavBackGround;
    
    return settings;
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
