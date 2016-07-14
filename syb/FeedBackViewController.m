//
//  FeedBackViewController.m
//  syb
//
//  Created by GX on 15/10/29.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "FeedBackViewController.h"

@implementation FeedBackViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"意见反馈";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [MobClick beginLogPageView:@"意见反馈"];
  
    [self setTabBarHide:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
    [MobClick endLogPageView:@"意见反馈"];
 
 
}


-(void)SubmitButtonClick:(UIButton*)sender
{
    NSString * content;
    content  = [Tv.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([content length] ==0) {
        [HDHud showMessageInView:self.view title:@"您还未输入任何意见"];
    }else if ([content length]>100) {
        [HDHud showMessageInView:self.view title:@"内容不能超过100字"];
    }else
    {
           NSString * usernumber;
        if (!userSession) {
            userSession = [SybSession sharedSession];
        }
           if ([Tf.text length]==0) {
               usernumber = userSession.userName;
            }else
           {
               
                 usernumber = Tf.text  ;
             }

         NSDictionary * postDict = [NSDictionary dictionaryWithObjectsAndKeys:Tv.text,@"content",@"2",@"type",usernumber,@"user_number",nil];
        
        
            [HDHud showHUDInView:self.view title:@"提交中..."];
        
        
        
        GXHttpRequest *request = [[GXHttpRequest alloc]init];
        
        [request RequestDataWithUrl:URL_FeedBack pragma:postDict];
        
        [request getResultWithSuccess:^(id response) {
            /// 加保护
            if ([response isKindOfClass:[NSDictionary class]])
            {
                
                //加载框消失
                [HDHud hideHUDInView:self.view];
                
                _dict = [NSMutableDictionary dictionaryWithDictionary:response];
                NSLog(@"&&&&%@",_dict);
                NSString * result = [_dict valueForKey:@"code"];
                NSString * message = [_dict valueForKey:@"message"];
                
                if ([result isEqualToString:@"1"]) {
                    
                    [HDHud showMessageInView:self.view title:@"提交成功"];
                    [self performSelector:@selector(backMine) withObject:nil afterDelay:1.5];
                    
                    
                }else if([result isEqualToString:@"0"])
                {
                    
                    [HDHud showMessageInView:self.view title:message];
                    
                }
                
                
            }
            
        } DataFaiure:^(id error) {
             [HDHud hideHUDInView:self.view];
            [HDHud showMessageInView:self.view title:error];
        } Failure:^(id error) {
            [HDHud hideHUDInView:self.view];
            [HDHud showNetWorkErrorInView:self.view];
        }];
        
        

    
            
        }

   
}

//初始化相关控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initTableView];

    [self showBackButton:YES];
    
    [self setNavTitle:@"意见反馈"];
}
-(void)initTableView
{
    if(!TableView)
    {
        TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        TableView.delegate = self;
        TableView.dataSource = self;
        TableView.backgroundColor =  kDefaultBackgroundColor;
        TableView.scrollEnabled = NO;
        [self.view addSubview:TableView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0) {
        return 120;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 9.9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell * cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    switch (indexPath.section) {
        case 0:
        {
            UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 30)];
            [topView setBarStyle:UIBarStyleDefault];
            UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
            NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
            [topView setItems:buttonsArray];
            
            
            Tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 120)];
            Tv.textColor = [UIColor blackColor];
            Tv.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
            Tv.delegate = self;
            Tv.backgroundColor = [UIColor clearColor];
            Tv.returnKeyType = UIReturnKeyDefault;
            Tv.keyboardType = UIKeyboardTypeDefault;
            Tv.scrollEnabled = NO;
            Tv.editable = YES;
            Tv.backgroundColor = [UIColor clearColor];
            Tv.contentInset = UIEdgeInsetsMake(0, 5, 0, 0);
            [Tv setInputAccessoryView:topView];
            [Tv becomeFirstResponder];
            [cell.contentView addSubview:Tv];
            
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, VIEW_MAXY(Tv)-21, 100, 20)];
            label1.text = [NSString stringWithFormat:@"0/100字"];
            label1.textColor = ThemeColor;
            label1.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
            label1.textAlignment = NSTextAlignmentRight;
            label1.backgroundColor = [UIColor clearColor];
            [cell.contentView  addSubview:label1];
            
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(25,5, SCREEN_WIDTH-50, 20)];
            label2.text = @"请输入您的意见，我们将不断优化体验";
            label2.textColor = [UIColor grayColor];
            label2.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
            label2.textAlignment = NSTextAlignmentLeft;
            label2.backgroundColor = [UIColor clearColor];
            [cell.contentView  addSubview:label2];
        }
            break;
         case 1:
        {
            UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 30)];
            [topView setBarStyle:UIBarStyleDefault];
            UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
            NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
            [topView setItems:buttonsArray];
            
            Tf = [[CustomTextField alloc]initWithFrame:CGRectMake(20, 12, SCREEN_WIDTH-40, 20)];
            Tf.textColor = [UIColor blackColor];
            Tf.placeholder = @"请输入你的手机号/QQ号等(选填)";
            Tf.clearButtonMode = UITextFieldViewModeWhileEditing;
            Tf.autocorrectionType = UITextAutocorrectionTypeNo;
            Tf.keyboardType = UIKeyboardTypeNumberPad;
            Tf.returnKeyType = UIReturnKeyDefault;
            Tf.delegate = self;
            Tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
            [Tf setInputAccessoryView:topView];
            [cell.contentView addSubview:Tf];
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}
-(void)dismissKeyBoard
{
    [Tv resignFirstResponder];
    [Tf resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}
-(BOOL)textView:(UITextView *)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [Tv resignFirstResponder];
        return YES;
    }
    if([[Tv text] length]>100){
        return NO;
    }
    //判断是否为删除字符，如果为删除则让执行
    char c=[text UTF8String][0];
    
    if (c=='\000') {
        _count = [[Tv text] length]-1;
        if(_count ==-1){
            _count =0;
        }
        if(_count ==0)
        {
            label2.hidden=NO;//隐藏文字
        }else{
            label2.hidden=YES;
        }
        label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
        return YES;
    }
    if([[Tv text] length]==100) {
        if(![text isEqualToString:@"\b"])
            return NO;
    }
    _count =[[Tv text] length]-[text length]+2;
    if(_count ==0)
    {
        label2.hidden=NO;//隐藏文字
    }else{
        label2.hidden=YES;
    }
    label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _count = [[Tv text] length];
    label1.text = [NSString stringWithFormat:@"%ld/100字",(long)_count];
}

//去掉输入的前后空格
-(NSString *)removespace:(UITextField *)textfield {
    return [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [Tv resignFirstResponder];
    [Tf resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);

    
}
#pragma tf delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [Tv resignFirstResponder];
    [Tf resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
    
    return YES;
}
-(void)backMine
{
    NSInteger index = [[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:index-1] animated:YES];
}

@end
