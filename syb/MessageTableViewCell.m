//
//  MessageTableViewCell.m
//  syb
//
//  Created by GX on 15/11/7.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setMessageModel:(MessageModel *)messageModel
{
    _messageModel = messageModel;
    
    _messageTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 140, 20)];
    _messageTitle.font = [UIFont systemFontOfSize:16];
    _messageTitle.text = messageModel.message_title;
    [self.contentView addSubview:_messageTitle];
    
    
    _message_desc = [[UILabel alloc]initWithFrame:CGRectMake(20, 37, SCREEN_WIDTH-40, 60)];
    _message_desc.font = [UIFont systemFontOfSize:14];
    _message_desc.textColor = RGBACOLOR(155.0,155.0,155.0,1.0);
    _message_desc.text = messageModel.message_desc;
    _message_desc.numberOfLines = 3;

    [self.contentView addSubview:_message_desc];
    
    
    _messageTime = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-95, 10, 80, 20)];
    _messageTime.textColor = RGBACOLOR(155.0,155.0,155.0,1.0);
    _messageTime.font = [UIFont systemFontOfSize:14];
    NSString * time =  [TimeTool timePrToTime:messageModel.send_time];
    _messageTime.text = time;
    _messageTime.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_messageTime];
    
    
    
}
@end
