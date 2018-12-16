//
//  ZHDCommentViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentViewController.h"
#import "ZHDCommentView.h"
#import "ZHDCommentModel.h"
#import "ZHDCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZHDCommentWriteViewController.h"
#import "ZHDCommentTableHeadView.h"
#import "ZHDCommentTableFootView.h"

@interface ZHDCommentViewController ()

@end

bool loadShortComment = YES;
BOOL loadLongReply = YES;

@implementation ZHDCommentViewController{
    ZHDCommentView *commentView;
    ZHDCommentModel *commentModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loadShortComment = YES;
    loadLongReply = YES;
    
    _heightWithCellLongArray = [NSMutableArray array];
    _heightWithCellShortArray = [NSMutableArray array];
    _longCommentImage = [NSMutableArray array];
    _shortCommentArray = [NSMutableArray array];
    _shortCommentImage = [NSMutableArray array];
    _replyLongArray = [NSMutableArray array];
    _replyShortArray = [NSMutableArray array];
    _heightWithCellLongReplyArray = [NSMutableArray array];
    _heightWithCellShortReplyArray = [NSMutableArray array];
    _uniteHeightWithCellLongReplyArray = [NSMutableArray array];
    _uniteHeightWithCellShortReplyArray = [NSMutableArray array];
    _boolLongArray = [NSMutableArray array];
    _boolShortArray = [NSMutableArray array];
    
    commentView = [[ZHDCommentView alloc]initWithFrame:self.view.frame];
    commentView.backgroundColor = [UIColor whiteColor];
    [commentView commentViewInit];
    [self.view addSubview:commentView];
    
    [commentView.commentUnderView.backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [commentView.commentUnderView.writeCommentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    commentView.commentTopView.commentTopLabl.text = [NSString stringWithFormat:@"%@条点评",_commentString];
    
    commentModel = [[ZHDCommentModel alloc]init];
    commentModel.idString = [[NSString alloc]initWithString:_idString];
    [commentModel commentModelInit];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadLongComment:) name:@"longComment" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shortComment:) name:@"shortComment" object:nil];
    
    commentView.tableview.delegate = self;
    commentView.tableview.dataSource = self;
    [commentView.tableview registerClass:[ZHDCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    commentView.tableview.estimatedRowHeight = 60;
    
}

-(void)loadLongComment:(NSNotification *)notification{
    NSDictionary *replyDictionary = [[NSDictionary alloc]init];
    _longComment = [NSMutableArray array];
    _longComment = notification.userInfo[@"Array"];
    _heightWithCellLongArray =  [self HeightWithLabel:_longComment];
    for (int i = 0; i < _longComment.count; i ++) {
        replyDictionary = _longComment[i][@"reply_to"];
        if (replyDictionary != nil) {
            NSString *string = [NSString stringWithFormat:@"//%@:%@",replyDictionary[@"author"],replyDictionary[@"content"]];
            if (replyDictionary[@"error_msg"]) {
                string = [NSString stringWithFormat:@"%@",replyDictionary[@"error_msg"]];
            }
            [_boolLongArray addObject:@"0"];
            [_replyLongArray addObject:string];
        }else{
            [_boolLongArray addObject:@"-1"];
            [_replyLongArray addObject:@"0"];
        }
        _longComment[i][@"time"] = [self utcChangeDate:_longComment[i][@"time"]];
        NSLog(@"_longComment[i][time] : %@",_longComment[i][@"time"]);
        NSString *string = _longComment[i][@"avatar"];
        NSString *resString = [string substringToIndex:5];
        if ([resString isEqualToString:@"http:"]) {
            string = [NSString stringWithFormat:@"https:%@",[string substringFromIndex:5]];
        }
        NSURL *url = [NSURL URLWithString:string];
        [_longCommentImage addObject:url];
    }
    _heightWithCellLongReplyArray = [self heightWithCellReplyLabel:_replyLongArray];
    _uniteHeightWithCellLongReplyArray = [self changMutableArrayToUnite:_heightWithCellLongReplyArray];
    if (_longCommentImage.count == _longComment.count) {
        [commentView.tableview reloadData];
    }
}
-(void)shortComment:(NSNotification *)notification{
    
    NSDictionary *replyDictionary = [[NSDictionary alloc]init];
    
    _shortCommentArray = notification.userInfo[@"Array"];
    _heightWithCellShortArray = [self HeightWithLabel:_shortCommentArray];
    _shortCommentImage = [NSMutableArray array];
    for (int i = 0; i < _shortCommentArray.count; i ++) {
        
        replyDictionary = _shortCommentArray[i][@"reply_to"];
        if (replyDictionary != nil) {
            NSString *string = [NSString stringWithFormat:@"//%@:%@",replyDictionary[@"author"],replyDictionary[@"content"]];
            [_boolShortArray addObject:@"0"];
            [_replyShortArray addObject:string];
        }else{
            [_replyShortArray addObject:@"0"];
            [_boolShortArray addObject:@"-1"];
        }
        
        _shortCommentArray[i][@"time"] = [self utcChangeDate:_shortCommentArray[i][@"time"]];
        NSLog(@"_shortCommentArray[i][time] : %@",_shortCommentArray[i][@"time"]);
        
        NSString *string = _shortCommentArray[i][@"avatar"];
        NSString *resString = [string substringToIndex:5];
        if ([resString isEqualToString:@"http:"]) {
            string = [NSString stringWithFormat:@"https:%@",[string substringFromIndex:5]];
        }
        NSURL *url = [NSURL URLWithString:string];
        [_shortCommentImage addObject:url];
        
        _heightWithCellShortReplyArray = [self heightWithCellReplyLabel:_replyShortArray];
        _uniteHeightWithCellShortReplyArray = [self changMutableArrayToUnite:_heightWithCellShortReplyArray];
        
    }
    if (_shortCommentImage.count == _shortCommentArray.count) {
        [commentView.tableview reloadData];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHDCommentTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (_longCommentImage.count && indexPath.section == 0 ) {
            cell.nameLabel.text = _longComment[indexPath.row][@"author"];
            [cell.AvatarImageView sd_setImageWithURL:_longCommentImage[indexPath.row]];
            
            cell.TextLabel.text = [NSString stringWithFormat:@"%@",_longComment[indexPath.row][@"content"]];
            [cell.goodButton setTitle:[NSString stringWithFormat:@"%@",_longComment[indexPath.row][@"likes"]] forState:UIControlStateNormal];
            
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",_longComment[indexPath.row][@"time"]];
            
            if ( ![_replyLongArray[indexPath.row] isEqualToString:@"0"] && [_heightWithCellLongReplyArray[indexPath.row] intValue] > 36) {
                
                cell.telescopicButton.hidden = NO;
                [cell.telescopicButton addTarget:self action:@selector(cellButton:) forControlEvents:UIControlEventTouchUpInside];
                cell.replyLabel.text = [NSString stringWithFormat:@"%@",_replyLongArray[indexPath.row]];
                if ([_boolLongArray[indexPath.row] isEqualToString:@"0"]) {
                    cell.replyLabel.numberOfLines = 2;
                    [cell.telescopicButton setTitle:@"展开" forState:UIControlStateNormal];
                }else{
                    cell.replyLabel.numberOfLines = 0;
                    [cell.telescopicButton setTitle:@"收起" forState:UIControlStateNormal];
                }
                
            }else if ( ![_replyLongArray[indexPath.row] isEqualToString:@"0"]){
                cell.telescopicButton.hidden = YES;
                cell.replyLabel.text = [NSString stringWithFormat:@"%@",_replyLongArray[indexPath.row]];
            }
            else{
                cell.telescopicButton.hidden = YES;
                cell.replyLabel.text = nil;
            }
            
        }else if(indexPath.section == 1){
            cell.nameLabel.text = _shortCommentArray[indexPath.row][@"author"];
            [cell.AvatarImageView sd_setImageWithURL:_shortCommentImage[indexPath.row]];
            cell.TextLabel.text = _shortCommentArray[indexPath.row][@"content"];
            [cell.goodButton setTitle:[NSString stringWithFormat:@"%@",_shortCommentArray[indexPath.row][@"likes"]] forState:UIControlStateNormal];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",_shortCommentArray[indexPath.row][@"time"]];
            if (![_replyShortArray[indexPath.row] isEqualToString:@"0"] && [_heightWithCellShortReplyArray[indexPath.row] intValue] > 36) {
                cell.telescopicButton.hidden = NO;
                [cell.telescopicButton addTarget:self action:@selector(cellButton:) forControlEvents:UIControlEventTouchUpInside];
                cell.replyLabel.text = [NSString stringWithFormat:@"%@",_replyShortArray[indexPath.row]];
                if ([_boolShortArray[indexPath.row] isEqualToString:@"0"]) {
                    cell.replyLabel.numberOfLines = 2;
                    [cell.telescopicButton setTitle:@"展开" forState:UIControlStateNormal];
                }else{
                    cell.replyLabel.numberOfLines = 0;
                    [cell.telescopicButton setTitle:@"收起" forState:UIControlStateNormal];
                }
            }else if (![_replyShortArray[indexPath.row] isEqualToString:@"0"]){
                cell.telescopicButton.hidden = YES;
                cell.replyLabel.text = [NSString stringWithFormat:@"%@",_replyShortArray[indexPath.row]];
            }else{
                cell.telescopicButton.hidden = YES;
                cell.replyLabel.text = nil;
            }
        }
    return cell;
}
-(void)cellButton:(UIButton *)button{
    button.selected = !button.selected;
    ZHDCommentTableViewCell *cell = nil;
    UIView *view = [button superview];
    cell = (ZHDCommentTableViewCell *)[view superview];
    NSIndexPath *indexPath = [commentView.tableview indexPathForCell:cell];
    if (indexPath.section == 0) {
        if ([_boolLongArray[indexPath.row] isEqualToString:@"0"]) {
            _boolLongArray[indexPath.row] = @"1";
            _uniteHeightWithCellLongReplyArray[indexPath.row] = _heightWithCellLongReplyArray[indexPath.row];
        }else{
            _boolLongArray[indexPath.row] = @"0";
            _uniteHeightWithCellLongReplyArray[indexPath.row] = @"40";
        }
    }else{
        if ([_boolShortArray[indexPath.row] isEqualToString:@"0"]) {
            _boolShortArray[indexPath.row] = @"1";
            _uniteHeightWithCellShortReplyArray[indexPath.row] = _heightWithCellShortReplyArray[indexPath.row];
        }else{
            _boolShortArray[indexPath.row] = @"0";
            _uniteHeightWithCellShortReplyArray[indexPath.row] = @"40";
        }
    }
    [commentView.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"弹框");
}
-(NSMutableArray *)HeightWithLabel:(NSMutableArray *)comment{
    NSMutableArray *heightArray = [NSMutableArray array];
    NSNumber *intNumber ;
    for (int i = 0 ; i < comment.count ; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 5, 0, self.view.frame.size.width *3  / 5, 0)];
        label.text = comment[i][@"content"];
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        [label sizeToFit];
        intNumber = [NSNumber numberWithInt:label.frame.size.height + self.view.frame.size.width / 10 + 30];
        [heightArray addObject:intNumber];
    }
    return heightArray;
}

