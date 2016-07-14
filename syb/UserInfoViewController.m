//
//  UserInfoViewController.m
//  syb
//
//  Created by GX on 15/10/23.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "UserInfoViewController.h"
#import "GeneralTextFiledViewController.h"
#import "IntroductionViewController.h"
@implementation UserInfoViewController
- (id)init
{
    self = [super init];
    if (self) {
       self.title = @"个人资料";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self PageSetup];
    [self initBackButton];
     [MobClick beginLogPageView:@"个人资料"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideTabbarButton" object:@YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [backButton removeFromSuperview];
    [saveButton removeFromSuperview];
    [MobClick endLogPageView:@"个人资料"];
 
}
//页面设置的相关方法
-(void)PageSetup
{
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGColor;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
}
-(void)initBackButton
{
    if(!backButton)
    {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    [self.navigationController.navigationBar addSubview:backButton];
    
    if (!saveButton) {
        saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(SCREEN_WIDTH-54, 0, 44, 44);
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton setTitleColor:ThemeColor forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navigationController.navigationBar addSubview:saveButton];
  
}
-(void)backButtonClick:(UIButton*)sender
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}
-(void)saveButtonClick:(UIButton*)sender
{
    UILabel * label1 = (UILabel*)[self.view viewWithTag:1001];
    UILabel * label2 = (UILabel*)[self.view viewWithTag:1002];
    UILabel * label3 = (UILabel*)[self.view viewWithTag:1003];
    UILabel * label4 = (UILabel*)[self.view viewWithTag:1004];
    UILabel * label5 = (UILabel*)[self.view viewWithTag:1005];
    UILabel * label6 = (UILabel*)[self.view viewWithTag:1006];
    NSLog(@"%@_______%@_______%@______%@_______%@_______%@______%@",_imgData,label1.text,label2.text,label3.text,label4.text,label5.text,label6.text);

    NSString * sex;
    NSString * babysex;
    
    if ([label2.text isEqualToString:@"男"] ) {
        sex = @"1";
    }else if ([label2.text isEqualToString:@"女"] )
    {
        sex = @"2";
    }
    
    if ([label5.text isEqualToString:@"男"] ) {
        
        babysex = @"1";
    }else if ([label2.text isEqualToString:@"女"] )
    {
        babysex = @"2";
    }
    
    
    [UIView animateWithDuration:.1 animations:^{
        DPView.frame=CGRectMake(DPView.frame.origin.x,SCREEN_HEIGHT, DPView.frame.size.width, DPView.frame.size.height);
        DPView.alpha = 1;
        _showDP = NO;
         }];

    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:label1.text,@"nickname",sex,@"sex",label3.text,@"user_desc",label4.text,@"baby_name",babysex,@"baby_sex",label6.text,@"baby_birthday", nil];
        NSLog(@"%@",postDict);
        [HDHud showHUDInView:self.view title:@"修改中..."];
        
        GXHttpRequest * request = [[GXHttpRequest alloc]init];
        [request StartWorkPostWithurlstr:URL_ChangeUserInfo pragma:postDict ImageData:_imgData];
        request.successGetData = ^(id obj){
            //加载框消失
            [HDHud hideHUDInView:self.view];
            
            NSString * code = [obj valueForKey:@"code"];
            NSString * message = [obj valueForKey:@"message"];
            
            if ([code isEqualToString:@"1"]) {
                
                [HDHud showMessageInView:self.view title:message];
                [self saveUserInfo:[obj valueForKey:@"result"]];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"userLogin" object:[obj valueForKey:@"result"]];
                
                [self performSelector:@selector(backMine) withObject:nil afterDelay:1.5];
                
            }else if ([code isEqualToString:@"0"])
            {
                [HDHud showMessageInView:self.view title:message];
            }
            
            
        };
        request.failureGetData = ^(void){
            
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        };
        
}

