//
//  ZHDCommentView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentView.h"
#import "ZHDCommentUnderView.h"

@implementation ZHDCommentView{
    
}

-(void)commentViewInit{
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - self.frame.size.height * 0.058) style:UITableViewStyleGrouped];
    _tableview.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self addSubview:_tableview];
    
    CGFloat underViewHeight = self.frame.size.height * 0.058;
    _commentUnderView = [[ZHDCommentUnderView alloc]initWithFrame:CGRectMake(0 ,[UIScreen mainScreen].bounds.size.height - underViewHeight , [UIScreen mainScreen].bounds.size.width, underViewHeight)];
    _commentUnderView.backgroundColor = [UIColor colorWithRed:0.23f green:0.21f blue:0.22f alpha:1.00f];;
    [_commentUnderView commentUnderViewInit];
    [self addSubview:_commentUnderView];
    
    _commentTopView = [[ZHDCommentTopView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [_commentTopView TopViewInit];
    [self addSubview:_commentTopView];
}

@end