-(NSMutableArray *)heightWithCellReplyLabel:(NSMutableArray *)replayArray{
    NSMutableArray *newArray = [NSMutableArray array];
    NSNumber *intNumber;
    for (int i = 0; i < replayArray.count; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 3 / 5, 0)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = replayArray[i];
        label.numberOfLines = 0;
        [label sizeToFit];
        intNumber = [NSNumber numberWithInt:label.frame.size.height];
        [newArray addObject:intNumber];
    }
    return newArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_heightWithCellLongArray.count) {
            return [_heightWithCellLongArray[indexPath.row] intValue] + [_uniteHeightWithCellLongReplyArray[indexPath.row] intValue];
        }
        return 0.1;
    }else{
        if (_shortCommentArray.count) {
            return [_heightWithCellShortArray[indexPath.row] intValue] + [_uniteHeightWithCellShortReplyArray[indexPath.row] intValue];
        }
        return 0.1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_shortCommentArray.count) {
        NSLog(@"section = 2");
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _longComment.count;
    }
    else
        return _shortCommentArray.count;
}

-(void)buttonClick:(UIButton *)button{
    if (button.tag == 201) {//返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 202){//写点评
        ZHDCommentWriteViewController *commentWriteViewController = [[ZHDCommentWriteViewController alloc]init];
        commentWriteViewController.navigationController.navigationBar.hidden = NO;
        [self presentViewController:commentWriteViewController animated:YES completion:^{
            nil;
        }];
    }
}
-(NSMutableArray *)changMutableArrayToUnite:(NSMutableArray *)array{
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        if ([array[i] intValue] > 36) {
            [newArray addObject:@"40"];
        }else{
            [newArray addObject:array[i]];
        }
    }
    return newArray;
}
-(void)footButtonClick{
    if (loadShortComment == YES) {
        NSLog(@"加载短评");
        [commentModel loadShortComment];
        loadShortComment = NO;
    }else{
        NSLog(@"收起短评");
        loadShortComment = YES;
        _shortCommentArray = [NSMutableArray array];
        [commentView.tableview reloadData];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        ZHDCommentTableFootView *footView = [[ZHDCommentTableFootView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        [footView.footerButton addTarget:self action:@selector(footButtonClick) forControlEvents:UIControlEventTouchUpInside];
        footView.footLabel.text = [NSString stringWithFormat:@"  %@条短评",_shortComment];
        [footView.footViewButton addTarget:self action:@selector(footButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return footView;
    }
    return [[UIView alloc]init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        ZHDCommentTableHeadView *headView = [[ZHDCommentTableHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        headView.headLabel.text = [NSString stringWithFormat:@"  %lu条长评",(unsigned long)_longComment.count];
        return headView;
    }
    return [[UIView alloc]init];
}
-(NSString *)utcChangeDate:(NSString *)utc{
    NSTimeInterval time = [utc doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"data : %@",detaildate);
    NSDateFormatter *dateForMatter = [[NSDateFormatter alloc]init];
    [dateForMatter setDateFormat:@"MM-dd HH:mm"];
    NSString *staartstr = [dateForMatter stringFromDate:detaildate];
    NSLog(@"string : %@",staartstr);
    return staartstr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
