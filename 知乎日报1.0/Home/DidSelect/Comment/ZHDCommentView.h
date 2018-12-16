//
//  ZHDCommentView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHDCommentUnderView.h"
#import "ZHDCommentTopView.h"

@interface ZHDCommentView : UIView

@property(nonatomic , strong)ZHDCommentUnderView *commentUnderView;
@property(nonatomic , strong)ZHDCommentTopView *commentTopView;
@property(nonatomic , strong)UITableView *tableview;

-(void)commentViewInit;

@end
