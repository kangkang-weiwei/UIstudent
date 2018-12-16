//
//  ViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/15.
//  Copyright © 2018年 康思婉. All rights reserved.
//
//int numberWithTableview;

#import "ViewController.h"
#import "FirstView.h"
#import "ZHDModel.h"
#import "HeadView.h"
#import "TableViewCell.h"
#import "NewDidSelectViewController.h"
#import "Masonry.h"
#import "ContainerViewController.h"

@interface ViewController (){
    FirstView *firstview;
    ZHDModel *model1;
}

@property(nonatomic , assign , readonly)BOOL upRefresh;
@property(nonatomic , assign , readonly)BOOL downRefreshes;

@end

@implementation ViewController{
    UIImageView *barImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"今日新闻";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *barbtnitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
    self.navigationItem.leftBarButtonItems = @[barbtnitem];
    self.navigationController.navigationBar.tintColor  = [UIColor whiteColor];
    barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0;
    
    _mune = [[UIButton alloc]initWithFrame:CGRectMake(8, 20.5, 54, 44)];
    [_mune setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    _mune.backgroundColor = [UIColor redColor];
    
    [self ArrayInit];
    
    model1 = [[ZHDModel alloc]init];
    [model1 initModel];
    [model1 loadSmpleData];
    
    firstview = [[FirstView alloc]initWithFrame:self.view.frame];
    [firstview viewInit];
    [self.view addSubview:firstview];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    firstview.tableview.delegate = self;
    firstview.tableview.dataSource = self;
    [firstview.tableview registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _refreshControl = [[UIRefreshControl alloc]init];
    _refreshControl.tintColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [_refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [firstview.tableview addSubview:_refreshControl];
    
    //接受通知
    //top
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(topTitles:) name:@"topTitles" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upimagedata:) name:@"upimagedata" object:nil];
    
    //last
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lastTitles:) name:@"lastTitles" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lastimagedata:) name:@"lastimagedata" object:nil];
    
}

-(void)refreshControlAction{
    if (self.refreshControl.refreshing) {
        _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中"];
        [self ArrayInit];
        [self->model1 initModel];
        [self->model1 loadSmpleData];
        [self.refreshControl endRefreshing];
    }
}

-(void)ArrayInit{
    _upImageArray = [NSArray array];
    _upTitleArray = [NSArray array];
    
    _lastTitleArray = [NSMutableArray array];
    _lastImageArray = [NSMutableArray array];
    
    _lastTitleArrayArray = [NSMutableArray array];
    _lastImageArrayArray = [NSMutableArray array];
    
    _numberWithTableview = [NSMutableArray array];
    
    _dateArray = [NSMutableArray array];
}

-(void)topTitles:(NSNotification *)notification{
    _upTitleArray = notification.userInfo[@"title"];
    for (int i = 0; i < _upTitleArray.count; i ++) {
        UILabel *label = firstview.headview.labelArray[i];
        label.text = _upTitleArray[i];
    }
    _downRefreshes = YES;
}
-(void)upimagedata:(NSNotification *)notification{
    _upImageArray = notification.userInfo[@"image"];
    for (int i = 0; i < _upImageArray.count; i ++) {
        UIButton *button = firstview.headview.imageArray[i];
        [button setImage:_upImageArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(upImageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)lastTitles:(NSNotification *)notification{
    _lastTitleArray = notification.userInfo[@"title"];
    NSString *dataString = notification.userInfo[@"date"];
    [_dateArray addObject:dataString];
    NSNumber *intValue = [NSNumber numberWithInteger:_lastTitleArray.count];
    _upRefresh = YES;
    [_numberWithTableview addObject:intValue];
    
    [_lastTitleArrayArray addObject:_lastTitleArray];
    
    [firstview.tableview reloadData];
}
-(void)lastimagedata:(NSNotification *)notification{
    _lastImageArray = notification.userInfo[@"image"];
    
    [_lastImageArrayArray addObject:_lastImageArray];
    [firstview.tableview reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = (offsetY + 64)/(200 + 64);
    barImageView.alpha = alpha - 0.1;
    if (alpha > 1) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
        if ([_numberWithTableview[0] integerValue]) {
            if (offsetY > ([_numberWithTableview[0] integerValue] + 1) *(self.view.frame.size.height * 0.165) + 64 ) {
                self.navigationController.navigationBar.hidden = YES;
            }else
                self.navigationController.navigationBar.hidden = NO;
            }
        //[_numberWithTableview[0] integerValue] *(self.view.frame.size.height * 0.165)
        //firstview.headview.frame.size.height
        }
    
    if (scrollView.bounds.size.height + scrollView.contentOffset.y > scrollView.contentSize.height) {
        if (self->_upRefresh) {
            NSLog(@" %f 调用函数" , scrollView.contentSize.height);
            [self->model1 loadBeforeData];
            self->_upRefresh = NO;
        }
//        [UIView animateWithDuration:1.0 animations:^{
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
//        } completion:^(BOOL finished) {
//            NSLog(@"shangla shuaxin");
//            if (self->_upRefresh) {
//                NSLog(@" %f 调用函数" , scrollView.contentSize.height);
//                [self->model1 loadBeforeData];
//                self->_upRefresh = NO;
//            }
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [UIView animateWithDuration:1.0 animations:^{
//                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//                }];
//            });
//        }];
    }
    
}
-(void)click:(UIBarButtonItem *)sender{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSLog(@"%ld , %ld",(long)section , (long)row);
    
    [model1 receiveSection:section AndRow:row];
    NewDidSelectViewController *newViewController = [[NewDidSelectViewController alloc]init];
    [self.navigationController pushViewController:newViewController animated:YES];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)upImageClick:(UIButton *)button{
    NSLog(@"button.tag = %ld",(long)button.tag);
    
    [model1 receiveButtonWithTag:button.tag];
    NewDidSelectViewController *newViewController = [[NewDidSelectViewController alloc]init];
    [self.navigationController pushViewController:newViewController animated:YES];
    self.navigationController.navigationBar.hidden = NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *Cell = nil;
    Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_lastTitleArray.count && _lastImageArray.count) {
        Cell.label.text = [NSString stringWithFormat:@"%@",_lastTitleArrayArray[indexPath.section][indexPath.row]];
        Cell.imageview.image = _lastImageArrayArray[indexPath.section][indexPath.row];
    }
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.view.frame.size.height * 0.165) ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _numberWithTableview.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_numberWithTableview[section] integerValue];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    headerView.backgroundColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    headerLabel.numberOfLines = 0;
    
    headerLabel.text = [NSString stringWithFormat:@"%@",_dateArray[section]];
    if (section == 0) {
        headerLabel.text = @"\n今日新闻";
    }
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:headerLabel];
//    [headerView addSubview:_mune];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 64;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
