//
//  ZHDUnderUploadView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/28.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDUnderUploadView.h"

@implementation ZHDUnderUploadView{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height * 7 /8, self.frame.size.width - 20, self.frame.size.height / 8)];
        [self addSubview:_cancelButton];
        
        _collectionButton = [[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height * 6 /8 - 10, self.frame.size.width - 20, self.frame.size.height / 8)];
        [self addSubview:_collectionButton];
        
        UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height / 8)];
        shareLabel.text = @"分享这篇内容";
        shareLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:shareLabel];
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 8, [UIScreen mainScreen].bounds.size.width, self.frame.size.height * 5 / 8 - 10)];
        [self addSubview:scrollView];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 50, self.frame.size.height * 3 / 4 - 40, 100, 30)];
        
        NSArray *imageArray = @[@"weixin.png",@"friends.png",@"qq.png",@"weibo1.png",@"fuzhi.png",@"dianziyoujian.png",@"youdaoyunbiji.png",@"yinxiangbiji.png"];
        for (int i = 0; i < 8; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * (1 + (i % 4) * 4) / 16,  20 + (self.frame.size.width * 2 / 16 + 30)*(i / 4), self.frame.size.width * 2 / 16, self.frame.size.width * 2 / 16)];
            [scrollView addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]]];
        }
        
        NSArray *labelArray = @[@"微信好友",@"微信朋友圈",@"QQ",@"新浪微博",@"复制链接",@"电子邮件",@"有道云笔记",@"印象笔记"];
        for (int i = 0 ; i < 8 ; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * (1 + (i % 4) * 4) / 16, 20 + self.frame.size.width * 2 / 16 + (self.frame.size.width * 2 / 16 + 30)*(i / 4), self.frame.size.width * 2 / 16, 30)];
            [scrollView addSubview:label];
            label.font = [UIFont systemFontOfSize:9];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%@",labelArray[i]];
        }
        
        [self addSubview:pageControl];
    }
    return self;
}
-(void)layoutSubviews{
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _collectionButton.backgroundColor = [UIColor whiteColor];
    [_collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectionButton setTitle:@"取消收藏" forState:UIControlStateSelected];
    [_collectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    scrollView.contentSize = CGSizeMake(self.frame.size.width * 2, self.frame.size.height * 5 / 8 - 10);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = 2;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

@end
