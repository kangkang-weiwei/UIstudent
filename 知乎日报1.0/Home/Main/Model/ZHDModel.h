//
//  model.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/10/16.
//  Copyright © 2018年 康思婉. All rights reserved.
//侧滑弹回
//侧滑不可点击
//wkwebview


#import <Foundation/Foundation.h>

@interface ZHDModel : NSObject

@property(nonatomic , strong)NSString *dateString;
@property(nonatomic , strong)NSMutableArray *topIdArray;
@property(nonatomic , strong)NSMutableArray *idArray;
@property(nonatomic , strong)NSMutableArray *idMenuArray;

-(void)initModel;
-(void)loadSmpleData;
-(void)receiveSection:(NSInteger)section AndRow:(NSInteger)row;
-(void)receiveButtonWithTag:(NSInteger)tag;
-(void)loadDetailedData:(NSString *)string;
-(void)loadBeforeData;
-(void)menuDetailData:(NSMutableArray *)array;
-(void)receiveMenuRow:(NSString *)string;

@end
