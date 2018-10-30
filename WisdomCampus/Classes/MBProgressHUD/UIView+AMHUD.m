//
//  UIView+AMHUD.m
//  AgricultureMall
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIView+AMHUD.h"
#import "MBProgressHUD.h"
//超时时长
#define kTimeOut 30
//弹出时长
#define kDuration 2
@implementation UIView (AMHUD)



- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        [hud hideAnimated:YES afterDelay:kTimeOut];
    });
}
- (void)showBusyHUDForever{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        //        [hud hideAnimated:YES afterDelay:kTimeOut];
    });
}
-(void)showWarning:(NSString *)warning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = warning;
        [hud hideAnimated:YES afterDelay:kDuration];
    });
}
- (void)showWarning:(NSString *)warning duration:(NSTimeInterval)duration{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = warning;
        [hud hideAnimated:YES afterDelay:duration];
    });
}
- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}

- (void)showWarning:(NSString *)warning completionnHandler:(void (^)(BOOL))completionHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = warning;
        [hud hideAnimated:YES afterDelay:kDuration];
        !completionHandler ?: completionHandler(YES);
    });
}
@end
