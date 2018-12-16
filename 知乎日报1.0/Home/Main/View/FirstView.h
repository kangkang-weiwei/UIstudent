//
//  FirstView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.
//
#import "HeadView.h"
#import <UIKit/UIKit.h>

@interface FirstView : UIView

@property(nonatomic , strong)UITableView *tableview;
@property(nonatomic , strong)UIButton *btn;
@property(nonatomic , strong)HeadView *headview;

-(void)viewInit;

@end
