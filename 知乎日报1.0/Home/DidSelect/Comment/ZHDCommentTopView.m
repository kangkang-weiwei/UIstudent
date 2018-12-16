//
//  ZHDCommentTopView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/24.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentTopView.h"

@implementation ZHDCommentTopView

-(void)TopViewInit{
    _commentTopLabl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _commentTopLabl.backgroundColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    _commentTopLabl.textAlignment = NSTextAlignmentCenter;
    _commentTopLabl.textColor = [UIColor whiteColor];
    [self addSubview:_commentTopLabl];
}

@end
