//
//  ZHDCollectionView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCollectionView.h"

@implementation ZHDCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        [self addSubview:_tableView];
    }
    return self;
}

@end