-(void)saveUserInfo:(NSMutableDictionary*)dict
{
    NSLog(@"……………………^_^ %@",dict);

    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_name"] forKey:@"user_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_photo"] forKey:@"user_photo"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"nickname"] forKey:@"nickname"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"birthday"] forKey:@"birthday"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"sex"] forKey:@"sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"app_money"] forKey:@"user_money"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"user_desc"] forKey:@"user_desc"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_name"] forKey:@"baby_name"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_sex"] forKey:@"baby_sex"];
    [UserDefaultsUtils saveValue:[dict valueForKey:@"baby_birthday"] forKey:@"baby_birthday"];
    
    
    //单例取值
    SM = [SingleManage shareManage];
    SM.userName = [UserDefaultsUtils valueWithKey:@"user_name"];
    SM.imageURL = [UserDefaultsUtils valueWithKey:@"user_photo"];
    SM.nickName  = [UserDefaultsUtils valueWithKey:@"nickname"];
    SM.birthday = [UserDefaultsUtils valueWithKey:@"birthday"];
    SM.userSex = [UserDefaultsUtils valueWithKey:@"sex"];
    SM.userMoney = [UserDefaultsUtils valueWithKey:@"user_money"];
    SM.userdesc = [UserDefaultsUtils valueWithKey:@"user_desc"];
    SM.babyName = [UserDefaultsUtils valueWithKey:@"baby_name"];
    SM.babySex = [UserDefaultsUtils valueWithKey:@"baby_sex"];
    SM.babyBirthday = [UserDefaultsUtils valueWithKey:@"baby_birthday"];
    SM.isLogin = YES;

}

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _showDP = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nickNameChange:) name:@"nickNameChange" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(babyNameChange:) name:@"babyNameChange" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(introduceChange:) name:@"introduceChange" object:nil];
    [self initSM];
    [self setlayout];
    
}
-(void)nickNameChange:(NSNotification*)notification
{
    id obj = [notification object];
    _nickName = [NSString stringWithFormat:@"%@",obj];
    [table reloadData];
}
-(void)babyNameChange:(NSNotification*)notification
{
    id obj = [notification object];
    _babyName = [NSString stringWithFormat:@"%@",obj];
    [table reloadData];
    
}
-(void)introduceChange:(NSNotification*)notification
{
    id obj = [notification object];
    _userdesc = [NSString stringWithFormat:@"%@",obj];
    [table reloadData];
}
-(void)initSM
{
    SM = [SingleManage shareManage];
    
    _userphoto = [NSString stringWithFormat:@"%@",SM.imageURL];
    _nickName  = SM.nickName;
    _userSex   = SM.userSex;
    _babyName = SM.babyName;
    _babySex  = SM.babySex;
    _babyBirthDay   = SM.babyBirthday;
    _userdesc = SM.userdesc;
    
    
}
-(void)setlayout
{
  
    if(!table)
    {
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)style:UITableViewStyleGrouped];
        table.delegate = self;
        table.dataSource = self;
        table.scrollEnabled = YES;
        [self.view addSubview:table];
    
    }else
    {
        [table reloadData];
    }

    [self InitDPView];
}

-(void)InitDPView
{
    if (!DPView) {
        DPView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 240)];
        DPView.backgroundColor = [UIColor whiteColor];
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,216)];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        // 设置当前显示时间
        
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [DPView addSubview:datePicker];
        
        
        UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        OKBtn.backgroundColor = ThemeColor;
        [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
        OKBtn.frame = CGRectMake(SCREEN_WIDTH/2-80, 200, 160,35);
        OKBtn.layer.cornerRadius = 5.;
        [OKBtn addTarget:self action:@selector(OKBtnPress) forControlEvents:UIControlEventTouchUpInside];
        [DPView addSubview:OKBtn];
        
        [self.view addSubview:DPView];
        
    }
   
    
    
}


