//
//  ZHDNewDidSelectView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/30.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDNewDidSelectView.h"
#import <WebKit/WebKit.h>
#import "ZHDNewUnderView.h"
#import "ZHDUnderUploadView.h"
#import "ZHDUnderGoodView.h"

@implementation ZHDNewDidSelectView{
    CGFloat labelHeight;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    labelHeight = [UIScreen mainScreen].bounds.size.height * 0.06;
    NSLog(@"%f",labelHeight);
    if (self = [super initWithFrame:frame]) {
        
        _activiIndictorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _activiIndictorView.center = self.center;
        _activiIndictorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_activiIndictorView];
        [_activiIndictorView startAnimating];
        [self activiIndictorView];
        
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - labelHeight)];
        _wkWebView.autoresizingMask = YES;
        [self addSubview:_wkWebView];
        
        _underGoodView = [[ZHDUnderGoodView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 2 / 5, [UIScreen mainScreen].bounds.size.height - labelHeight , [UIScreen mainScreen].bounds.size.width / 5, labelHeight)];
        [self addSubview:_underGoodView];
        
        _underView = [[ZHDNewUnderView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - labelHeight, self.frame.size.width, labelHeight)];
        [_underView initView];
        [self addSubview:_underView];
        
        _upLoadView = [[ZHDUnderUploadView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height / 2)];
        _upLoadView.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
        [self addSubview:_upLoadView];
    }
    return self;
}

@end
