//
//  UIView+AMHUD.h
//  AgricultureMall
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AMHUD)
//忙提示
- (void)showBusyHUD;
//一直转
- (void)showBusyHUDForever;
//文字提示
- (void)showWarning:(NSString *)warning;
//文字提示 带时间
- (void)showWarning:(NSString *)warning duration:(NSTimeInterval)duration;
//隐藏提示
- (void)hideBusyHUD;
//提示后进行其他操作
- (void)showWarning:(NSString *)warning completionnHandler:(void(^)(BOOL completed))completionHandler;
@end
