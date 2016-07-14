//
//  UserInfoViewController.h
//  syb
//
//  Created by GX on 15/10/23.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <UIImageView+WebCache.h>
@interface UserInfoViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton * backButton;
    UIButton * saveButton;
    
    SingleManage * SM;
    UIBarButtonItem * right;
    UITableView * table;
    UIImageView * userPhoto;
    UILabel * cellTitle;
    UILabel * cellContent;

    //相册拍照选择 男女选择
    UIActionSheet * as1;
    UIActionSheet * as2;
    UIActionSheet * as3;
    
    UIView * DPView;
    UIDatePicker *datePicker;
    
    
}

@property BOOL showDP;

//用户提交上传的图片二进制
@property (nonatomic,copy)NSString * userphoto;

@property (strong,nonatomic)UIImage * upload_image;
@property (nonatomic,strong)NSData * imgData;

//昵称
@property (nonatomic,copy)NSString * nickName;

//用户性别
@property (nonatomic,copy)NSString * userSex;

//用户自我介绍

@property(nonatomic,copy)NSString * userdesc;

//宝宝昵称
@property (nonatomic,copy)NSString * babyName;

//宝宝生日
@property (nonatomic,strong)NSDateFormatter *dateFormatter;
@property (nonatomic,copy)NSString * babyBirthDay;
@property (nonatomic,strong)NSDate *PickerDate;;

//宝宝性别
@property (nonatomic,copy)NSString * babySex;

@end
