//
//  MenuViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/2.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    [self addMenuItems];
}

-(void)addMenuItems{
    CGFloat offsetWidth = self.view.frame.size.width / 2;
    CGFloat buttonHeight = self.view.frame.size.height * 0.075;
    CGFloat nameHeight = self.view.frame.size.height * 0.09;
    CGFloat collectionHeight = self.view.frame.size.height * 0.1;//100
    
    UIButton *item1 = [[UIButton alloc]initWithFrame:CGRectMake(0, nameHeight + collectionHeight, offsetWidth, buttonHeight)];
    [item1 setTitle:@"首页" forState:UIControlStateNormal];
    [item1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    item1.titleLabel.font = [UIFont systemFontOfSize:20];
    item1.tag = 1;
    item1.backgroundColor = [UIColor colorWithRed:0.11f green:0.13f blue:0.16f alpha:1.00f];
    item1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [item1 addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:item1];
    
    NSArray *nameArray = @[@"收藏" , @"消息" , @"设置"];
    NSArray *imageArray = @[@"collection.png" , @"Message.png" , @"setting.png"];
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(offsetWidth / 3 * i, nameHeight, offsetWidth / 3, collectionHeight)];
        [button setTitle:[NSString stringWithFormat:@"%@",nameArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.tag = i + 2;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height + 20, -button.imageView.frame.size.width, 0, 0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, -button.titleLabel.bounds.size.width)];
        [button addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, nameHeight - 15, nameHeight - 15)];
    [imageButton setImage:[UIImage imageNamed: @"own.jpg"] forState:UIControlStateNormal];
    imageButton.layer.masksToBounds = YES;
    imageButton.layer.cornerRadius = (nameHeight - 15) / 2;
    imageButton.tag = 5;
    [self.view addSubview:imageButton];
    [imageButton addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nameButton = [[UIButton alloc]initWithFrame:CGRectMake(15 + nameHeight, 20, offsetWidth - nameHeight - 15 , nameHeight - 20)];
    [nameButton setTitle:@"韡韡" forState:UIControlStateNormal];
    nameButton.titleLabel.font = [UIFont systemFontOfSize:18];
    nameButton.tag = 5;
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nameButton addTarget:self action:@selector(menuItemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nameButton];
    
    UIButton *download = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - nameHeight / 2, offsetWidth / 2, nameHeight / 2)];
    [download setImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    [download setTitle:@"离线" forState: UIControlStateNormal];
    [self.view addSubview:download];
    
    UIButton *moon = [[UIButton alloc]initWithFrame:CGRectMake(offsetWidth / 2, self.view.frame.size.height - nameHeight / 2, offsetWidth / 2, nameHeight / 2)];
    [moon setImage:[UIImage imageNamed:@"moon.png"] forState:UIControlStateNormal];
    [moon setTitle:@"夜间" forState:UIControlStateNormal];
    [self.view addSubview:moon];
}

-(void)menuItemSelected:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(menuController:didSelectItemAtIndex:)]) {
        [self.delegate menuController:self didSelectItemAtIndex:sender.tag - 1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
