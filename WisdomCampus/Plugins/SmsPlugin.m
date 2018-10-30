//
//  SmsPlugin.m
//  WisdomCampus
//
//  Created by 许雄辉 on 2018/10/24.
//

#import "SmsPlugin.h"
#import <MobPush/MobPush.h>
#import <SMS_SDK/SMSSDK.h>
@interface SmsPlugin ()

@property (nonatomic, strong) NSString *callbackId;

@property (nonatomic, assign) BOOL getMessage;

@property (nonatomic, strong) NSString *message;
@end

@implementation SmsPlugin


- (void)getRegistrationId:(CDVInvokedUrlCommand *)command{
    [self.commandDelegate runInBackground:^{
        self.callbackId = command.callbackId;
        __block CDVPluginResult* pluginResult = nil;
        NSString *RegistrationId = [[NSUserDefaults standardUserDefaults] objectForKey:@"MobRegistrationId"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:RegistrationId];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    }];

}

- (void)receiveMessage:(NSNotification *)notification
{
    NSString *content = notification.userInfo[@"messageContent"];
    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:content];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

- (void)remoteMessage:(CDVInvokedUrlCommand *)command{
    
    [self.commandDelegate runInBackground:^{
        NSLog(@"myarg111111:");
    }];
    
}

- (void)sendSMS:(CDVInvokedUrlCommand *)command{
    NSString *phoneNumber = command.arguments[0];
    __block CDVPluginResult* pluginResult = nil;

    [self.commandDelegate runInBackground:^{

        if (!phoneNumber) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"未收到手机号"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            return;
        }
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber zone:@"86"  result:^(NSError *error) {
            
            if (!error)
            {
                // 请求成功
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"发送成功"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }
            else
            {
                // error
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"发送失败"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }
        }];
    }];

}

- (void)checkSMS:(CDVInvokedUrlCommand *)command{
    NSString *phoneNumber = command.arguments[0];
    NSString *code = command.arguments[1];
    __block CDVPluginResult* pluginResult = nil;
    
    [self.commandDelegate runInBackground:^{
        
        if (!phoneNumber || !code) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数缺失"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            return;
        }
        [SMSSDK commitVerificationCode:code phoneNumber:phoneNumber zone:@"86" result:^(NSError *error) {

            if (!error)
            {
                // 请求成功
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"验证成功"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }
            else
            {
                // error
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"验证失败"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }
        }];
    }];

}
@end
