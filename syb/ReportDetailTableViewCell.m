//
//  ReportDetailTableViewCell.m
//  syb
//
//  Created by GongXin on 16/4/12.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ReportDetailTableViewCell.h"
#import "Helper.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIImageView+WebCache.h"
#import "ZhengpinDetailCollectionViewCell.h"
#define Margin 2.0
@implementation ReportDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setReportDetailModel:(ReportDetailModel *)reportDetailModel
{
    _reportDetailModel = reportDetailModel;
    _ImageArr = [NSMutableArray array];
    [_ImageArr addObjectsFromArray:reportDetailModel.imageList];
    

    NSString * htmlString = [self htmlEntityDecode: _reportDetailModel.content_text];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
   
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 20);
    _contentLabel.textColor = RGBACOLOR(114, 114, 114, 1);
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.attributedText = attrStr;
    _contentLabel.font = [UIFont systemFontOfSize:13];
    [_contentLabel sizeToFit];
    _contentLabel.backgroundColor = [UIColor clearColor];
 

    [self.contentView addSubview:_contentLabel];

    
    
    int i ;
    if ([_ImageArr count]==0) {
        i=0;
    }else if ([_ImageArr count]>0&&[_ImageArr count]<4)
    {
        i=1;
    }else if ([_ImageArr count]>3)
    {
        i=2;
    }

    float collectionHeight =90*Proportion *i+20*(i-1);

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,VIEW_MAXY(_contentLabel),SCREEN_WIDTH,collectionHeight) collectionViewLayout:layout];
    _CollectionView.alwaysBounceVertical = YES;
    _CollectionView.backgroundColor = [UIColor whiteColor];
    [_CollectionView registerClass:[ZhengpinDetailCollectionViewCell class]forCellWithReuseIdentifier:@"ZhengpinDetailCollectionViewCell"];
    _CollectionView.dataSource = self;
    _CollectionView.delegate = self;
    _CollectionView.scrollEnabled = NO;
    _CollectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_CollectionView];

    
    
}

+ (CGFloat)rowHeightForObject:(id)object;
{
    ReportDetailModel * model = (ReportDetailModel*)object;
    //图片和视频高度
    NSInteger imgNum =  [model.imageList count];
 
    int i ;
    if (imgNum==0) {
        i=0;
    }else if (imgNum>0&&imgNum <4)
    {
        i=1;
    }else if (imgNum>3)
    {
        i=2;
    }

    float collectionHeight =90*Proportion *i+20*(i-1);


    
    return collectionHeight;
}



//转码
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return string;
}
#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
   
    return [_ImageArr count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
      ZhengpinDetailCollectionViewCell * cell = (ZhengpinDetailCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ZhengpinDetailCollectionViewCell" forIndexPath:indexPath];
    
       NSString * imageUrl = [_ImageArr[indexPath.item] valueForKey:@"item_url"];

        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        
        cell.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImgViewClick:)];
        cell.imageView.tag = 5000+indexPath.item;
  
        [cell.imageView addGestureRecognizer:tap];
  
    
    
    return cell;
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(80*Proportion,80*Proportion);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,20,10,20);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)uploadImgViewClick:(UIGestureRecognizer *)gesture
{
    //进入预览大图
    UIImageView *imgView = (UIImageView *)gesture.view;
    [self browseImages:_ImageArr index:imgView.tag-5000 touchImageView:imgView];
}

#pragma mark - image browser
- (void)browseImages:(NSArray *)imageArr index:(NSInteger)index touchImageView:(UIImageView *)touchImageView{
    NSInteger count = imageArr.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = imageArr[i];
        photo.srcImageView = touchImageView; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


@end
