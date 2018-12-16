//
//  ViewController.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/15.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic , strong)NSArray *upImageArray;
@property(nonatomic , strong)NSArray *upTitleArray;

@property(nonatomic , strong)NSMutableArray *lastImageArray;
@property(nonatomic , strong)NSMutableArray *lastTitleArray;

@property(nonatomic , strong)NSMutableArray *lastTitleArrayArray;
@property(nonatomic , strong)NSMutableArray *lastImageArrayArray;

@property(nonatomic , strong)NSMutableArray *numberWithTableview;

@property(nonatomic , strong)NSMutableArray *dateArray;

@property(nonatomic , strong)UIRefreshControl *refreshControl;

@property(nonatomic , strong)UIButton *mune;

@end

