//
//  FirstView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "FirstView.h"

@implementation FirstView

-(void)viewInit{
    self.backgroundColor = [UIColor whiteColor];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 64)style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self addSubview:_tableview];
    
     _headview= [[HeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 3)];
    _headview.backgroundColor = [UIColor grayColor];
    _tableview.tableHeaderView = _headview;
    
    [_headview headViewInit];
    
}
@end
