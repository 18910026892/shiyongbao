//
//  ProductGoodsViewCotroller.h
//  syb
//
//  Created by GongXin on 16/7/15.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductGoodsModel.h"
#import "ProductGoodsCell.h"
@interface ProductGoodsViewCotroller : BaseViewController
<UITableViewDelegate,UITableViewDataSource,ProductGoodsCellDelegate>
{
    
    SybSession * userSession;
    
}
@property (nonatomic,strong)UITableView * TableView;


@property (nonatomic,strong)NSMutableArray * goodArray;

@property (nonatomic,strong)NSMutableArray * goodModelArray;

@property (nonatomic,strong)NSMutableArray * goodListArray;

@property(nonatomic,copy)NSString * page;
@property(nonatomic,copy)NSString * cat_id;

@property (nonatomic,copy)NSString *navTitle;

@property(nonatomic,strong)UILabel* navTitleLabel;

@end
