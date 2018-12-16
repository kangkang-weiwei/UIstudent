//
//  NewDidSelectViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/1.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "NewDidSelectViewController.h"
#import "ZHDNewDidSelectView.h"
#import "ZHDCommentViewController.h"
#import "ZHDModel.h"
#import "CollectionViewController.h"
#import "ZHDNewDidSelectModel.h"
#import "segleHandle.h"
#import <WebKit/WebKit.h>

@interface NewDidSelectViewController ()

@end

@implementation NewDidSelectViewController{
    BOOL uploadBool;
    ZHDNewDidSelectView *didSelectView;
    UIVisualEffectView *effectView;
    BOOL nextPage;
    UIButton *colorButton;
    CollectionViewController *collectionViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    colorButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    colorButton.backgroundColor = [UIColor clearColor];
    collectionViewController = [[CollectionViewController alloc]init];
    
    nextPage = NO;
    _idArray = [NSMutableArray array];
    _collectionArray = [NSMutableArray array];
    uploadBool = NO;
    self.navigationController.navigationBar.hidden = YES;
    _postDictionary = [[NSDictionary alloc]init];
    didSelectView = [[ZHDNewDidSelectView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:didSelectView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(extents:) name:@"extents" object:nil];
    
    [didSelectView.upLoadView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [didSelectView.upLoadView.collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self AddButtonTargat];
    didSelectView.wkWebView.scrollView.delegate = self;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    
    [self.view addSubview:colorButton];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    colorButton.backgroundColor = [UIColor clearColor];
    if (scrollView.bounds.size.height + scrollView.contentOffset.y > scrollView.contentSize.height) {
        colorButton.frame = CGRectMake(0,scrollView.bounds.size.height - (scrollView.bounds.size.height + scrollView.contentOffset.y - scrollView.contentSize.height), [UIScreen mainScreen].bounds.size.width, 10);
        colorButton.backgroundColor = [UIColor redColor];
        if (scrollView.bounds.size.height + scrollView.contentOffset.y  > scrollView.contentSize.height + 50) {
            colorButton.backgroundColor = [UIColor blueColor];
            NSLog(@"调用函数");
            if (nextPage) {
                nextPage = NO;
                NSString *string = [self nextString:_idString];
                _idString = string;
                [UIView animateWithDuration:1 animations:^{
                    self->didSelectView.wkWebView.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                } completion:^(BOOL finished) {
                    [self wkWebView:string];
                    self->didSelectView.wkWebView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                }];
            }
        }
    }
}
-(void)extents:(NSNotification *)notification{
    _idString = notification.userInfo[@"date"];
    NSLog(@"999 %@",_idString);
    [self wkWebView:_idString];
    _idArray = notification.userInfo[@"array"];
    NSLog(@"////  %@",_idArray);
    _popularity = notification.userInfo[@"dic"][@"popularity"];
    _shortComments = notification.userInfo[@"dic"][@"short_comments"];
    _comments = notification.userInfo[@"dic"][@"comments"];
    
    didSelectView.underView.commentLabel.text = [NSString stringWithFormat:@"%@",_comments];
    didSelectView.underView.popularityLabel.text = [NSString stringWithFormat:@"%@",_popularity];
}
-(void)wkWebView:(NSString *)string{
    [didSelectView.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://daily.zhihu.com/story/%@",string]]]];
    self->nextPage = YES;
}

-(void)ButtonClick:(UIButton *)button{
    if (button.tag == 101) {//pop
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 102){//下一页
        NSString *string = [self nextString:_idString];
        _idString = string;
        [UIView animateWithDuration:1 animations:^{
            self->didSelectView.wkWebView.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            [self wkWebView:string];
            self->didSelectView.wkWebView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
    }else if (button.tag == 103){//赞
        CGFloat labelHeight = [UIScreen mainScreen].bounds.size.height * 0.06;
        [UIView animateWithDuration:2.0 animations:^{
            NSLog(@"xxxxx");
            self->didSelectView.underGoodView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2 / 5, [UIScreen mainScreen].bounds.size.height - labelHeight * 2, [UIScreen mainScreen].bounds.size.width / 5, labelHeight);
        } completion:^(BOOL finished) {
            [NSThread sleepForTimeInterval:2];
            [UIView animateWithDuration:2.0 animations:^{
                self->didSelectView.underGoodView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2 / 5, [UIScreen mainScreen].bounds.size.height - labelHeight , [UIScreen mainScreen].bounds.size.width / 5, labelHeight);
            } completion:^(BOOL finished) {
            }];
        }];
    }else if (button.tag == 104){//分享
        [UIView animateWithDuration:0.5 animations:^{
            self->didSelectView.upLoadView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2);
        } completion:^(BOOL finished) {
            self->didSelectView.wkWebView.userInteractionEnabled = NO;
            self->uploadBool = YES;
            [self.view addSubview:self->effectView];
        }];
        
    }else if (button.tag == 105){//评论
        ZHDCommentViewController *commentViewController = [[ZHDCommentViewController alloc]init];
        [self.navigationController pushViewController:commentViewController animated:YES];
        
        commentViewController.commentString = [[NSString alloc]initWithString:[_comments copy]];
        NSLog(@"%@",commentViewController.commentString);
        
        commentViewController.idString = [[NSString alloc]initWithString:[_idString copy]];
        commentViewController.shortComment = [[NSString alloc]initWithString:[_shortComments copy]];
    }
}

-(NSString *)nextString:(NSString *)oldString{
    NSString *string;
    NSString *newString;
    int i = 0 , j = 0;
    if (_idArray[0][0] != NULL) {
        for (i = 0 ; i < _idArray.count; i ++) {
            for (j = 0; j < [_idArray[i] count]; j++) {
                string = _idArray[i][j];
                if ([string isEqual:oldString]) {
                    break;
                }
            }
            if (j != [_idArray[i] count]) {
                break;
            }
        }
        if (j + 1 < [_idArray[i] count]) {
            NSLog(@"###");
            NSLog(@"===%@",_idArray[i][++j]);
            newString = _idArray[i][j];
            return newString;
        }else if(_idArray.count > i + 1){
            NSLog(@"===%@",_idArray[++i][0]);
            newString = _idArray[i][0];
            return newString;
        }else{
            NSLog(@"未加载下一页");
            newString = @"0";
            return newString;
        }
    }else{
        for (i = 0; i < _idArray.count; i++) {
            string = _idArray[i];
            if ([string isEqual:oldString]) {
                break;
            }
        }
        if (i + 1 < _idArray.count) {
            NSLog(@"###");
//            NSLog(@"===%@",_idArray[i][++j]);
            newString = _idArray[++i];
            return newString;
        }else{
            NSLog(@"未加载下一页");
            newString = @"0";
            return newString;
        }
        return newString;
    }
}
-(void)AddButtonTargat{
    [didSelectView.underView.backButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [didSelectView.underView.downButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [didSelectView.underView.goodButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [didSelectView.underView.UploadButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [didSelectView.underView.commentButton addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)collectionButtonClick{
    NSLog(@"收藏");
    segleHandle *seg = [segleHandle sharedSegleHandle];
    [seg judgeCollectionArray:_idString];
    
//    NSString *string;
//    int i = 0;
//    NSLog(@"==%lu",(unsigned long)_collectionArray.count);
//    for (i = 0; i < _collectionArray.count; i++) {
//        string = [NSString stringWithFormat:@"%@",_collectionArray[i]];
//        if ([string isEqualToString:_idString]) {
//            [_collectionArray removeObjectAtIndex:i];
//            break;
//        }
//    }
//    if (i == _collectionArray.count) {
//        [_collectionArray addObject:_idString];
//    }
//    NSLog(@"%@",_collectionArray);
}
-(void)cancelButtonClick{
    [UIView animateWithDuration:0.5 animations:^{
        self->didSelectView.upLoadView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2);
        [self->effectView removeFromSuperview];
    } completion:^(BOOL finished) {
        self->didSelectView.wkWebView.userInteractionEnabled = YES;
        self->uploadBool = NO;
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];//返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];//视图中的所有对象
    CGPoint point = [touch locationInView:didSelectView];//返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"%d----%d",x,y);
    if (y < self.view.frame.size.height / 2) {
        if (uploadBool == YES) {
            [self cancelButtonClick];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
