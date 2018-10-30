//
//  NetManager.h
//  WisdomSchool
//
//  Created by 许雄辉 on 2018/10/19.
//  Copyright © 2018 tiandingkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetManager : NSObject
+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
+ (id)POST:(NSString *)path parameters:(id)parameters header:(NSString *)header progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//不带header的请求
+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//上传图片
+ (id)POST:(NSString *)path parameters:(id)parameters image:(UIImage *)image progress:(void(^)(NSProgress *uploadProgress))uploadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//批量上传图片
+ (id)POST:(NSString *)path parameters:(id)parameters images:(NSArray<UIImage *> *)images progress:(void(^)(NSProgress *uploadProgress))uploadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
@end

NS_ASSUME_NONNULL_END
