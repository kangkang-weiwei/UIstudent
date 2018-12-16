//
//  ZHDNewUnderView.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDNewUnderView : UIView

@property(nonatomic , strong)UIButton *backButton;
@property(nonatomic , strong)UIButton *downButton;
@property(nonatomic , strong)UIButton *goodButton;
@property(nonatomic , strong)UIButton *UploadButton;
@property(nonatomic , strong)UIButton *commentButton;

@property(nonatomic , strong)UILabel *commentLabel;
@property(nonatomic , strong)UILabel *popularityLabel;

-(void)initView;

@end
