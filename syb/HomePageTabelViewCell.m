//
//  HomePageTabelViewCell.m
//  syb
//
//  Created by GX on 15/11/4.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "HomePageTabelViewCell.h"

@implementation HomePageTabelViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setHomePageModel:(HomePageFloorDTO *)homePageModel
{
    _homePageModel = homePageModel;
    
    if ([homePageModel.floorName isEqualToString:@"floor1"]) {

        //尚品汇图片视图
        _xunzhenImageView = [[UIImageView alloc]init];
        _xunzhenImageView.frame = CGRectMake(10, 0,75, 33);
        NSString * shangpinhuiImage =  homePageModel.xunzhen;
       _xunzhenImageView.image = [UIImage imageNamed:shangpinhuiImage];
        
        _horizontalLabel = [[UILabel alloc]init];
        _horizontalLabel.frame = CGRectMake(0, 34, SCREEN_WIDTH, .5);
        _horizontalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        
        NSArray * collectionArray = [HomePageCollectionDto mj_objectArrayWithKeyValuesArray:homePageModel.floor1Array];
        _collectionArray = [NSMutableArray arrayWithArray:collectionArray];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,35,SCREEN_WIDTH,108*Proportion) collectionViewLayout:layout];
        _CollectionView.alwaysBounceVertical = YES;
        _CollectionView.backgroundColor = [UIColor whiteColor];
        [_CollectionView registerClass:[HomePageCollectionViewCell class]forCellWithReuseIdentifier:@"HomePageCollectionViewCell"];
        _CollectionView.dataSource = self;
        _CollectionView.delegate = self;
        _CollectionView.scrollEnabled = NO;
        
            
        //水平线
        UILabel * line1 = [[UILabel alloc]init];
        line1.frame = CGRectMake(0, 57*Proportion+33, SCREEN_WIDTH, .5);
        line1.backgroundColor = BGColor;
            
        //竖直线
        UILabel * line2 = [[UILabel alloc]init];
        line2.frame = CGRectMake(SCREEN_WIDTH/2,38*Proportion, .5,98*Proportion);
        line2.backgroundColor = BGColor;
      
        [self.contentView addSubview:_xunzhenImageView];
        [self.contentView addSubview:_horizontalLabel];
        [self.contentView addSubview:_CollectionView];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:line2];
        
    }else if ([homePageModel.floorName isEqualToString:@"floor2"]) {
        
        //尚品汇图片视图
        _ShangPinHuiImageView = [[UIImageView alloc]init];
        _ShangPinHuiImageView.frame = CGRectMake(10, 0, 60, 33);
        NSString * shangpinhuiImage =  homePageModel.shangpinhuiImageName;
        _ShangPinHuiImageView.image = [UIImage imageNamed:shangpinhuiImage];
        
        //水平线
        _horizontalLabel = [[UILabel alloc]init];
        _horizontalLabel.frame = CGRectMake(0, 34, SCREEN_WIDTH, .5);
        _horizontalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        
        //竖直线
        _verticalLabel = [[UILabel alloc]init];
        _verticalLabel.frame = CGRectMake(SCREEN_WIDTH/2, 35, .5, 72*Proportion);
        _verticalLabel.backgroundColor = RGBACOLOR(230,230,230,1);
        
        //跨境母婴
        _babyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _babyButton.frame = CGRectMake(0,35, SCREEN_WIDTH/2, 80*Proportion);
        NSString * babyimage = homePageModel.babybuttonImageName;
        [_babyButton sd_setBackgroundImageWithURL:[NSURL URLWithString:babyimage] forState:UIControlStateNormal];
        [_babyButton addTarget:self action:@selector(babyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //美妆按钮
        _beautyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _beautyButton.frame = CGRectMake( SCREEN_WIDTH/2+1,35, SCREEN_WIDTH/2, 80*Proportion);
        
        NSString * beautyImage = homePageModel.beautyButtonImageName;
        [_beautyButton sd_setBackgroundImageWithURL:[NSURL URLWithString:beautyImage] forState:UIControlStateNormal];
        [_beautyButton addTarget:self action:@selector(beautyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:_ShangPinHuiImageView];
        [self.contentView addSubview:_horizontalLabel];
        [self.contentView addSubview:_verticalLabel];
        [self.contentView addSubview:_babyButton];
        [self.contentView addSubview:_beautyButton];
 
    }else if([homePageModel.floorName isEqualToString:@"floor3"])
    {
        //网店汇
        _WangDianHuiImageView = [[UIImageView alloc]init];
        _WangDianHuiImageView.frame = CGRectMake(10, 0, 60, 33);
        NSString * wangdianhui =  homePageModel.wangdianhuiImageName;
        _WangDianHuiImageView.image = [UIImage imageNamed:wangdianhui];
        
        //更多按钮
        _moreImageView = [[UIImageView alloc]init];
        _moreImageView.frame = CGRectMake(SCREEN_WIDTH-66, 0, 66,33);
        _moreImageView.image = [UIImage imageNamed:homePageModel.moreImageName];
        
        
        [self.contentView addSubview:_WangDianHuiImageView];
        [self.contentView addSubview:_moreImageView];
        
    } else if([homePageModel.floorName isEqualToString:@"floor4"])
    {
        
        
        
        //平台来源
        _platform = [[UIImageView alloc]initWithFrame:CGRectMake(10,12.5, 40,40)];
        NSString * platform = homePageModel.shop_logo;
        [_platform sd_setImageWithURL:[NSURL URLWithString:platform]];
        
        //店铺名称
        _shopName = [[UILabel alloc]initWithFrame:CGRectMake(60,12.5, SCREEN_WIDTH-90, 20)];
        _shopName.text = [NSString stringWithFormat:@"%@ ",homePageModel.shop_name];
        _shopName.textColor = [UIColor blackColor];
        _shopName.font = [UIFont systemFontOfSize:14.0];
        _shopName.textAlignment = NSTextAlignmentLeft;
      
        //质检通过
        _passImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,2.5,79,60)];
        UIImage * passImage = [UIImage imageNamed:@"pass"];
        _passImage.image = passImage;
        
        _AttentionCount = [[UILabel alloc]init];
        _AttentionCount.frame = CGRectMake(SCREEN_WIDTH-130,40, 120, 20);
     
        NSString *userCount = homePageModel.atte_count;
        NSInteger  count = [userCount integerValue];
        
        if (count > 10000) {
            userCount = [NSString stringWithFormat:@"共%.1d万人认为靠谱",count/10000];
        }else{
            userCount = [NSString stringWithFormat:@"共%.0ld人认为靠谱",(long)count];
        }
        _AttentionCount.text = userCount;
        _AttentionCount.textColor = [UIColor blackColor];
        _AttentionCount.textAlignment = NSTextAlignmentRight;
        _AttentionCount.font = [UIFont systemFontOfSize:12];
    
        
     
        _AttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _AttentionButton.frame = CGRectMake(SCREEN_WIDTH-70,5, 60, 30);
        _AttentionButton.layer.borderWidth = .5;
        _AttentionButton.layer.borderColor = RGBACOLOR(200, 200, 200, 1).CGColor;
        _AttentionButton.layer.cornerRadius = 10;
        _AttentionButton.backgroundColor = [UIColor whiteColor];
        
        NSString * buttonTitle;
        if ([homePageModel.user_id isEmpty]) {
            buttonTitle = @"+关注";
        }else
        {
            buttonTitle = @"已关注";
        }
        [_AttentionButton setTitle:buttonTitle forState:UIControlStateNormal];
        [_AttentionButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        _AttentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _AttentionButton.tag = [homePageModel.tag integerValue] ;
        [_AttentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //中间那根线
        _cellLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH,.5)];
        _cellLine.backgroundColor = RGBACOLOR(210,210,210,.5);
        
        
        //Cell的背景视图
        _cellBackView =  [[UIView alloc]init];
        _cellBackView.frame = CGRectMake(0,5, SCREEN_WIDTH, 170);
        _cellBackView.backgroundColor = [UIColor whiteColor];
        

        //三张图片
        _goodsImage = [[UIImageView alloc]init];
        _goodsImage.frame = CGRectMake(0, 72.5, SCREEN_WIDTH, 90*Proportion);
        UIImage * noimage = [UIImage imageNamed:@"shopnoimage"];
        NSString * shopimage = homePageModel.shop_image;
        _goodsImage.layer.masksToBounds = YES;
        [_goodsImage sd_setImageWithURL:[NSURL URLWithString:shopimage] placeholderImage:noimage];

        
        
        [_cellBackView addSubview:_platform];
        [_cellBackView addSubview:_shopName];
        [_cellBackView addSubview:_passImage];
        [_cellBackView addSubview:_AttentionButton];
        [_cellBackView addSubview:_AttentionCount];
        [_cellBackView addSubview:_cellLine];
        [_cellBackView addSubview:_goodsImage];
        [self.contentView addSubview:_cellBackView];
    }


    
}
#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [_collectionArray count];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HomePageCollectionDto * hpModel = _collectionArray[indexPath.item];

    HomePageCollectionViewCell * cell = (HomePageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionViewCell" forIndexPath:indexPath];

    NSString * imageName = hpModel.image_url;
   [cell.HeaderImage sd_setImageWithURL:[NSURL URLWithString:imageName]];
    
    cell.HeaderImage.layer.masksToBounds = YES;
   
    return cell;


}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(SCREEN_WIDTH/2-10,52*Proportion);

}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2,2,1,1);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionDto * hpModel = _collectionArray[indexPath.item];
    
    NSString * Url = hpModel.link_url;
    NSString * title = hpModel.title;
    // 响应代理方法
    if ([self.delegate respondsToSelector:@selector(collectioncellClick:WithTitle:)]) {
        
        [self.delegate collectioncellClick:Url WithTitle:title];
    }

}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - /************************* 类方法返回行高 ***************************/
+ (CGFloat)heightForRow:(HomePageFloorDTO*)HomePageModel
{
    if ([HomePageModel.floorName isEqualToString:@"floor1"]) {
        
        return 108*Proportion+35;
        
    }else if ([HomePageModel.floorName isEqualToString:@"floor2"]) {
        
        return 80*Proportion+35;
    }
    else if ([HomePageModel.floorName isEqualToString:@"floor3"])
    {
        return 33;
        
    }else if([HomePageModel.floorName isEqualToString:@"floor4"])
    {
        return 90*Proportion+80;
    }else
    {
        return 0;
    }
    
}
-(void)babyButtonClick:(UIButton*)sender
{
    // 响应代理方法
    if ([self.delegate respondsToSelector:@selector(babyButtonClick:)]) {
        [self.delegate babyButtonClick:nil];
    }
    
}
-(void)beautyButtonClick:(UIButton*)sender
{
    // 响应代理方法
    if ([self.delegate respondsToSelector:@selector(beautyButtonClick:)]) {

        [self.delegate beautyButtonClick:nil];
    }
    
}

-(void)attentionButtonClick:(UIButton*)sender;
{
    UIButton * btn = (UIButton*)sender;
    
    
    if ([self.delegate respondsToSelector:@selector(attentionButtonClick:)]) {
        
        
        [self.delegate attentionButtonClick:btn ];
    }
}


@end
