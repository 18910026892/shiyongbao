//
//  ZhengPinDetailTableViewCell.m
//  syb
//
//  Created by GongXin on 16/4/8.
//  Copyright © 2016年 GX. All rights reserved.
//

#import "ZhengPinDetailTableViewCell.h"
#import "Helper.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UIImageView+WebCache.h"
#import "ZhengpinDetailCollectionViewCell.h"
#define Margin 2.0
@implementation ZhengPinDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setZhengpinDetailModel:(ZhengPinDetailModel *)zhengpinDetailModel
{
    
    _zhengpinDetailModel = zhengpinDetailModel;
    
    _ImageArr = [NSMutableArray array];

    for (NSDictionary * dict1  in zhengpinDetailModel.image_list) {
        NSString * item_url = [dict1 valueForKey:@"item_url"];
        [_ImageArr addObject:item_url];
    }
    
    _videoArr = [NSMutableArray array];
    for (NSDictionary * dict2  in zhengpinDetailModel.video_list) {
        NSString * item_url = [dict2 valueForKey:@"item_url"];
        [_videoArr addObject:item_url];
    }
    
    _storeModelArr = [NSMutableArray arrayWithArray:zhengpinDetailModel.store_List];
    
    _StoreListArr = [StoreModel mj_objectArrayWithKeyValuesArray:_storeModelArr];
    
    

    NSString * event_title = zhengpinDetailModel.event_title;
    NSString * event_time = zhengpinDetailModel.event_time;

    CGRect Rect1 ;
    CGRect Rect2 ;
    if ([event_title isEqualToString:@""]) {
        Rect1 = CGRectMake(0, 0, 0, 0);
    }else
    {
         Rect1 = CGRectMake(20, 5, SCREEN_WIDTH/2+20, 20);
    }
    
    if ([event_time isEqualToString:@""]) {
        Rect2 = CGRectMake(0, 0, 0, 0);
    }else
    {
        Rect2 = CGRectMake(SCREEN_WIDTH/2+20, 5, SCREEN_WIDTH/2-40, 20);
    }
    
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.frame = Rect1;
    [_titleLabel setTextColor:[UIColor blackColor]];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    _titleLabel.text = event_title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.numberOfLines = 0;
    _dateLabel.frame = Rect2;
    [_dateLabel setTextColor:[UIColor grayColor]];
    [_dateLabel setBackgroundColor: [UIColor clearColor]];
    [_dateLabel setTextAlignment:NSTextAlignmentRight];
    _dateLabel.text = event_time;
    _dateLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_dateLabel];
    
    
    
    NSString * contentStr = zhengpinDetailModel.content_text;
    
    NSString * htmlString = [self htmlEntityDecode:contentStr];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    

     CGRect Rect3;
  
    if ([contentStr isEqualToString:@""]) {
        Rect3 = CGRectMake(0, 0, 0, 0);
    }else
    {
        Rect3 = CGRectMake(20,VIEW_MAXY(_titleLabel)+5, SCREEN_WIDTH-40, 20);
    }

    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = Rect3;
    _contentLabel.textColor = RGBACOLOR(114, 114, 114, 1);
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.attributedText = attrStr;
    [_contentLabel sizeToFit];
    _contentLabel.tag = 88888;
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
    
    int j ;
    if ([_videoArr count]==0) {
        j=0;
    }else if ([_videoArr count]>0&&[_videoArr count]<4)
    {
        j=1;
    }
    
    int z = i+j;

    float collectionHeight;
    
    
    if (z==0) {
        
        collectionHeight = 0;
    }else
    {
      
         collectionHeight =90*Proportion *z+20*(z-1);
    }
    

    CGRect Rect4;
    if ([contentStr isEqualToString:@""]) {
        Rect4 = CGRectMake(0, VIEW_MAXY(_titleLabel), SCREEN_WIDTH,collectionHeight);
    }else
    {
        Rect4 = CGRectMake(20,VIEW_MAXY(_contentLabel)+5, SCREEN_WIDTH,collectionHeight);
    }
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,VIEW_MAXY(_contentLabel)+10,SCREEN_WIDTH,collectionHeight) collectionViewLayout:layout];
    _CollectionView.alwaysBounceVertical = YES;
    _CollectionView.backgroundColor = [UIColor whiteColor];
    [_CollectionView registerClass:[ZhengpinDetailCollectionViewCell class]forCellWithReuseIdentifier:@"ZhengpinDetailCollectionViewCell"];
    _CollectionView.dataSource = self;
    _CollectionView.delegate = self;
    _CollectionView.scrollEnabled = NO;
    if(collectionHeight==0)
    {
        _CollectionView.hidden = YES;
    }else
    {
        _CollectionView.hidden = NO;
    }
    _CollectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_CollectionView];
    

    NSInteger S  = [zhengpinDetailModel.store_List count];
    float storeListHeight;
    
    if (S==0) {
        storeListHeight = 0;
    }else
    {
        storeListHeight = S * 44+30;
        
        _storeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,VIEW_MAXY(_CollectionView),SCREEN_WIDTH, storeListHeight) style:UITableViewStyleGrouped];
        _storeTableView.delegate = self;
        _storeTableView.dataSource = self;
        _storeTableView.backgroundColor =  [UIColor clearColor];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _storeTableView.scrollEnabled = NO;
        _storeTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_storeTableView];
        
        
    }
 
    
    
    
    float timelineHeight = CGRectGetHeight(_titleLabel.frame)+CGRectGetHeight(_contentLabel.frame)+CGRectGetHeight(_CollectionView.frame)+CGRectGetHeight(_storeTableView.frame)+30;
    
    if (IOS_9) {
        _timeLine = [[UILabel alloc]init];
        _timeLine.frame = CGRectMake(13, 0, 1, timelineHeight);
        _timeLine.backgroundColor = RGBACOLOR(220, 220, 220, 1);
        [self.contentView addSubview:_timeLine];
        
    }
    

    
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

