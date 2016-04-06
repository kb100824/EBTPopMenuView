# 弹框选中菜单view

#使用方法

    NSArray *imgArray = @[@"down",@"down",@"down"];//图片名称
    NSArray *titleArray = @[@"群聊",@"朋友",@"扫扫"]; //button标题
    
    [EBTPopMenuView showPopMenuViewWithImageArray:imgArray withTitleArray:titleArray withCompleteHandler:^(NSInteger buttonSelectIndex,NSString *title) {
        
        NSLog(@"buttonSelectIndex =%ld title =%@",buttonSelectIndex,title);
    }];




#效果图
![Image](https://github.com/KBvsMJ/EBTPopMenuView/blob/master/demogif/1.gif)
