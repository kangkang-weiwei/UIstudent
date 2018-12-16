//
//  TableViewCell.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/25.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "TableViewCell.h"
#import "Masonry.h"

@implementation TableViewCell

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        
        _imageview = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageview];
        
    }
    return self;
}
-(void)layoutSubviews{
    _label.frame = CGRectMake(5, 5, self.frame.size.width * 3 / 4 - 25 , self.frame.size.height - 10);
    
    _label.numberOfLines = 0;
    [_label sizeToFit];
    _label.font = [UIFont systemFontOfSize:20];
    
    _imageview.frame = CGRectMake(self.frame.size.width * 3 / 4 - 10 , 5, self.frame.size.height - 10 , self.frame.size.height - 10);
    _imageview.backgroundColor = [UIColor redColor];
}
-(void)alreadyDead{
    _label.textColor = [UIColor grayColor];
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