#pragma TabelView 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0) {
        return 64;
    }else if(indexPath.section==1&&indexPath.row==2)
    {
        UITableViewCell *cell =(UITableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        UILabel *lable = (UILabel *)[cell viewWithTag:1003];
        return CGRectGetHeight(lable.frame)+54;
    }else
        return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0) {
        return 1;
    }else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 120, 20)];
        cellTitle.backgroundColor = [UIColor clearColor];
        cellTitle.textColor = [UIColor grayColor];
        cellTitle.textAlignment = NSTextAlignmentLeft;
        cellTitle.font = [UIFont systemFontOfSize:14.0f];
        [cell.contentView addSubview:cellTitle];

        cellContent = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, SCREEN_WIDTH-160, 20)];
        cellContent.backgroundColor = [UIColor clearColor];
        cellContent.textColor = [UIColor blackColor];
        cellContent.textAlignment = NSTextAlignmentRight;
        cellContent.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:cellContent];
        
    }
    
    SM = [SingleManage shareManage];
    
    switch (indexPath.section) {
        case 0:
        {
            cellTitle.frame = CGRectMake(20, 22, 80, 20);
            cellTitle.text = @"头像";
            
            cellContent.hidden = YES;
            
            userPhoto = [[UIImageView alloc]init];
            userPhoto.frame = CGRectMake(SCREEN_WIDTH-85, 4, 56, 56);
            userPhoto.layer.masksToBounds = YES;
            userPhoto.layer.cornerRadius = 28;
            userPhoto.layer.borderColor = RGBACOLOR(170, 178, 182, 1).CGColor;
            userPhoto.layer.borderWidth = 1;
            
            if (!_upload_image) {
                
                if ([_userphoto isEmpty]) {
                    userPhoto.image = [UIImage imageNamed:@"face"];
                }else
                {
                    NSString * imageURL = _userphoto;
                    NSString * photoImage = [NSString stringWithFormat:@"%@",imageURL];
                    NSURL * photoURL = [NSURL URLWithString:photoImage];
                    [userPhoto sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"face"]];
                }
                
              
            }else
            {
                userPhoto.image = _upload_image;
            }
        
            [cell.contentView addSubview:userPhoto];
            
        }
            break;
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cellTitle.text = @"昵称";
                    cellContent.text = _nickName;
                    cellContent.tag = 1001;

                }
                    break;
                    case 1:
                {
                    cellTitle.text = @"性别";
         
                    
                    if ([_userSex isEqualToString:@"1"]) {
                        cellContent.text = @"男";
                        
                    }else if ([_userSex isEqualToString:@"2"])
                    {
                         cellContent.text = @"女";
                    }
                    
                    cellContent.tag = 1002;
                 
                    
                }
                    break;
                    case 2:
                {
                    cellTitle.text = @"自我介绍";
            
                    cellContent.frame = CGRectMake(30, 44, SCREEN_WIDTH-60, 20);
                    cellContent.text = _userdesc;
                    cellContent.numberOfLines = 0 ;
                    cellContent.tag = 1003;
                    [cellContent sizeToFit];
            
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cellTitle.text = @"宝贝昵称";
                    cellContent.text = _babyName;
                    cellContent.tag = 1004;
            
                }
                    break;
                    case 1:
                {
                    cellTitle.text = @"宝贝性别";
                    
                    if ([_babySex isEqualToString:@"1"]) {
                        cellContent.text = @"男";
                    }else if([_babySex isEqualToString:@"2"])
                    {
                         cellContent.text = @"女";
                    }
                    
                    cellContent.tag = 1005;
                    
                }
                    break;
                    case 2:
                {
                 
                     cellTitle.text = @"宝贝生日/预产期";
                    
                     cellContent.text = _babyBirthDay;
                    
                    cellContent.tag = 1006;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
        {
            as1 =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
            as1.delegate = self;
            as1.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            as1.tag = 2001;
            [as1 showInView:self.view];
        }
            break;
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    GeneralTextFiledViewController * genralTextFiledVc = [[GeneralTextFiledViewController alloc]init];
                    genralTextFiledVc.title = @"昵称";
                    genralTextFiledVc.TFtype = @"昵称";
                    UINavigationController * genralTextFiledNc = [[UINavigationController alloc]initWithRootViewController:genralTextFiledVc];
                    [self.navigationController presentViewController:genralTextFiledNc animated:YES completion:nil];
           
                }
                    break;
                    case 1:
                {
                    as2 =[[UIActionSheet alloc] initWithTitle:@"性别修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
                    as2.delegate = self;
                    as2.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                    as2.tag = 2002;
                    [as2 showInView:self.view];
                }
                    break;
                    case 2:
                {
                    IntroductionViewController * introductionVC = [[IntroductionViewController alloc]init];
                    introductionVC.title = @"自我介绍";
                    UINavigationController * introductionNC = [[UINavigationController alloc]initWithRootViewController:introductionVC];
                    [self.navigationController presentViewController:introductionNC animated:YES completion:nil];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    GeneralTextFiledViewController * genralTextFiledVc = [[GeneralTextFiledViewController alloc]init];
                    genralTextFiledVc.title = @"宝贝昵称";
                    genralTextFiledVc.TFtype = @"宝贝昵称";
                    UINavigationController * genralTextFiledNc = [[UINavigationController alloc]initWithRootViewController:genralTextFiledVc];
                    [self.navigationController presentViewController:genralTextFiledNc animated:YES completion:nil];
                    
                }
                    break;
                case 1:
                {
                    as3 =[[UIActionSheet alloc] initWithTitle:@"性别修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
                    as3.delegate = self;
                    as3.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                    as3.tag = 2003;
                    [as3 showInView:self.view];
                }
                    break;
                case 2:
                {
                    if(_showDP==NO){
                        [self ShowDatePicker];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==2001) {
        UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"点击了照相");
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
                    {
                        //无权限
                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                    }else{
                        UIImagePickerController *imgpicker = [[UIImagePickerController alloc]init];
                        imgpicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                        imgpicker.allowsEditing = YES;
                        imgpicker.delegate = self;
                        [self presentViewController:imgpicker animated:YES completion:nil];
                    }
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"本设备不支持相机模式" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
                break;
            case 1:{
                NSLog(@"相册");
                ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
                if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
                {
                    //无权限
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请先在隐私中设置相册权限" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }else{
                    imgpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    imgpicker.allowsEditing = YES;
                    imgpicker.delegate = self;
                    
                    [self presentViewController:imgpicker animated:YES completion:nil];
                }
            }
                break;
                
            case 2:
                NSLog(@"取消");
                [as1 setHidden:YES];
                break;
            default:
                break;
        }
        
        
        
    }else if(actionSheet.tag == 2002)
    {
        switch (buttonIndex) {
            case 0:
            {
                
                UILabel * label = (UILabel*)[self.view viewWithTag:1002];
                label.text = @"男";
                _userSex = @"1";
            }
                break;
            case 1:
            {
                UILabel * label = (UILabel*)[self.view viewWithTag:1002];
                label.text = @"女";
                _userSex = @"2";
            }
                break;
            default:
                break;
        }
        
    }else if(actionSheet.tag == 2003)
    {
        switch (buttonIndex) {
            case 0:
            {
                
                UILabel * label = (UILabel*)[self.view viewWithTag:1005];
                label.text = @"男";
                _babySex = @"1";
            }
                break;
            case 1:
            {
                UILabel * label = (UILabel*)[self.view viewWithTag:1005];
                label.text = @"女";
                _babySex = @"2";
            }
                break;
            default:
                break;
        }
        
    }
    
    
    
}

