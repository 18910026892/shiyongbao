//
//  InteralGoodsContentView.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "InteralGoodsContentView.h"
#import "IteralGoodCollectionViewCell.h"
#import "InteralGoodsModel.h"
@interface InteralGoodsContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign)NSInteger selectedRow;
@end

@implementation InteralGoodsContentView
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"IteralGoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IteralGoodCollectionViewCell"];
}
-(void)setDatas:(NSArray *)datas
{
    _datas = datas;
    [self.collectionView reloadData];
}
#pragma mark - collectionView
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IteralGoodCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier : @"IteralGoodCollectionViewCell" forIndexPath :indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]
                 
                 loadNibNamed:@"IteralGoodCollectionViewCell" owner:nil options:nil] lastObject];
    }
    cell.goods = self.datas[indexPath.row];
    if (indexPath.row==self.selectedRow) {
        cell.selected = YES;
    }else cell.selected = NO;
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    CGFloat width = (kMainScreenWidth-50)/3;
    return CGSizeMake (width ,width);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedRow = indexPath.row;
//    [self.collectionView reloadData];
    InteralGoodsModel *good = self.datas[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(itemDidClicked:)]) {
        [self.delegate itemDidClicked:good];
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
