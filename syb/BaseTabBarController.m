//
//  BaseTabBarController.m
//  Shell
//
//  Created by GongXin on 16/5/10.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BaseTabBarController.h"

#import "BKTabBarItem.h"

#import "SybWebViewController.h"


#import <ALBBTradeSDK/ALBBTradeService.h>
#import <ALBBTradeSDK/ALBBCartService.h>



static NSInteger num =0;

@interface BaseTabBarController()
{
    UIView *barView;
    BKTabBarItem *tempSelectItem;
    UIView *redDocView;
    UILabel *docCountLable;
}


@property (nonatomic,assign)NSInteger ViewControllerCount;


@property(nonatomic, strong) id<ALBBTradeService> tradeService;
@property(nonatomic, strong) tradeProcessSuccessCallback tradeProcessSuccessCallback;
@property(nonatomic, strong) tradeProcessFailedCallback tradeProcessFailedCallback;
@property(nonatomic, strong) addCartCacelledCallback addCartCacelledCallback;
@property(nonatomic, strong) addCartSuccessCallback addCartSuccessCallback;


@end

@implementation BaseTabBarController

static BaseTabBarController* _myTabBarVC = nil;

+(BaseTabBarController*)shareTabBarController{
    @synchronized(self){
        if (!_myTabBarVC) {
            _myTabBarVC = [[BaseTabBarController alloc]init];
        }
    }
    return _myTabBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义的tabBar
    barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    barView.backgroundColor = kTabBarBackColor;
    barView.userInteractionEnabled = YES;
    self.tabBar.hidden = YES;
    
    [self.view addSubview:barView];
    [self initSubViews];

     [self initAliCart];
}

-(void)initAliCart
{
    
    _tradeService = [[ALBBSDK  sharedInstance]getService:@protocol(ALBBTradeService)];

}

-(void)myCartsPage{
    
    TaeWebViewUISettings *viewSettings =[self getWebViewSetting];
    ALBBTradePage * page = [ALBBTradePage myCartsPage];
    [_tradeService  show:self isNeedPush:YES webViewUISettings:viewSettings page:page taoKeParams:nil tradeProcessSuccessCallback:_tradeProcessSuccessCallback tradeProcessFailedCallback:_tradeProcessFailedCallback];
}

-(TaeWebViewUISettings *)getWebViewSetting{
    
    TaeWebViewUISettings *settings = [[TaeWebViewUISettings alloc] init];
    settings.titleColor = [UIColor blueColor];
    settings.tintColor = [UIColor redColor];
    settings.barTintColor = kNavBackGround;
    
    
    return settings;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}

-(void)initSubViews
{
    _ViewControllerCount = 5;

    
    HomePageViewController * hpVc = [HomePageViewController viewController];
    [self setupItemWithViewController:hpVc ItemData:@{@"title":@"商品汇",@"imageStr":@"tab1",@"imageStr_s":@"tabs1"}];
    
    ShopsAllViewController * shopsVc = [ShopsAllViewController viewController];
    [self setupItemWithViewController:shopsVc ItemData:@{@"title":@"卖家汇",@"imageStr":@"tab2",@"imageStr_s":@"tabs2"}];
    
    ShiYongBaoViewController * sybVc = [ShiYongBaoViewController viewController];
    [self setupItemWithViewController:sybVc ItemData:@{@"title":@"真惠选认证",@"imageStr":@"tab3",@"imageStr_s":@"tabs3"}];
    
    CartViewController * cartVc = [CartViewController viewController];
    [self setupItemWithViewController:cartVc ItemData:@{@"title":@"购物车",@"imageStr":@"tab4",@"imageStr_s":@"tabs4"}];
    
    MeViewController * meVc = [MeViewController viewController];
    [self setupItemWithViewController:meVc ItemData:@{@"title":@"我的",@"imageStr":@"tab5",@"imageStr_s":@"tabs5"}];
    
    

}


-(void)setupItemWithViewController:(BaseViewController *)vc ItemData:(NSDictionary *)data
{
    //封装item数据
    Item *item = [[Item alloc]initItemWithDictionary:data];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [vc setNavTitle:item.title];
    [self addChildViewController:nav];
    
    CGFloat SubItemWidth = barView.frame.size.width/_ViewControllerCount;
    BKTabBarItem *subitem = [[BKTabBarItem alloc]initWithFrame:CGRectMake(SubItemWidth*num, 0,SubItemWidth, kTabBarHeight)];
    subitem.item = item;
    subitem.userInteractionEnabled = YES;
    subitem.tag = num;
    [barView addSubview:subitem];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectSubItemIndex:)];
    [subitem addGestureRecognizer:tap];
    num++;
    
    [self initDefaultItem:0];
    
 
}


//默认选中item0
-(void)initDefaultItem:(NSInteger)index
{
    BKTabBarItem *subitem  = barView.subviews[index];
    tempSelectItem = subitem;
    [subitem setItemSlected:^{
    }];
}

//点击方法
-(void)SelectSubItemIndex:(UIGestureRecognizer *)gesture
{
    NSInteger selectindex = gesture.view.tag;
    
    if(selectindex==2){
        
        SybWebViewController * webVc = [SybWebViewController viewController];
        
        webVc.RequestUlr = @"http://static.spygmall.com/article_html/7/dfb09b3e7b264633956fe4d26f69c215.html";
        
        webVc.isPush = @"nopush";
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVc];
        
        [self presentViewController:nav animated:YES completion:nil];
        
    }else if(selectindex==3)
    {
          [self myCartsPage];
        
        NSLog(@"呵呵");
        
    }else
    {
        
        [self setTabBarSelectedIndex:selectindex];
    }
   
}


-(void)setTabBarSelectedIndex:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    BKTabBarItem *selectSubitem  = (BKTabBarItem *)barView.subviews[selectedIndex];
    if(selectedIndex != tempSelectItem.tag){
        [selectSubitem setItemSlected:^{
            [tempSelectItem setItemNomal];
        }];
        tempSelectItem = selectSubitem;
    }
}

-(void)hiddenTabBar:(BOOL)hidden;
{
    [UIView beginAnimations:@"hiddenTabbar" context:nil];
    [UIView setAnimationDuration:0.3];
    if(hidden){
        
        barView.frame = CGRectMake(0,kMainScreenHeight ,kMainScreenWidth,kTabBarHeight);
  
        
    }else{
        barView.frame = CGRectMake(0,kMainScreenHeight-49 ,kMainScreenWidth, kTabBarHeight);
      
    }
    [UIView commitAnimations];
}


-(void)showOrderRedDocWithCount:(NSInteger)count;
{
    if(!redDocView){
        redDocView = [[UIView alloc]initWithFrame:CGRectMake(kMainScreenWidth*5/8+12, 3, 15, 15)];
        redDocView.backgroundColor = [UIColor redColor];
        //redDocView.layer.borderColor = [UIColor whiteColor].CGColor;
        //redDocView.layer.borderWidth = 1.0;
        redDocView.layer.cornerRadius = 7.5;
        redDocView.layer.masksToBounds = YES;
        [barView addSubview:redDocView];

        
        docCountLable = [[UILabel alloc]initWithFrame:redDocView.bounds];
        docCountLable.textColor = [UIColor whiteColor];
        docCountLable.font = [UIFont boldSystemFontOfSize:10.0];
        docCountLable.backgroundColor = [UIColor clearColor];
        docCountLable.textAlignment = NSTextAlignmentCenter;
        
        [redDocView addSubview:docCountLable];
        redDocView.hidden = YES;
    }
   
}

@end