#pragma mark imagePickerController methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0,3_0)
{
    self.upload_image = image;
    [userPhoto setImage:image];
    _imgData = UIImageJPEGRepresentation(_upload_image, 1.0);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.upload_image = image;
    [userPhoto setImage:image];
    _imgData = UIImageJPEGRepresentation(_upload_image, 1.0);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)ShowDatePicker
{
    
 
    if (DPView.frame.origin.y==SCREEN_HEIGHT) {
        
        [UIView animateWithDuration:.1 animations:^{
            DPView.frame = CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, 240);
            DPView.alpha = 1;
            _showDP = YES;
        
        }];
        
    }else{
        [UIView animateWithDuration:.1 animations:^{
            [UIView animateWithDuration:.1 animations:^{
                DPView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 240);
                DPView.alpha = 1;
                _showDP = NO;
                
            }];
        }];
    }
}

-(void)OKBtnPress
{
    [self PanduanTimeisRight];
}


-(void)datePickerValueChanged:(UIDatePicker *)picker
{
    [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    _PickerDate = [picker date];
    NSString * str = [NSString stringWithFormat:@"%@",_PickerDate];
    _babyBirthDay = [str substringToIndex:10];
    
    NSLog(@"^^^^^^^%@",_babyBirthDay);
}
-(void)PanduanTimeisRight
{
  
    UILabel * label = (UILabel*)[self.view viewWithTag:1006];
    label.text = _babyBirthDay;
    [self ShowDatePicker];

}
-(void)backMine
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
