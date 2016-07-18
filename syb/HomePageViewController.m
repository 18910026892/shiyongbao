//
//  HomePageViewController.m
//  syb
//
//  Created by GongXin on 16/7/7.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "HomePageViewController.h"
#import "SearchViewController.h"
#import "ClassifyViewController.h"


#import "brandGoodsViewController.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:NO];
    
     self.navigationController.navigationBarHidden = YES;
}

-(CCAdsPlayView*)BannerView
{
    if (!_BannerView) {
        
        _BannerView = [CCAdsPlayView adsPlayViewWithFrame:CGRectMake(0, 0,kMainScreenWidth,107*Proportion) imageGroup:nil];
        
        _BannerView.placeHoldImage  = [UIImage imageNamed:@"fillimage"];
        //设置小圆点位置
        _BannerView.pageContolAliment = CCPageContolAlimentCenter;
        //设置动画时间
        _BannerView.animationDuration = 3.;
        
        __weak HomePageViewController * hpVC = self;
        
 
        
        [_BannerView startWithTapActionBlock:^(NSInteger index) {
            
            
        
            
        }];
        
    }
    
    
    return _BannerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.BannerView];
    [self setupViews];
    
}
-(void)setupViews
{
    [self.Customview addSubview:self.logoImageView];
    [self.Customview addSubview:self.searchButton];
    [self.Customview addSubview:self.messageButton];
}

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.frame = CGRectMake(20, 35, 45, 15);
        _logoImageView.image = [UIImage imageNamed:@"shiyongbaologo"];
    }
    return _logoImageView;
}

-(UIButton*)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(kMainScreenWidth/2-67.5, 30, 175, 25);
        [_searchButton setImage:[UIImage imageNamed:@"searchButton"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UIButton*)messageButton
{
    
    if (!_messageButton) {
        UIImage * messageImage = [UIImage imageNamed:@"message_pink"];
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
        [_messageButton setImage:messageImage forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _messageButton;
    
    
}
-(void)searchButtonClick:(UIButton*)sender

{
    [self.navigationController pushViewController:[SearchViewController viewController] animated:YES];
}


-(void)messageClick:(UIButton*)sender
{
    NSLog(@"message");
    
     [self.navigationController pushViewController:[brandGoodsViewController viewController] animated:YES];

    
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
