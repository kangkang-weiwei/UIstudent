//
//  ZHDCommentWriteView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/26.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentWriteView.h"

@implementation ZHDCommentWriteView

-(void)commentWriteViewInit{
    
    //topView
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    topView.backgroundColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 64, 64)];
    [_backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [topView addSubview:_backButton];
    _backButton.tag = 0;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, 10, 100, 64)];
    titleLabel.text = @"写点评";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    _releaseButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 64, 10, 64, 64)];
    [topView addSubview:_releaseButton];
    [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
    _releaseButton.tag = 1;
    
    [self addSubview:topView];
    
    _placehoderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 73, [UIScreen mainScreen].bounds.size.width, 50)];
    _placehoderLabel.numberOfLines = 0;
    _placehoderLabel.text = @" 不友善言论会被删除，深度讨论会被优化先展示。";
    _placehoderLabel.font = [UIFont systemFontOfSize:20];
    _placehoderLabel.textColor = [UIColor grayColor];
    [self addSubview:_placehoderLabel];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    [_textView setFont:[UIFont systemFontOfSize:20]];
}

@end
