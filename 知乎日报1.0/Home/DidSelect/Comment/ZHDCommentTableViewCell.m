//
//  ZHDCommentTableViewCell.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/21.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentTableViewCell.h"
#import "Masonry.h"

@implementation ZHDCommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _AvatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/20, self.frame.size.width/20, self.frame.size.width/10, self.frame.size.width/10)];
        _AvatarImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_AvatarImageView];
        _AvatarImageView.layer.masksToBounds = YES;
        _AvatarImageView.layer.cornerRadius = self.contentView.frame.size.width / 20;
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 5, self.frame.size.width/20, self.frame.size.width - self.frame.size.width / 5, self.frame.size.width/10)];
//        _nameLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_nameLabel];
        
        _goodButton = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width + 18, self.frame.size.width/20, self.frame.size.width/10 + 2, self.frame.size.width/10)];
        [self.contentView addSubview:_goodButton];
        _goodButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_goodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_goodButton setTitle:@"12" forState:UIControlStateNormal];
        [_goodButton setImage:[UIImage imageNamed:@"good.png"] forState:UIControlStateNormal];
        
        _TextLabel = [UILabel new];
        _TextLabel.numberOfLines = 0;
        [self.contentView addSubview:_TextLabel];
        [_TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.frame.size.width / 5);
            make.right.mas_equalTo(-self.frame.size.width / 5);
//            make.right.equalTo(self.contentView);
            make.top.equalTo(self->_nameLabel.mas_bottom);
        }];
        _TextLabel.font = [UIFont systemFontOfSize:15];
        
        _replyLabel = [UILabel new];
        [self.contentView addSubview:_replyLabel];
        [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_TextLabel.mas_bottom);
            make.right.mas_equalTo(-self.frame.size.width / 5);
            make.left.mas_equalTo( self.frame.size.width / 5);
        }];
        _replyLabel.font = [UIFont systemFontOfSize:15];
        
        _timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.frame.size.width / 5);
            make.bottom.equalTo(self.contentView);
        }];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        
        _telescopicButton = [[UIButton alloc] init];
        [self.contentView addSubview:_telescopicButton];
        [_telescopicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.frame.size.width / 5);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        _telescopicButton.backgroundColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
