//
//  ZHDCommentUnderView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/20.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDCommentUnderView : UIView

@property(nonatomic , strong)UIButton *backButton;
@property(nonatomic , strong)UIButton *writeCommentButton;

-(void)commentUnderViewInit;

@end
