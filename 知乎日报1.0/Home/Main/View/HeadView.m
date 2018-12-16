//
//  HeadView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "HeadView.h"
#import "Masonry.h"

@implementation HeadView

-(void)headViewInit{
    //网络请求得到的轮播图数
    int webWithImageNumber;
    webWithImageNumber = 5;
    
    int pagecontrolWidth = 100;
    int pagecontrolHeight = 30;
    _imageArray = [NSMutableArray array];
    _labelArray = [NSMutableArray array];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - pagecontrolWidth / 2, self.frame.size.height - pagecontrolHeight, pagecontrolWidth, pagecontrolHeight)];
    [self addSubview:_pageControl];
    
    for (int i = 0; i < webWithImageNumber; i++) {
        UILabel *titleWithLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height * 2 / 3 - pagecontrolHeight, self.frame.size.width, self.frame.size.height / 3)];
        titleWithLabel.tag = i;
        titleWithLabel.numberOfLines = 0;
//        titleWithLabel.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 ) saturation:( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1];
        titleWithLabel.textColor = [UIColor whiteColor];
        titleWithLabel.font = [UIFont systemFontOfSize:22];
        [_labelArray addObject:titleWithLabel];
        
        UIButton *btnWithImage = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        btnWithImage.tag = i;
        [btnWithImage addSubview:titleWithLabel];
        [_scrollView addSubview:btnWithImage];
        btnWithImage.backgroundColor = [UIColor grayColor];
        //添加到组数中
        [_imageArray addObject:btnWithImage];
    }
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 5, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _pageControl.numberOfPages = 5;
    
    [self addTimerTask];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
-(void)addTimerTask{
    [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
-(void)nextImage{
    NSInteger page = _pageControl.currentPage;
    if (page == _pageControl.numberOfPages - 1) {
        page = 0;
        [_scrollView setContentOffset:CGPointMake(page * self.frame.size.width, 0) animated:NO];
    }else{
        page++;
        [_scrollView setContentOffset:CGPointMake(page * self.frame.size.width, 0) animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
