//
//  segleHandle.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/12/13.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "segleHandle.h"
#import "CollectionViewController.h"

segleHandle *handle = nil;

static NSMutableArray *collectionIdArray;

@implementation segleHandle

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [super allocWithZone:zone];
    });
    return handle;
}

+(instancetype)sharedSegleHandle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[segleHandle alloc]init];
        collectionIdArray = [NSMutableArray array];
    });
    return handle;
}

-(id)copyWithZone:(NSZone *)zone{
    return handle;
}

-(void)judgeCollectionArray:(NSString *)idString{
    _collectionIdArray = [NSMutableArray array];
    NSLog(@"seg : %@",collectionIdArray);
    
    int i = 0;
    NSString *string;
    for (i = 0; i< collectionIdArray.count; i++) {
        string = [NSString stringWithFormat:@"%@",collectionIdArray[i]];
        if ([string isEqualToString:idString]) {
//            [_collectionArray removeObjectAtIndex:i];
            break;
        }
    }
    if (i == collectionIdArray.count) {
        [collectionIdArray addObject:idString];
    }
    _collectionIdArray = collectionIdArray;
}
@end
