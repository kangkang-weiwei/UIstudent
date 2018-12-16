//
//  ZHDCommentTableFootView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/8.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentTableFootView.h"

@implementation ZHDCommentTableFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        _footerButton.backgroundColor = [UIColor orangeColor];
        [self addSubview:_footerButton];
        
        _footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 50)];
        [_footerButton addSubview:_footLabel];
        
        _footViewButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 2 / 3, 0, [UIScreen mainScreen].bounds.size.width / 2, 50)];
        [_footerButton addSubview:_footViewButton];
        [_footViewButton setImage:[UIImage imageNamed:@"zhankai.png"] forState:UIControlStateNormal];
        [_footViewButton setImage:[UIImage imageNamed:@"shouqi.png"] forState:UIControlStateSelected];
    }
    return self;
}

@end
