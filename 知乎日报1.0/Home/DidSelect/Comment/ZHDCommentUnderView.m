//
//  ZHDCommentUnderView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/20.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentUnderView.h"

@implementation ZHDCommentUnderView

-(void)commentUnderViewInit{
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [_backButton setImage:[UIImage imageNamed:@"white_back.png"] forState:UIControlStateNormal];
    _backButton.tag = 201;
    [self addSubview:_backButton];
    
    _writeCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height)];
    [_writeCommentButton setImage:[UIImage imageNamed:@"write.png"] forState:UIControlStateNormal];
    [_writeCommentButton setTitle:@"写点评" forState:UIControlStateNormal];
    _writeCommentButton.tag = 202;
    [self addSubview:_writeCommentButton];
}


@end
