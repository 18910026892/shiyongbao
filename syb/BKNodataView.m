//
//  BKNodataView.m
//  Shell
//
//  Created by GongXin on 16/6/17.
//  Copyright © 2016年 SouYu. All rights reserved.
//

#import "BKNodataView.h"
@interface BKNodataView (){
    
     UILabel            *dataLabel;
     UIView             *contentView;
     UIImageView        *loaderrImageView;
    NODataType                         _noDataType;
    __weak UIViewController                   *_viewController;
    
}


@end

@implementation BKNodataView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initNodataView];
        
    }
    return self;
}

-(void)initNodataView

{
    loaderrImageView = [[UIImageView alloc]init];
    loaderrImageView.frame = CGRectMake(kMainScreenWidth/2-50, 151, 100, 100);
    loaderrImageView.image = [UIImage imageNamed:@"tag_nodata"];
    [self addSubview:loaderrImageView];
    
    dataLabel = [[UILabel alloc]init];
    dataLabel.frame = CGRectMake(10, 276, kMainScreenWidth-20, 20);
    dataLabel.font = [UIFont systemFontOfSize:14];
    dataLabel.textColor = [UIColor grayColor];
    dataLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:dataLabel];
    
}

-(void)showNoDataView:(UIView*)superView noDataType:(NODataType)type
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
    [self setNoDataType:type];
}

-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString
{
    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
  
    dataLabel.text =  [BKHelper isBlankString:noDataString] ? @"暂无数据" : noDataString;
    
  
    
}

-(void)showSmileNodataView:(UIView*)superView noDataString:(NSString *)noDataString;
{

    if (!self.superview) {
        self.frame = superView.bounds;
        [superView addSubview:self];
    }
        
    dataLabel.text =  [BKHelper isBlankString:noDataString] ? @"暂无数据" : noDataString;
        

    [self setNoDataType:kNoDataType_Smile];
}



-(void)setContentViewFrame:(CGRect)rect
{
    self.frame = rect;
}

-(void)setColor:(UIColor*)color
{
    self.backgroundColor = color;
    contentView.backgroundColor = color;
}

-(void)showNoDataViewController:(UIViewController *)viewController noDataType:(NODataType)type{
    if (!self.superview) {
        self.frame = viewController.view.bounds;
        [viewController.view addSubview:self];
    }
    _noDataType = type;
    _viewController = viewController;
    [self setNoDataType:type];
}



-(void)setNoDataType:(NODataType)type{
    
    switch (type) {
        case kNoDataType_Default:
            dataLabel.text = @"暂无数据";
            //[dataButton setTitle:@"随便逛逛" forState:UIControlStateNormal];
            break;
            case kNoDataType_Smile:
          loaderrImageView.image = [UIImage imageNamed:@"tag_nodata_smile"];
            break;
    }
    //    [dataButton addTarget:self action:@selector(dataAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)hide
{
    [self removeFromSuperview];
}

-(void)dataAction:(id)sender{
    
    switch (_noDataType) {
            
        case kNoDataType_Default:
            break;
            
        default:
            if(_delegate && [_delegate respondsToSelector:@selector(didClickedNoDataButton)])
            {
                [_delegate didClickedNoDataButton];
            }
            break;
    }
}

@end
