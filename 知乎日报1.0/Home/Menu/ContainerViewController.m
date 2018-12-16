//
//  ContainerViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/2.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "ViewController.h"
#import "CollectionViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "OwnViewController.h"

@interface ContainerViewController ()<MenuControllerDelegate>

@property(nonatomic , strong)MenuViewController *menuViewController;

@property(nonatomic , strong)UIViewController *contenController;
@property(nonatomic , strong)NSArray *viewControllers;
@property(nonatomic , assign , readonly)BOOL isMenuOpen;
@property(nonatomic , assign)NSInteger controllerIndex;
@property(nonatomic , assign , readonly)BOOL isAnimating;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMenuViewController];
    [self addContentControllers];
}

-(void)addMenuViewController{
    [self setMenuViewController:[[MenuViewController alloc]init]];
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    self.menuViewController.delegate = self;
}
-(void)addContentControllers{
    ViewController *viewController = [[ViewController alloc]init];
    UINavigationController *navView = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    CollectionViewController *collectionViewController = [[CollectionViewController alloc]init];
    UINavigationController *navCollection = [[UINavigationController alloc]initWithRootViewController:collectionViewController];
    
    MessageViewController *messageViewController = [[MessageViewController alloc]init];
    UINavigationController *navMessage = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    
    SettingViewController *settingViewController = [[SettingViewController alloc]init];
    UINavigationController *navSetting = [[UINavigationController alloc]initWithRootViewController:settingViewController];
    
    OwnViewController *ownViewController = [[OwnViewController alloc]init];
    UINavigationController *navOwn = [[UINavigationController alloc]initWithRootViewController:ownViewController];
    
    [self setViewControllers:@[navView , navCollection , navMessage , navSetting , navOwn]];
    [self setContenController:navView withInterger:0];
}

-(void)setContenController:(UIViewController *)contenController withInterger:(NSInteger)inter{
    if (inter == 1) {
        CollectionViewController *collectionViewController = [[CollectionViewController alloc]init];
        UINavigationController *navCollection = [[UINavigationController alloc]initWithRootViewController:collectionViewController];
        contenController = navCollection;
        NSLog(@"%ld",(long)inter);
    }
    if (_contenController == contenController) {
        return;
    }
    if (_contenController) {
        contenController.view.transform = _contenController.view.transform;
        
    }
    [_contenController willMoveToParentViewController:nil];
    [_contenController.view removeFromSuperview];
    [_contenController removeFromParentViewController];
    
    _contenController = contenController;
    [self addChildViewController:contenController];
    [self.view addSubview:contenController.view];
}

- (void)openCloseMenu
{
    CGFloat offset = self.view.frame.size.width / 2;
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self->_isAnimating = YES;
        if(!self->_isMenuOpen){
            self.contenController.view.transform = CGAffineTransformMakeTranslation(offset, 0);
        }
        else {
            self.contenController.view.transform = CGAffineTransformMakeTranslation(offset, 0);
        }
    }completion:^(BOOL finished) {
        self->_isMenuOpen = !self->_isMenuOpen;
        [self setContenController:self.viewControllers[self.controllerIndex] withInterger:self.controllerIndex];
//        [self setContenController:self.viewControllers[self.controllerIndex] withIndex:self.controllerIndex];
        if (!self->_isMenuOpen ) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                self.contenController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self->_isAnimating = NO;
            }];
        }
        else {
            self->_isAnimating = NO;
        }
    }];
    
}

-(void)menuController: (MenuViewController *)controller didSelectItemAtIndex: (NSUInteger)Index;
{
    NSLog(@"index : %lu",(unsigned long)Index);
    [self setControllerIndex:Index];
    [self openCloseMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
