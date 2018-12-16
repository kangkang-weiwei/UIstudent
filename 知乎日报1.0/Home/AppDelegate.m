//
//  AppDelegate.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/15.
//  Copyright © 2018年 康思婉. All rights reserved.

//navigation的左button
//等待动画,kvo监控机制
//下拉加载下一页，图片的设置（上下）,上滑加载上一页
//文章点赞，动画
//cell自适应高度的调整
//收藏
//点赞
//长评论为0，加图片

#import "AppDelegate.h"
#import "ContainerViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setWindow:[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window setRootViewController:[[ContainerViewController alloc]init]];
    [self.window makeKeyAndVisible];
    
//    ViewController *viewController = [[ViewController alloc]init];
//
//    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    menuButton.backgroundColor = [UIColor blueColor];
//    [menuButton addTarget:viewController action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.window addSubview:menuButton];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
