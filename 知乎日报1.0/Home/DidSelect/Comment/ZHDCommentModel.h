//
//  ZHDCommentModel.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/19.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDCommentModel : NSObject

@property(nonatomic , strong)NSString *idString;

-(void)commentModelInit;
-(void)loadShortComment;

@end
