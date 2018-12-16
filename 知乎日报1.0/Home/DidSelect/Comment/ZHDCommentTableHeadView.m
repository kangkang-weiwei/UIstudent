//
//  ZHDCommentTableHeadView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/8.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentTableHeadView.h"

@implementation ZHDCommentTableHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor orangeColor];
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 50)];
        [self addSubview:_headLabel];
    }
    return self;
}

@end
