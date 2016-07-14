//
//  WebShiYongShuoTableViewCell.h
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebShiYongShuoModel.h"
@interface WebShiYongShuoTableViewCell : UITableViewCell

@property (nonatomic,strong)WebShiYongShuoModel * webshiyongshuoModel;

@property(nonatomic,strong) UIImageView * cellimage;

@property(nonatomic,strong) UILabel * celltitle;



@end
