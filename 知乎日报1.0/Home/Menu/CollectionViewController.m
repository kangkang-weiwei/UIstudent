//
//  CollectionViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/5.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZHDCollectionView.h"
#import "TableViewCell.h"
#import "segleHandle.h"
#import "ZHDModel.h"
#import "NewDidSelectViewController.h"
#import "UIImageView+WebCache.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController{
    ZHDModel *model;
    ZHDCollectionView *collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[ZHDModel alloc]init];
    
    _idArray = [NSMutableArray array];
    segleHandle *seg = [segleHandle sharedSegleHandle];
    _idArray = seg.collectionIdArray;
    [model menuDetailData:_idArray];
    
    //   标题、背景颜色
    self.title = @"收藏";
    self.view.backgroundColor = [UIColor redColor];
    //   投影颜色、偏移显示、投影透明度、投影半径
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
    //   菜单按钮的设置
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    collectionView = [[ZHDCollectionView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:collectionView];
    
    collectionView.tableView.delegate = self;
    collectionView.tableView.dataSource = self;
    
    _titleArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    
    [collectionView.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(muneData:) name:@"muneData" object:nil];
}
-(void)muneData:(NSNotification *)notification{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *string;
    NSString *resString;
    NSURL *url;
    _titleArray = notification.object[@"title"];
    imageArray = notification.object[@"image"];
    
    for (int i = 0 ; i < imageArray.count; i++) {
        string = imageArray[i];
        resString = [string substringToIndex:5];
        if ([resString isEqualToString:@"http:"]) {
            string = [NSString stringWithFormat:@"https:%@",[string substringFromIndex:5]];
        }
        url = [NSURL URLWithString:string];
        [_imageArray addObject:url];
    }
    [collectionView.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewDidSelectViewController *didSelectViewController = [[NewDidSelectViewController alloc]init];
    [self.navigationController pushViewController:didSelectViewController animated:YES];
    didSelectViewController.idArray = [[NSMutableArray alloc]initWithArray:_idArray];
    
    model.idMenuArray = [[NSMutableArray alloc]initWithArray:_idArray];
    [model receiveMenuRow:_idArray[indexPath.row]];
//    [model loadDetailedData:_idArray[indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *Cell = nil;
    Cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_titleArray.count) {
        Cell.label.text = [NSString stringWithFormat:@"%@",_titleArray[indexPath.row]];
        [Cell.imageview sd_setImageWithURL:_imageArray[indexPath.row]];
    }
    return Cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.view.frame.size.height * 0.165) ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_titleArray.count) {
        return _titleArray.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)openCloseMenu: (UIBarButtonItem *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
