//
//  ViewController.m
//  EBTPopMenuViewDemo
//
//  Created by ebaotong on 16/3/28.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "ViewController.h"
#import "EBTPopMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    NSArray *imgArray = @[@"down",@"down",@"down"];//图片名称
    NSArray *titleArray = @[@"群聊",@"朋友",@"扫扫"]; //button标题
    
    [EBTPopMenuView showPopMenuViewWithImageArray:imgArray withTitleArray:titleArray withCompleteHandler:^(NSInteger buttonSelectIndex,NSString *title) {
        
        NSLog(@"buttonSelectIndex =%ld title =%@",buttonSelectIndex,title);
    }];
    
}

@end
