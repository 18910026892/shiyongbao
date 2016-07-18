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
#import "ShopsViewController.h"

#import "brandGoodsViewController.h"
@interface HomePageViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *categoryArray;
@property (strong,nonatomic) NSMutableArray *catIdArray;
@property (strong,nonatomic) NSMutableArray *titleArray;
@property (strong,nonatomic) UIView *contentSmallSV;
@end

@implementation HomePageViewController{
    UIScrollView * bigScrollView;
    UIScrollView *smallScrollView;
}
-(UIScrollView *)contentSV
{
    if (!_contentSV) {
        _contentSV  = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64,SCREEN_WIDTH , SCREEN_HEIGHT-64-49)];
        _contentSV.backgroundColor = [UIColor whiteColor];
        _contentSV.bounces = YES;
        _contentSV.pagingEnabled = YES;
        _contentSV.showsHorizontalScrollIndicator = NO;
        _contentSV.showsVerticalScrollIndicator = NO;
        _contentSV.opaque = YES;
    }
    return _contentSV;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarHide:NO];
    
     self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentSV];;
    // Do any additional setup after loading the view.
    [self setUpDatas];
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

-(void)setUpDatas
{
    _categoryArray = [NSArray arrayWithArray:[UserDefaultsUtils valueWithKey:@"goodCatList"]];
    _titleArray = [NSMutableArray array];
    _catIdArray = [NSMutableArray array];
    for (NSDictionary * dict in _categoryArray) {
        NSString * catid = [dict valueForKey:@"cat_id"];
        NSString * title = [dict valueForKey:@"cat_name"];
        
        [_catIdArray addObject:catid];
        [_titleArray addObject:title];
    }
    [self initScroll];
}


-(void)initScroll
{
    if (!smallScrollView) {
        self.contentSmallSV = [[UIView alloc] initWithFrame:CGRectMake(0, 64*2,SCREEN_WIDTH , 40)];
        [self.view addSubview:self.contentSmallSV];
        UIButton *fenlei = [UIButton buttonWithType:UIButtonTypeCustom];
        [fenlei setFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/7, 0, SCREEN_WIDTH/7, self.contentSmallSV.height)];
        [fenlei setTitle:@"分类" forState:UIControlStateNormal];
        [fenlei setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [fenlei addTarget:self action:@selector(fenleiAction) forControlEvents:UIControlEventTouchUpInside];
        smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH , 40)];
        smallScrollView.backgroundColor = [UIColor whiteColor];
        smallScrollView.bounces = YES;
        smallScrollView.pagingEnabled = YES;
        smallScrollView.showsHorizontalScrollIndicator = NO;
        smallScrollView.showsVerticalScrollIndicator = NO;
        smallScrollView.opaque = YES;
        
    }
    
    if (!bigScrollView) {
        bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.contentSmallSV.bottom,SCREEN_WIDTH , SCREEN_HEIGHT-self.contentSmallSV.bottom)];
        bigScrollView.backgroundColor = [UIColor clearColor];
        bigScrollView.bounces = NO;
        bigScrollView.pagingEnabled = YES;
        bigScrollView.showsHorizontalScrollIndicator = NO;
        bigScrollView.showsVerticalScrollIndicator = NO;
        bigScrollView.delegate = self;
        bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*[_categoryArray count],bigScrollView.frame.size.height);
        bigScrollView.scrollEnabled = YES;
    }
    
    
    [self addController];
    [self addLable];
    
    
    // 添加默认控制器
    ShopsViewController * vc = [self.childViewControllers firstObject];
    vc.view.frame = bigScrollView.bounds;
    vc.cat_id1 = _catIdArray[0];
    [bigScrollView addSubview:vc.view];
    
    
    ShopsTitle *lable = [smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    
    [self.view addSubview:bigScrollView];
    [self.contentSmallSV addSubview:smallScrollView];
    
}
-(void)addController
{
    
    for (int i=0 ; i<[_catIdArray count] ;i++){
        ShopsViewController * shopVC = [[ShopsViewController alloc]init];
        shopVC.cat_id1 = _catIdArray[i];
        [self addChildViewController:shopVC];
    }
    
}
/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < [self.categoryArray count]; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        ShopsTitle *lbl1 = [[ShopsTitle alloc]init];
        lbl1.text = [_titleArray objectAtIndex:i];
        NSLog(@"%@",_titleArray[i]);
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    smallScrollView.contentSize = CGSizeMake(70 * [_titleArray count]+SCREEN_WIDTH/7, 0);
    
}
/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    ShopsTitle *titlelable = (ShopsTitle *)recognizer.view;
    CGFloat offsetX = titlelable.tag * bigScrollView.frame.size.width;
    CGFloat offsetY = bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [bigScrollView setContentOffset:offset animated:YES];
    
}
#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x /bigScrollView.frame.size.width;
    // 滚动标题栏
    ShopsTitle *titleLable = (ShopsTitle *)smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax =smallScrollView.contentSize.width -smallScrollView.frame.size.width;
    
    
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx,smallScrollView.contentOffset.y);
    [smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    ShopsViewController * shopVc = self.childViewControllers[index];
    shopVc.cat_id1 = _catIdArray[index];
    
    [smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            ShopsTitle *temlabel = smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (shopVc.view.superview) return;
    shopVc.view.frame = scrollView.bounds;
    [bigScrollView addSubview:shopVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    ShopsTitle *labelLeft = smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex <smallScrollView.subviews.count) {
        ShopsTitle *labelRight = smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}

/*********分类**********/
- (void)fenleiAction
{

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
