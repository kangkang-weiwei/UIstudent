//
//  segleHandle.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <Foundation/Foundation.h>//单例传值

@interface segleHandle : NSObject

@property(nonatomic , strong)NSString *segString;
@property(nonatomic , strong)NSMutableArray *collectionIdArray;

+(instancetype)sharedSegleHandle;
-(void)judgeCollectionArray:(NSString *)idString;

@end
