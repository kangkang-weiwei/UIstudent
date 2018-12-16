//
//  ZHDCommentWriteViewController.m
//  知乎日报1.0
//
//  Created by 康思婉 on 2018/11/26.
//  Copyright © 2018年 康思婉. All rights reserved.
//

#import "ZHDCommentWriteViewController.h"
#import "ZHDCommentWriteView.h"

@interface ZHDCommentWriteViewController ()

@end

@implementation ZHDCommentWriteViewController{
    ZHDCommentWriteView *commentWriteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    commentWriteView = [[ZHDCommentWriteView alloc]initWithFrame:self.view.frame];
    [commentWriteView commentWriteViewInit];
    [self.view addSubview:commentWriteView];
    [commentWriteView.backButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    [commentWriteView.releaseButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    commentWriteView.textView.delegate = self;
    commentWriteView.backgroundColor = [UIColor lightGrayColor];
    
    self.view.backgroundColor = [UIColor redColor];
    
}
-(void)textViewDidChange:(UITextView *)textView{
    if (! textView.text.length) {
        commentWriteView.placehoderLabel.alpha = 1;
    }else{
        commentWriteView.placehoderLabel.alpha = 0;
    }
}
-(void)Click:(UIButton *)button{
    if (button.tag == 0) {
        NSLog(@"返回");
        [self dismissViewControllerAnimated:YES completion:^{
            nil;
        }];
    }else if (button.tag == 1){
        NSLog(@"发表");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
