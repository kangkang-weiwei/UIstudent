
//  model.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.

#import "ZHDModel.h"
#import "ViewController.h"
#import "NewDidSelectViewController.h"
#import "ZHDNewDidSelectModel.h"
int judegArray;
@implementation ZHDModel{
    ViewController *viewcontroller;
    ZHDNewDidSelectModel *didModel;
}

-(void)initModel{
    didModel = [[ZHDNewDidSelectModel alloc]init];
    _idArray = [NSMutableArray array];
    _topIdArray = [NSMutableArray array];
    _idMenuArray = [NSMutableArray array];
}

-(void)loadSmpleData{
    NSString *urlString = @"https://zhihu-daily.leanapp.cn/api/v1/last-stories";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self->_dateString = objc[@"STORIES"][@"date"];
            NSMutableArray *stories = objc[@"STORIES"][@"stories"];
            NSMutableArray *images = [NSMutableArray array];
            NSMutableArray *title = [NSMutableArray array];
            NSMutableArray *ID = [NSMutableArray array];
            for (int i = 0; i < stories.count; i ++) {
                [images addObject:stories[i][@"images"][0]];
                [title addObject:stories[i][@"title"]];
                [ID addObject:stories[i][@"id"]];
            }
            
            NSMutableArray *top_stories = objc[@"STORIES"][@"top_stories"];
            NSMutableArray *top_images = [NSMutableArray array];
            NSMutableArray *top_title = [NSMutableArray array];
            NSMutableArray *top_id = [NSMutableArray array];
            for (int i = 0; i < top_stories.count; i ++) {

                [top_images addObject:top_stories[i][@"image"]];
                [top_title addObject:top_stories[i][@"title"]];
                [top_id addObject:top_stories[i][@"id"]];
            }
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self loadImageData:images];
                [self loadImageData:top_images];
                
                [self->_idArray addObject:ID];
                [self->_topIdArray addObject:top_id];
                
                NSDictionary *firstDict = @{@"title":top_title};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"topTitles" object:nil userInfo:firstDict];
                
                NSDictionary *secondDict = @{@"title":title , @"date":self->_dateString};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"lastTitles" object:nil userInfo:secondDict];
                NSLog(@"data = %@",self->_dateString);
            }];
        }
    }];
    [dataTask resume];
}

-(void)loadImageData:(NSMutableArray *)image{
    
    NSMutableArray *newImageArray = [NSMutableArray array];
    
    for (int i = 0 ; i < image.count; i ++) {
        NSString *urlString = [NSMutableString stringWithFormat:@"%@",image[i]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *images = [UIImage imageWithData:imageData];
        if (images) {
            [newImageArray addObject:images];
        }
        if (newImageArray.count == image.count ) {
            NSDictionary *dict = @{@"image":newImageArray};
            if (image.count == 5) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"upimagedata" object:nil userInfo:dict];
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"lastimagedata" object:nil userInfo:dict];
            }
        }
    }
}

-(void)loadBeforeData{
    NSLog(@"loadBefore Data = %@",_dateString);
    NSString *urlString = [NSString stringWithFormat:@"https://zhihu-daily.leanapp.cn/api/v1/before-stories/%@",_dateString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self->_dateString = objc[@"STORIES"][@"date"];
            NSMutableArray *stories = objc[@"STORIES"][@"stories"];
            
            NSMutableArray *image = [NSMutableArray array];
            NSMutableArray *title = [NSMutableArray array];
            NSMutableArray *ID = [NSMutableArray array];
            for (int i = 0; i < stories.count ; i ++) {
                [image addObject:stories[i][@"images"][0]];
                [title addObject:stories[i][@"title"]];
                [ID addObject:stories[i][@"id"]];
            }
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self loadImageData:image];
                
                [self->_idArray addObject:ID];
                
                NSDictionary *secondDict = @{@"title":title , @"date":self->_dateString};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"lastTitles" object:nil userInfo:secondDict];
            }];
        }
    }];
    [dataTask resume];
}
-(void)loadDetailedData:(NSString *)string{
    NSURLRequest *_request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://zhihu-daily.leanapp.cn/api/v1/contents/extra/%@",string]]];
    NSURLSession *_session = [NSURLSession sharedSession];
    NSURLSessionDataTask *_dataTask = [_session dataTaskWithRequest:_request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                NSDictionary *dict;
                if (judegArray == 0) {
                    dict = @{@"dic":objc[@"DES"] , @"date":string ,@"array":self->_idArray};
                }else if (judegArray == 1){
                    dict = @{@"dic":objc[@"DES"] , @"date":string ,@"array":self->_idMenuArray};
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"extents" object:nil userInfo:dict];
            }];
        }
    }];
    [_dataTask resume];
}
-(void)menuDetailData:(NSMutableArray *)array{
    int i = 0;
    NSString *string;
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (i = 0; i < array.count; i++) {
        string = [NSString stringWithFormat:@"%@",array[i]];
        NSURLRequest *_request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://zhihu-daily.leanapp.cn/api/v1/contents/%@",string]]];
        NSURLSession *_session = [NSURLSession sharedSession];
        NSURLSessionDataTask *_dataTask = [_session dataTaskWithRequest:_request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",objc[@"CONTENTS"][@"title"]);
                [titleArray addObject:objc[@"CONTENTS"][@"title"]];
                [imageArray addObject:objc[@"CONTENTS"][@"image"]];
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    if (titleArray.count == array.count) {
                        NSDictionary *dict = @{@"title":titleArray , @"image":imageArray};
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"extents" object:nil userInfo:dict];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"muneData" object:dict userInfo:nil];
                    }
                }];
            }
        }];
        [_dataTask resume];
    }
    
}

-(void)receiveSection:(NSInteger)section AndRow:(NSInteger)row{
    NSString *string = _idArray[section][row];
    NSLog(@"=====%@",string);
    NewDidSelectViewController *didSelectViewController;
    didSelectViewController.dicString = [[NSString alloc]initWithString:string];
    judegArray = 0;
    [self loadDetailedData:string];
}
-(void)receiveButtonWithTag:(NSInteger)tag{
    NSString *string = _topIdArray[0][tag];
    NewDidSelectViewController *didSelectViewController;
    didSelectViewController.dicString = [[NSString alloc]initWithString:string];
    judegArray = 0;
    [self loadDetailedData:string];
}
-(void)receiveMenuRow:(NSString *)string{
    judegArray = 1;
    [self loadDetailedData:string];
}

@end
