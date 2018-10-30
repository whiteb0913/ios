//
//  Plugin.m
//  WisdomCampus
//
//  Created by 许雄辉 on 2018/10/22.
//

#import "Plugin.h"
#import "AreFaceViewController.h"
#import "AFNetworking.h"
#import "NetManager.h"

@implementation Plugin
- (void)faceRecognition:(CDVInvokedUrlCommand *)command{
    [self.commandDelegate runInBackground:^{
        NSString* myarg = [command.arguments objectAtIndex:1];
        
        if (myarg !=nil) {
            NSLog(@"myarg:%@",command.arguments);
            NSInteger type = [[command.arguments objectAtIndex:0] integerValue];
            NSInteger userId = [[command.arguments objectAtIndex:1] integerValue];
            NSInteger userType = [[command.arguments objectAtIndex:2] integerValue];
            NSInteger login = [[command.arguments objectAtIndex:3] integerValue];
            __block CDVPluginResult* pluginResult = nil;

            dispatch_async(dispatch_get_main_queue(), ^{
                AreFaceViewController *faceVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AreFaceViewController"];
                faceVC.type = type;
                faceVC.userId = userId;
                faceVC.userType = userType;
                faceVC.faceRecognitionBlock = ^(BOOL result) {
                    if (result) {
                        
                        if (login == 1) {
                            NSMutableDictionary *dic = [NSMutableDictionary new];
                            [dic setObject:@(userId) forKey:@"userId"];
                            
                            [NetManager POST:@"/oauth/api/v1/tch_face" parameters:dic progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
                                
                                if (!error) {
                                    NSLog(@"jsonObject0:%@",jsonObject);
                                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonObject];
                                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                                }
                                
                            }];
                        }else{
                            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"成功"];
                            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                        }

                        

                        
                    }
                };
                UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                [rootViewController presentViewController:faceVC animated:NO completion:nil];
            });

        }else{
            return ;
        }
    }];
    
    
    
//    NSString *jsStr = [NSString stringWithFormat:@"shareResult()"];
//    [self.commandDelegate evalJs:jsStr];
    
}
@end
