//
//  ZHDCommentModel.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentModel.h"
#import "UIImageView+WebCache.h"

@implementation ZHDCommentModel{
}

-(void)commentModelInit{
    [self loadLongComment];
}

-(void)loadLongComment{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://zhihu-daily.leanapp.cn/api/v1/contents/%@/long-comments",_idString]]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@",objc);
            
            NSMutableArray *longCommentArray = [NSMutableArray array];
            longCommentArray =  objc[@"COMMENTS"][@"comments"];
            
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                NSDictionary *dict = @{@"Array":longCommentArray};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"longComment" object:nil userInfo:dict];
            }];
        }
    }];
    [dataTask resume];
}

-(void)loadShortComment{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://zhihu-daily.leanapp.cn/api/v1/contents/%@/short-comments",_idString]]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableArray *shortCommentArray = [NSMutableArray array];
            shortCommentArray = objc[@"COMMENTS"][@"comments"];;
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                NSDictionary *dict = @{@"Array":shortCommentArray};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"shortComment" object:nil userInfo:dict];
            }];
        }
    }];
    [dataTask resume];
}

@end
