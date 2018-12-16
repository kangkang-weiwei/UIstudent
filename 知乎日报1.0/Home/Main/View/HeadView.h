//
//  HeadView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
<UIScrollViewDelegate>

@property(nonatomic , strong)UIScrollView *scrollView;
@property(nonatomic , strong)UIPageControl *pageControl;

@property(nonatomic , strong)NSMutableArray *imageArray;
@property(nonatomic , strong)NSMutableArray *labelArray;

-(void)headViewInit;

@end
