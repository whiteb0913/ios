/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  WisdomCampus
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <MobPush/MobPush.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    //mobpush
    // 设置推送环境
//#ifdef DEBUG
    [MobPush setAPNsForProduction:NO];
//#else
//    [MobPush setAPNsForProduction:YES];
//#endif
    
    //MobPush推送设置（获得角标、声音、弹框提醒权限）
    MPushNotificationConfiguration *configuration = [[MPushNotificationConfiguration alloc] init];
    configuration.types = MPushAuthorizationOptionsBadge | MPushAuthorizationOptionsSound | MPushAuthorizationOptionsAlert;
    [MobPush setupNotification:configuration];
 
    [MobPush getRegistrationID:^(NSString *registrationID, NSError *error) {
        NSLog(@"registrationID = %@--error = %@", registrationID, error);
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"MobRegistrationId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:MobPushDidReceiveMessageNotification object:nil];

    [MobPush clearBadge];
    
    self.viewController = [[MainViewController alloc] init];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
    
}

- (void)didReceiveMessage:(NSNotification *)notification
{
    
    MPushMessage *message = notification.object;
    NSLog(@"getmessage:%@",message.msgInfo);

    //获取本地路径
    NSURL* appURL = nil;
    NSURL* startURL = [NSURL URLWithString:self.viewController.startPage];
    NSString* startFilePath = [self.viewController.commandDelegate pathForResource:[startURL path]];

    if (startFilePath == nil) {
        appURL = nil;
    } else {
        appURL = [NSURL fileURLWithPath:startFilePath];
        // CB-3005 Add on the query params or fragment.
        NSString* startPageNoParentDirs = self.viewController.startPage;
        NSRange r = [startPageNoParentDirs rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"?#"] options:0];
        if (r.location != NSNotFound) {
            NSString* queryAndOrFragment = [self.viewController.startPage substringFromIndex:r.location];

            appURL = [NSURL URLWithString:queryAndOrFragment relativeToURL:appURL];
        }
        //拼接加载路径
        NSString *path = message.msgInfo[@"url"];

        appURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appURL,path]];
        NSLog(@"appurl:%@ path:%@",appURL.absoluteString,path);

    }

    
        //获取当前webview
    UIWebView *web = (UIWebView *)self.viewController.webView;
    NSURLRequest *request = [NSURLRequest requestWithURL:appURL];
    [web loadRequest:request];
    [self.viewController.view addSubview:web];

    switch (message.messageType)
    {
        case MPushMessageTypeCustom:
        {// 自定义消息

        }
            break;
        case MPushMessageTypeAPNs:
        {// APNs 回调

            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
            { // 前台
            }
            else
            { // 后台
//                [NSNotificationCenter defaultCenter] postNotificationName:@"MessageContentNotification" object:nil userInfo:@{@"messageContent":message.content};
            }
        }
            break;
        case MPushMessageTypeLocal:
        { // 本地通知回调
            NSString *body = message.notification.body;
            NSString *title = message.notification.title;
            NSString *subtitle = message.notification.subTitle;
            NSInteger badge = message.notification.badge;
            NSString *sound = message.notification.sound;

            NSLog(@"收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%ld，\nsound：%@，\n}",body, title, subtitle, badge, sound);
        }
            break;
        default:
            break;
    }
}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
