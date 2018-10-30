//
//  Plugin.h
//  WisdomCampus
//
//  Created by 许雄辉 on 2018/10/22.
//

#import <Cordova/CDVPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface Plugin : CDVPlugin
- (void)faceRecognition:(CDVInvokedUrlCommand *)command;

@end

NS_ASSUME_NONNULL_END
