//
//  EBTPopMenuView.m
//  EBTPopMenuViewDemo
//
//  Created by ebaotong on 16/3/28.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "EBTPopMenuView.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kTopPadding 74.f  //底部view的上边间距
#define kRightPadding 10.f  //底部view右边间距
#define kContainerViewSize   CGSizeMake(120.f, 140.f)  //背景黑色blackview的Size
#define kLineViewPadding 5.f  //白色线条view的左右边间距
#define kBaseTag  100
@interface EBTPopMenuView ()
{
    UIView *blackView; //背景黑色view

}
@end
@implementation EBTPopMenuView

+ (EBTPopMenuView *)shareInstance
{
    static EBTPopMenuView *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[EBTPopMenuView alloc]init];
        
    });
    return instance;

}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self setUp];
    }
    return self;

}

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.frame                                              = [UIScreen mainScreen].bounds;
    //添加手势
    UITapGestureRecognizer *tapBackGround=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
    [self addGestureRecognizer:tapBackGround];
    NSDictionary *dic_Constraint = @{
                                     @"width":@(kContainerViewSize.width),
                                     @"height":@(kContainerViewSize.height),
                                     @"top":@(kTopPadding),
                                     @"rightMargin":@(kRightPadding)
                                     };
    /**添加一个blackView*/
    blackView = [[UIView alloc]init];
    blackView.backgroundColor = UIColorFromRGB(0x9B9B9B);
    blackView.translatesAutoresizingMaskIntoConstraints = NO;
    blackView.layer.masksToBounds                       = YES;
    blackView.layer.cornerRadius                        = 5.0;
    [self addSubview:blackView];
    /**blackView水平方向上添加约束*/
    NSArray *blackView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[blackView(width)]-rightMargin-|"
                                                                                                      options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(blackView)];
    /**blackView垂直方向上添加约束*/
    NSArray *blackView_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[blackView(height)]" options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(blackView)];
    [self addConstraints:blackView_H];
    [self addConstraints:blackView_V];
    

}
/**
 * 点击区域不在显示的blackView上，则移除view
 *
 *  @param tapGesture
 */
-(void)dismissView:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point = [tapGesture locationInView:self];
    if(!CGRectContainsPoint(blackView.frame, point))
    {
        [self dismiss];
    }
}
/**
 *  移除view
 */
-(void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        blackView.alpha = 0;
        blackView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)showPopMenuViewWithImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray withCompleteHandler:(EBTPopMenuViewCompleteHandler)completeHandler
{
    myCompleteHandler = completeHandler;
    [[EBTPopMenuView shareInstance] createButton:imageArray withTitleArray:titleArray];
    [self show];

}

- (void)createButton:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray
{
    NSAssert(imageArray.count!=0, @"imgArray is not null");
    NSAssert(titleArray.count!=0, @"titleArray is not null");
    //平分按钮的高度
    CGFloat height = (kContainerViewSize.height-((imageArray.count-1)*1.0f))/imageArray.count*1.f;
    //按钮宽度
    CGFloat width = kContainerViewSize.width;
    for (NSInteger i = 0; i<imageArray.count; i++)
    {
        //创建按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
               btn.titleLabel.textAlignment                         = NSTextAlignmentLeft;
        btn.frame = CGRectMake(0, i*height, width, height);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBaseTag+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        
        //创建imageview
        UIImage *imageName                                         = [UIImage imageNamed:imageArray[i]];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(15, (height-imageName.size.height)/2.f, imageName.size.width, imageName.size.height);
        imageView.image = imageName;
        [btn addSubview:imageView];
        [blackView addSubview:btn];
        
        //创建白色线条,注意i=0的时候不创建白色线条
        UIView *lineView = [[UIView alloc]init];
        if (i==0) {
            continue;
        }
        lineView.frame = CGRectMake(kLineViewPadding, i*height+1, width-2*kLineViewPadding, 0.5);
        lineView.backgroundColor = [UIColor whiteColor];
        [blackView addSubview:lineView];
        
    }
    

}

- (void)btnAction:(UIButton *)sender
{
    if (myCompleteHandler) {
        myCompleteHandler(sender.tag,sender.titleLabel.text);
    }
    [self dismiss];
}

+ (void)showPopMenuViewWithImageArray:(NSArray *)imageArray withTitleArray:(NSArray *)titleArray withCompleteHandler:(EBTPopMenuViewCompleteHandler)completeHandler
{

    [[EBTPopMenuView shareInstance] showPopMenuViewWithImageArray:imageArray withTitleArray:titleArray withCompleteHandler:completeHandler];

}
/**
 *  显示view
 */
- (void)show
{
    UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    blackView.alpha=0;
    blackView.transform=CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.3f animations:^{
        blackView.alpha = 0.75;
        blackView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
}
@end
