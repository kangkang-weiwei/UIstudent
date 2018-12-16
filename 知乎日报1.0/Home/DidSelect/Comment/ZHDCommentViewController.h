//
//  ZHDCommentViewController.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDCommentViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic , copy)NSString *commentString;
@property(nonatomic , strong)NSString *shortComment;
@property(nonatomic , strong)NSString *idString;

@property(nonatomic , strong)NSMutableArray *longComment;
@property(nonatomic , strong)NSMutableArray *shortCommentArray;

@property(nonatomic , strong)NSMutableArray *longCommentImage;
@property(nonatomic , strong)NSMutableArray *shortCommentImage;

@property(nonatomic , strong)NSMutableArray *heightWithCellLongArray;
@property(nonatomic , strong)NSMutableArray *heightWithCellShortArray;
@property(nonatomic , strong)NSMutableArray *heightWithCellLongReplyArray;
@property(nonatomic , strong)NSMutableArray *heightWithCellShortReplyArray;
@property(nonatomic , strong)NSMutableArray *uniteHeightWithCellLongReplyArray;
@property(nonatomic , strong)NSMutableArray *uniteHeightWithCellShortReplyArray;

@property(nonatomic , strong)NSMutableArray *replyLongArray;
@property(nonatomic , strong)NSMutableArray *replyShortArray;

@property(nonatomic , strong)NSMutableArray *boolLongArray;
@property(nonatomic , strong)NSMutableArray *boolShortArray;

@end
