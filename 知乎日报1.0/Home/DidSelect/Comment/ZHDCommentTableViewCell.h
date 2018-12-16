//
//  ZHDCommentTableViewCell.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/21.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDCommentTableViewCell : UITableViewCell

@property(nonatomic , strong)UIImageView *AvatarImageView;
@property(nonatomic , strong)UILabel *nameLabel;
@property(nonatomic , strong)UIButton *goodButton;
@property(nonatomic , strong)UILabel *TextLabel;
@property(nonatomic , strong)UILabel *replyLabel;
@property(nonatomic , strong)UILabel *timeLabel;
@property(nonatomic , strong)UIButton *telescopicButton;

@end
