//
//  MeHeaderLoginView.m
//  syb
//
//  Created by 巩鑫 on 16/7/10.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MeHeaderLoginView.h"

@implementation MeHeaderLoginView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.messageButton];
        [self addSubview:self.pointImage];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
        singleRecognizer.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:singleRecognizer];
    }
    return self;
}
-(void)headerClick:(id)sender
{
    NSLog(@"header");
    if (_delegate) {
        [_delegate MeHeaderClick];
    }
}

-(void)setImageUrl:(NSString *)imageUrl

{
    _imageUrl = imageUrl;
    
    NSLog(@" %@ ",imageUrl);
    
    NSURL * ImageUrl = [NSURL URLWithString:imageUrl];
    
    UIImage * image = [UIImage imageNamed:@"touxiang"];
    
    [self.avatarImageView sd_setImageWithURL:ImageUrl placeholderImage:image];
    
}

-(void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
    
    self.nickNameLabel.text = nickName;
    
     NSLog(@" %@ ",nickName);
}

-(UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.frame = CGRectMake(20, 52, 60, 60);
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImageView.layer.borderWidth = 2;
        _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"tag_avatar80"];
    }
    return _avatarImageView;
}
-(UILabel*)nickNameLabel
{
    if (!_nickNameLabel) {
        
        // 创建 用户名称
        CGRect rect = CGRectMake(100,
                                 67 ,
                                 kMainScreenWidth/2,
                                 30);
        
        _nickNameLabel = [UILabel labelWithFrame:rect text:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:KTitleFont size:18]  backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        
        
        
        
    }
    return _nickNameLabel;
}

-(UIButton*)messageButton
{
    
    if (!_messageButton) {
        UIImage * messageImage = [UIImage imageNamed:@"message_white"];
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageButton.frame = CGRectMake(SCREEN_WIDTH-44,20, 44, 44);
        [_messageButton setImage:messageImage forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _messageButton;
    

}

-(void)messageClick:(UIButton*)sender
{
    NSLog(@"message");
    if (_delegate) {
        [_delegate MeHeaderLoginViewMessageBtn:sender];
    }
    
}

-(UIImageView*)pointImage
{
    if (!_pointImage) {
        _pointImage = [[UIImageView alloc]init];
        _pointImage.backgroundColor = [UIColor whiteColor];
        _pointImage.layer.cornerRadius = 4.5;
        _pointImage.frame = CGRectMake(SCREEN_WIDTH-16, 30, 9, 9);
        _pointImage.hidden = YES;
        
    }
    return _pointImage;
}

-(void)setHiddenPoint:(BOOL)hiddenPoint
{
    _hiddenPoint = hiddenPoint;
    
    
    if (hiddenPoint==YES) {
        self.pointImage.hidden = YES;
    }else if(hiddenPoint==NO)
    {
        self.pointImage.hidden = NO;
    }
}


@end
