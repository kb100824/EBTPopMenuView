//
//  EBTPopMenuView.h
//  EBTPopMenuViewDemo
//
//  Created by ebaotong on 16/3/28.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EBTPopMenuViewCompleteHandler)(NSInteger buttonSelectIndex,NSString *buttonTitle);

@interface EBTPopMenuView : UIView
{
    EBTPopMenuViewCompleteHandler myCompleteHandler;

}
/**
 *  显示popView
 *
 *  @param imageArray      图片数组
 *  @param titleArray      按钮标题名称数组
 *  @param completeHandler 参数回调
 */
+(void)showPopMenuViewWithImageArray:(NSArray*)imageArray withTitleArray:(NSArray *)titleArray withCompleteHandler:(EBTPopMenuViewCompleteHandler)completeHandler;
@end
