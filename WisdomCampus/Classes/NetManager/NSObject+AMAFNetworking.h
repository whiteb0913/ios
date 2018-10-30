//
//  NSObject+AMAFNetworking.h
//  AgricultureMall
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NSObject (AMAFNetworking)
+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
+ (id)POST:(NSString *)path parameters:(id)parameters header:(NSString *)header progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//不带header的请求
+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//上传图片
+ (id)POST:(NSString *)path parameters:(id)parameters imageURL:(NSString *)url progress:(void(^)(NSProgress *uploadProgress))uploadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
//批量上传图片
+ (id)POST:(NSString *)path parameters:(id)parameters images:(NSArray<UIImage *> *)images progress:(void(^)(NSProgress *uploadProgress))uploadProgress completionHandler:(void(^)(id jsonObject,NSError *error))completionhandler;
@end
