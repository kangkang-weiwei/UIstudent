//
//  ZHDCommentTableViewHeadView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/24.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentTableViewHeadView.h"

@implementation ZHDCommentTableViewHeadView

-(void)headViewInit{
    _headViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    _headViewLabel.text = [NSString stringWithFormat:@"**条长评"];
    [self addSubview:_headViewLabel];
    
}

@end
