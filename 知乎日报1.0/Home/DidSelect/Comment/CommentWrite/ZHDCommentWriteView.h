//
//  ZHDCommentWriteView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/26.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDCommentWriteView : UIView

@property(nonatomic , strong)UIButton *releaseButton;
@property(nonatomic , strong)UIButton *backButton;
@property(nonatomic , strong)UITextView *textView;
@property(nonatomic , strong)UILabel *placehoderLabel;

-(void)commentWriteViewInit;

@end
