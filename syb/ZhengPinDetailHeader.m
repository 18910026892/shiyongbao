//
//  ZhengPinDetailHeader.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPinDetailHeader.h"

@implementation ZhengPinDetailHeader
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _titleArray = @[@"采购",@"收购",@"检验",@"报告"];
        _imageArray = @[@"zhibo1",@"zhibo2",@"zhibo3",@"zhibo4"];
        
        
    }
    return self;
}

-(void)setZhiboHeader:(NSDictionary *)zhiboHeader
{
    _zhiboHeader = zhiboHeader;

    
    //图片
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        _cellImage.frame = CGRectMake(15,15, 70, 70);
        _cellImage.backgroundColor = [UIColor whiteColor];
        _cellImage.layer.cornerRadius = 3;
        _cellImage.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
        _cellImage.layer.borderWidth = .5;
        NSString * goodsImageUrl = [[zhiboHeader valueForKey:@"goods"] valueForKey:@"main_image"];
        UIImage * noimage = [UIImage imageNamed:@"noimage"];
        [_cellImage sd_setImageWithURL:[NSURL URLWithString:goodsImageUrl] placeholderImage:noimage];
    }
    
    
    //产品标题
    if (!_cellTitle) {
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200*Proportion, 40)];
        _cellTitle.textColor = [UIColor blackColor];
        _cellTitle.font = [UIFont systemFontOfSize:16.0];
        _cellTitle.textAlignment = NSTextAlignmentLeft;
        _cellTitle.numberOfLines = 2;
        // celltitle.lineBreakMode = NSLineBreakByCharWrapping;
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.text = [[zhiboHeader valueForKey:@"goods"] valueForKey:@"short_title"];
    }
    
    if(!_horizontalLabel)
    {
        _horizontalLabel = [[UILabel alloc]init];
        _horizontalLabel.frame = CGRectMake(0,100, SCREEN_WIDTH, 5);
        _horizontalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
    }
   
    NSArray * progressArray = [zhiboHeader valueForKey:@"progress"];
    
    for (int i=0; i<4; i++) {
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stateButton.frame = CGRectMake(10*Proportion+80*i*Proportion, 115, 60, 90);
        NSString * stateImage = [progressArray[i] valueForKey:@"img"];
        
        [_stateButton sd_setBackgroundImageWithURL:[NSURL URLWithString:stateImage] forState:UIControlStateNormal];
        
        _stateButton.tag = i;
        [_stateButton addTarget:self action:@selector(stateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _stateButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_stateButton];
    }
    
    
    for (int i=0; i<3; i++) {
        _arrowImage  = [[UIImageView alloc]init];
        _arrowImage.frame = CGRectMake(70*Proportion+80*i*Proportion, 150, 20, 20);
        _arrowImage.image = [UIImage imageNamed:@"zhiboarrow"];
        [self addSubview:_arrowImage];
    }
    
    
    
    
    [self addSubview:_horizontalLabel];
    [self addSubview:_cellImage];
    [self addSubview:_cellTitle];
    
}

-(void)stateButtonClick:(UIButton*)sender;
{
    UIButton * btn = (UIButton*)sender;
    
    
    if ([self.delegate respondsToSelector:@selector(stateButtonClick:)]) {
        
        
        [self.delegate stateButtonClick:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
