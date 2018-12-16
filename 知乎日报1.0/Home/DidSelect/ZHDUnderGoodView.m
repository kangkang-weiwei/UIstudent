//
//  ZHDUnderGoodView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/2.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDUnderGoodView.h"

@implementation ZHDUnderGoodView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"duihuakuang2.png"];
        
        _goodNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [imageView addSubview:_goodNumberLabel];
        _goodNumberLabel.textAlignment = NSTextAlignmentCenter;
        _goodNumberLabel.textColor = [UIColor whiteColor];
        _goodNumberLabel.text = @"123";
    }
    return self;
}

@end
