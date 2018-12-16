//
//  NewDidSelectViewController.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/1.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDidSelectViewController : UIViewController
<UIScrollViewDelegate>

@property(nonatomic , strong)NSString *popularity;
@property(nonatomic , strong)NSString *comments;
@property(nonatomic , strong)NSString *shortComments;
@property(nonatomic , strong)NSString *idString;
@property(nonatomic , strong)NSString *dicString;
@property(nonatomic , strong)NSMutableArray *idArray;
@property(nonatomic , strong)NSDictionary *postDictionary;
@property(nonatomic , strong)NSMutableArray *collectionArray;
@end
