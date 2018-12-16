//
//  ZHDCollectionTableViewCell.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCollectionTableViewCell.h"

@implementation ZHDCollectionTableViewCell

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        <#statements#>
//    }
//    return self;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
