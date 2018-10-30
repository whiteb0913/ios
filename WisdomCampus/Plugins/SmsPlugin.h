//
//  SmsPlugin.h
//  WisdomCampus
//
//  Created by 许雄辉 on 2018/10/24.
//

#import <Cordova/CDVPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmsPlugin : CDVPlugin
- (void)getRegistrationId:(CDVInvokedUrlCommand *)command;
- (void)remoteMessage:(CDVInvokedUrlCommand *)command;
- (void)sendSMS:(CDVInvokedUrlCommand *)command;
- (void)checkSMS:(CDVInvokedUrlCommand *)command;

@end

NS_ASSUME_NONNULL_END
