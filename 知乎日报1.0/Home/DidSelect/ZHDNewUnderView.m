//
//  ZHDNewUnderView.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDNewUnderView.h"

@implementation ZHDNewUnderView

-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat labelHeight = self.frame.size.height;
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 5, labelHeight)];
    [_backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self addSubview:_backButton];
    _backButton.tag = 101;
    
    _downButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 5, 0, self.frame.size.width / 5, labelHeight)];
    [self addSubview:_downButton];
    [_downButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    _downButton.tag = 102;
    
    _goodButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 5 * 2, 0, self.frame.size.width / 5, labelHeight)];
    [_goodButton setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
    [_goodButton setImage:[UIImage imageNamed:@"goodplus.png"] forState:UIControlStateSelected];
    [self addSubview:_goodButton];
    _goodButton.tag = 103;
    
    _popularityLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 10, 6, 18, 12)];
    _popularityLabel.backgroundColor = [UIColor clearColor];
    _popularityLabel.textColor = [UIColor blackColor];
    _popularityLabel.font = [UIFont systemFontOfSize:9];
    _popularityLabel.textAlignment = NSTextAlignmentRight;
    [self.goodButton addSubview:_popularityLabel];
    
    
    _UploadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 5 * 3, 0, self.frame.size.width / 5, labelHeight)];
    [_UploadButton setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [self addSubview:_UploadButton];
    _UploadButton.tag = 104;
    
    _commentButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 5 * 4, 0, self.frame.size.width / 5, labelHeight)];
    [_commentButton setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [self addSubview:_commentButton];
    _commentButton.tag = 105;
    
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 10, 6, 18, 12)];
    _commentLabel.backgroundColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    _commentLabel.textColor = [UIColor whiteColor];
    _commentLabel.font = [UIFont systemFontOfSize:9];
    _commentLabel.textAlignment = NSTextAlignmentCenter;
    [self.commentButton addSubview:_commentLabel];
    
}

@end
