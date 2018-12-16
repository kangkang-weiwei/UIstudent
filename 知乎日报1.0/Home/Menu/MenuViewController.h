//
//  MenuViewController.h
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/2.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuControllerDelegate <NSObject>

- (void)menuController: (MenuViewController *)controller didSelectItemAtIndex: (NSUInteger)Index;

@end

@interface MenuViewController : UIViewController

@property(weak , nonatomic)id <MenuControllerDelegate> delegate;

@end





