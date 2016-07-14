//
//  WebShiYongShuoTableViewCell.m
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "WebShiYongShuoTableViewCell.h"

@implementation WebShiYongShuoTableViewCell

-(void)setWebshiyongshuoModel:(WebShiYongShuoModel *)webshiyongshuoModel
{
    _webshiyongshuoModel = webshiyongshuoModel;

 
    _cellimage = [[UIImageView alloc]init];
    _cellimage.frame = CGRectMake(20, 10, 50,50);
    _cellimage.layer.masksToBounds = YES;
    _cellimage.layer.cornerRadius = 25;
    _cellimage.layer.borderColor = RGBACOLOR(209, 209, 209, 1).CGColor;
    _cellimage.layer.borderWidth = 0.5;
    NSString * imageUrl = webshiyongshuoModel.p_img_url;
    NSURL * imgUrl = [NSURL URLWithString:imageUrl];
    [_cellimage sd_setImageWithURL:imgUrl];
    [self.contentView addSubview:_cellimage];
    
    
    _celltitle = [[UILabel alloc]initWithFrame:CGRectMake(90*Proportion, 5*Proportion, 200*Proportion, 40*Proportion)];
    _celltitle.textColor = [UIColor blackColor];
    _celltitle.font = [UIFont systemFontOfSize:15.0];
    _celltitle.textAlignment = NSTextAlignmentLeft;
    _celltitle.numberOfLines = 2;
    _celltitle.lineBreakMode = NSLineBreakByCharWrapping;
    _celltitle.backgroundColor = [UIColor clearColor];
    _celltitle.text = webshiyongshuoModel.p_name;
    [self.contentView addSubview:_celltitle];
    

    
}
@end
