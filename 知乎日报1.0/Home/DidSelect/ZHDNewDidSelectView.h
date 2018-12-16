//
//  ZHDNewDidSelectView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/30.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ZHDNewUnderView.h"
#import "ZHDUnderUploadView.h"
#import "ZHDUnderGoodView.h"

@interface ZHDNewDidSelectView : UIView

@property(nonatomic , strong)WKWebView *wkWebView;
@property(nonatomic , strong)ZHDNewUnderView *underView;
@property(nonatomic , strong)ZHDUnderUploadView *upLoadView;
@property(nonatomic , strong)UIActivityIndicatorView *activiIndictorView;
@property(nonatomic , strong)ZHDUnderGoodView *underGoodView;

@end
