//
//  BarCodeViewController.m
//  syb
//
//  Created by GX on 15/10/22.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "BarCodeViewController.h"

@implementation BarCodeViewController

- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_readView start];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [_readView flushCache];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [_timer invalidate];
    _lineView.frame = CGRectMake(10*Proportion, 10*Proportion, 220*Proportion, 2*Proportion);
    _num = 0;
    _upOrdown = NO;
    [_readView stop];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _num = 0;
    _upOrdown = NO;
    [self InitScan];
}
-(void)InitScan
{
    _readView = [ZBarReaderView new];
    _readView.readerDelegate = self;
    _readView.torchMode = 0;
    _readView.allowsPinchZoom = NO;
    _readView.tracksSymbols = NO;
    _readView.frame =  CGRectMake(-(SCREEN_HEIGHT-SCREEN_WIDTH)/2, 0, SCREEN_HEIGHT, SCREEN_HEIGHT);
    _readView.layer.borderColor = RGBACOLOR(1, 1, 1,0.4).CGColor;
    _readView.layer.borderWidth = 164*Proportion;
    //扫描区域
    CGRect scanMaskRect = CGRectMake((SCREEN_HEIGHT-SCREEN_WIDTH)/2+40*Proportion, SCREEN_HEIGHT/2-120*Proportion, 240*Proportion, 240*Proportion);
    _readView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:_readView.bounds];
    
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(10*Proportion, 10*Proportion, 220*Proportion, 2*Proportion)];
        _lineView.image = [UIImage imageNamed:@"barcodeLine"];
        
    }
    
    if(!_centerImageView)
    {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barcodeCenter"]];
        _centerImageView.frame =  CGRectMake((SCREEN_HEIGHT-SCREEN_WIDTH)/2+40*Proportion, SCREEN_HEIGHT/2-120*Proportion, 240*Proportion, 240*Proportion);
        [_centerImageView addSubview:_lineView];
        [_readView addSubview:_centerImageView];
    }

    [self.view addSubview:_readView];
    
    //定时器，设定时间过0.02秒，
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    [_readView start];
    
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20,44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"nav_back_select"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(80, 20, SCREEN_WIDTH/2, 44);
        _titleLabel.text = @"二维码/条形码";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    
    if(!_alertLabel)
    {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 84*Proportion, SCREEN_WIDTH-40, 20)];
        _alertLabel.text = @"对准二维码/条形码到框内即可扫描";
        _alertLabel.textColor = [UIColor whiteColor];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self.view addSubview:_alertLabel];
        
    }
    
    if (!_lightButton) {
        _lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lightButton.frame = CGRectMake(SCREEN_WIDTH/2-22, SCREEN_HEIGHT-88, 44, 44);
        [_lightButton setImage:[UIImage imageNamed:@"lightclose"] forState:UIControlStateNormal];
        [_lightButton addTarget:self action:@selector(openLight:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_lightButton];
        
    }

    
}
//计算扫描区域的函数
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x,y, width, height);
}
//打开手电筒的方法
-(void)openLight:(UIButton *)sender;
{
    if (_readView.torchMode == 0 ) {
        _readView.torchMode = 1 ;
        [_lightButton setImage:[UIImage imageNamed:@"lightopen"] forState:UIControlStateNormal];
    } else
    {
        _readView.torchMode = 0 ;
        [_lightButton setImage:[UIImage imageNamed:@"lightclose"] forState:UIControlStateNormal];
    }
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    NSString *str;
    
    for (ZBarSymbol *symbol in symbols) {
        NSLog(@"%@", symbol.data);
        str = symbol.data;
        break;
    }
    
    [_timer invalidate];
    
    _lineView.frame = CGRectMake(10*Proportion, 10*Proportion, 220*Proportion, 2*Proportion);
    _num = 0;
    _upOrdown = NO;
    [_readView stop];

}
//动画
-(void)animation
{
    if (_upOrdown == NO) {
        _num ++;
        _lineView.frame = CGRectMake(10*Proportion, 10*Proportion+2*_num*Proportion, 220*Proportion, 2*Proportion);
        if (2*_num == 220) {
            _upOrdown = YES;
        }
    }
    else {
        _num = 0;
        _upOrdown = NO;
    }
    
    
}

-(void)backClick:(UIButton*)sender
{
    [_timer invalidate];
    _lineView.frame = CGRectMake(10*Proportion, 10*Proportion, 220*Proportion, 2*Proportion);
    _num = 0;
    _upOrdown = NO;
    [_readView stop];
    
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:NO];
    
}

@end