#pragma mark TableView Datasorce;

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
    
}

#pragma table Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
  
    _sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 20)];
    _sectionTitle.backgroundColor = [UIColor clearColor];
    _sectionTitle.textColor = [UIColor grayColor];
    _sectionTitle.textAlignment = NSTextAlignmentLeft;
    _sectionTitle.font = [UIFont systemFontOfSize:14.0f];
    _sectionTitle.text = @"      质检过的电商";
    
    return _sectionTitle;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return .01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_StoreListArr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //初始化每行的数据模型
    StoreModel * Model = _StoreListArr[indexPath.row];
    

    static NSString * cellID = @"storeTableViewCell";
    StoreTableViewCell * cell = [_storeTableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[StoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    
        
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.StoreModel = Model;
    
    
    
    return cell;
}

#pragma Collection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (section==0) {
        return [_ImageArr count];
    }else
    return [_videoArr count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ZhengpinDetailCollectionViewCell * cell = (ZhengpinDetailCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ZhengpinDetailCollectionViewCell" forIndexPath:indexPath];
    
   if(indexPath.section==0)
   {
       NSString * imageURL = _ImageArr [indexPath.item];
       NSURL * imageUrl = [NSURL URLWithString:imageURL];
       [cell.imageView sd_setImageWithURL:imageUrl];
       
       cell.imageView.userInteractionEnabled = YES;
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImgViewClick:)];
       cell.imageView.tag = 5000+indexPath.item;
       [cell.imageView addGestureRecognizer:tap];
       
   }else if(indexPath.section==1)
   {
       
       cell.imageView.backgroundColor = RGBACOLOR(50, 50, 50, .8);
       cell.backgroundColor = [UIColor clearColor];
       [cell.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"playbutton"]];
   }
    
 
    
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
    return UIEdgeInsetsMake(2,20,10,20);
}
#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==1) {
   
        NSString * videoUrl = _videoArr[indexPath.item];
        NSURL * VideoURL = [NSURL URLWithString:videoUrl];
        if(_delegate){
            [_delegate playWithUrl:VideoURL];
        }

    }
        
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
