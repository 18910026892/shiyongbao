//
//  MobilePhoneRechargeViewController.m
//  syb
//
//  Created by 庞珂路 on 16/7/16.
//  Copyright © 2016年 spyg. All rights reserved.
//

#import "MobilePhoneRechargeViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface MobilePhoneRechargeViewController ()<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    ABPeoplePickerNavigationController *picker;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *phoneType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (nonatomic,copy)NSString *name;
@property (strong,nonatomic) NSMutableArray *people;
@end

@implementation MobilePhoneRechargeViewController
{
    SybSession *user;
    
}
-(NSMutableArray *)people
{
    if (!_people) {
        _people = [NSMutableArray array];
    }
    return _people;
}
- (BOOL)isNum:(NSString *)checkedNumString {
    
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self accessTheAddress];
    user = [SybSession sharedSession];
    self.phoneTF.text = [self changeString:user.userName];
    self.name = @"账户绑定账号";
    self.phoneType.text = self.name;
    
    [self requestPhoneType:user.userName];
    // Do any additional setup after loading the view from its nib.
     self.automaticallyAdjustsScrollViewInsets = YES;
    [self showBackButton:YES];
    [self setNavTitle:@"充话费"];
}
- (NSString *)changeString:(NSString *)phoneNumber
{
    if (phoneNumber.length<11) {
        return nil;
    }
    
    NSString *firstString = [phoneNumber substringWithRange:NSMakeRange(0, 3)];
    NSString *middleString = [phoneNumber substringWithRange:NSMakeRange(3, 4)];
    NSString *finalString = [phoneNumber substringWithRange:NSMakeRange(7, 4)];
    
    return [NSString stringWithFormat:@"%@ %@ %@",firstString,middleString,finalString];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
   
    [self setUpUI];
}
- (void)setUpUI
{
    self.contentViewWidth.constant = [UIScreen mainScreen].bounds.size.width;
    self.bottomLine.constant = 0.5;
}
#pragma mark - BookDelegate
- (IBAction)bookAddress:(UIButton *)sender
{
    
    picker = [[ABPeoplePickerNavigationController alloc]init];
    
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//由于在ios6以后对用户信息提供了安全的保护，在获取前必须要通过用户的同意才行
- (void)accessTheAddress
{
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
            NSLog(@"这里是用户选择是否允许后的执行代码");
        });
    }
    else{
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获取通讯录中的所有人
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        //通讯录中人数
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        for (int i = 0; i<nPeople; i++) {
            //获取个人
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            CFStringRef abFullName = ABRecordCopyCompositeName(person);
            NSString *key = (__bridge NSString *)abFullName;
            if (!key) {
                continue;
            }
            //获取当前联系人的所有电话
            NSMutableArray *pensonPhones = [NSMutableArray array];
            ABMultiValueRef phones= ABRecordCopyValue(person, kABPersonPhoneProperty);
            for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
                NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
                NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                               invertedSet ];
                NSString *strPhone = [[phone componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
                [pensonPhones addObject:strPhone];
            }
            
            NSDictionary *peopleInfo = @{key:pensonPhones};
            [self.people addObject:peopleInfo];
        }
    });
    
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker

{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//ios8之后弃用;
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person

{
    
    return YES;
    
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier

{
    
    //联系人姓名
    
    NSString * name = (__bridge NSString *)ABRecordCopyCompositeName(person);
//    NSString * place = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //判断点击区域
    
    if (property == kABPersonPhoneProperty) {
        
        //取出当前点击的区域中所有的内容
        
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        //根据点击的哪一行对应的identifier取出所在的索引
        
        int index = ABMultiValueGetIdentifierAtIndex(phoneMulti, identifier);
        
        //根据索引把相应的值取出
        
        NSString * phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        if ([phone containsString:@"-"]) {
            phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        //        NSString * phone2 = [self isMobileNumber:phone];
        
        if ([phone isEqualToString:@"无"]) {
            
            
        }else{
            NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                           invertedSet ];
            NSString *strPhone = [[phone componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
            if (strPhone.length!=11) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"号码格式有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [av show];
                return NO;
            }
            //            NSString * myStr = [NSString stringWithFormat:@"%@%@",phone,name];
           
            self.phoneTF.text = [self changeString:strPhone];
            self.name = name;
            self.phoneType.text = name;
            [self requestPhoneType:strPhone];
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
    
    
    
}
- (void)getAllPeople
{
    
}
//获取联系人姓名(8.0)后可以使用;
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    NSString * name = (__bridge NSString *)ABRecordCopyCompositeName(person);
    if (property == kABPersonPhoneProperty) {
        
        ABMutableMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        //根据电机的哪一行对应的identifier取出所在的索引
        
        int index = ABMultiValueGetIdentifierAtIndex(phone, identifier);
        
        NSString * thePhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
        if ([thePhone containsString:@"-"]) {
            thePhone = [thePhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        //        NSString * phone2 = [self isMobileNumber:thePhone];
        //        NSLog(@"%@",phone2);
        NSString * myStr;
        if ([thePhone isEqualToString:@"无"]) {
        }else{
            myStr = [NSString stringWithFormat:@"%@%@",thePhone,name];
            //            completion(thePhone);
            NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                           invertedSet ];
            NSString *strPhone = [[thePhone componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
            if (strPhone.length!=11) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"号码格式有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [av show];
                return;
            }
            self.phoneTF.text = [self changeString:strPhone];
            self.name = name;
            self.phoneType.text = name;
            [self requestPhoneType:strPhone];
        }
        
    }
}

#pragma mark - end BookDelegate
#pragma mark - TFDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString* result = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (textField.text.length==13&&result.length!=0) {
        return NO;
    }
    self.name = nil;
    self.phoneType.text = @"";
    if ((textField.text.length==3||textField.text.length==8)&&result.length!=0) {
        if (string.length!=0) {
            textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
        }
        return YES;
    }
    
    if ((textField.text.length==10||textField.text.length==5)&&result.length==0) {
        NSString *textString = textField.text;
        textField.text = [textString substringWithRange:NSMakeRange(0, textString.length-1)];
    }
    
    if (textField.text.length==12&&result.length!=0) {
        [self findPeopleInBook:[NSString stringWithFormat:@"%@%@",textField.text,result]];
    }
    return YES;
}
#pragma mark - end TFDelegate
- (void)findPeopleInBook:(NSString *)phone
{
   __block NSString *changString = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([changString isEqualToString:user.userName]) {
        self.name = @"账户绑定账号";
        [self requestPhoneType:phone];
        return;
    }
    [self.people enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *people = obj;
        NSString *name = [[people allKeys]lastObject];
        NSArray *phones = people[name];
        if ([phones containsObject:changString]) {
            self.name = name;
            *stop = YES;
        }
        
    }];
    if (!self.name) {
        self.name = @"不在通讯录";
    }
    [self requestPhoneType:phone];
}
- (void)requestPhoneType:(NSString *)phoneNumber
{
    
    NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:@"phone",phoneNumber,nil];
    
    GXHttpRequest *request = [[GXHttpRequest alloc]init];
    
    [request RequestDataWithUrl:URL_GetMobileTelInfo pragma:postDict];
    
    [request getResultWithSuccess:^(id response) {
        /// 加保护
        if ([response isKindOfClass:[NSDictionary class]])
        {
            
            NSLog(@" %@",response);
#warning 手机归属地
            self.phoneType.text = [NSString stringWithFormat:@"%@(%@)",self.name,@"中国联通"];
        }
        
    } DataFaiure:^(id error) {
        
    } Failure:^(id error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
