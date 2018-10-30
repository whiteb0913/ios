//
//  NSObject+AMAFNetworking.m
//  AgricultureMall
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSObject+AMAFNetworking.h"
#define kTimeOutInterval 30
#define kBasePath  @"172.16.0.84:8091"
@implementation NSObject (AMAFNetworking)
+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionhandler{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBasePath]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionhandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionhandler(nil,error);
    }];
}

+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionhandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBasePath]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        completionhandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionhandler(nil,error);
    }];
}


+ (id)POST:(NSString *)path parameters:(id)parameters header:(NSString *)header progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id, NSError *))completionhandler{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    //设置header
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"token"];
    return [manager POST:kBasePath parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionhandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionhandler(nil,error);
    }];
}

+ (id)POST:(NSString *)path parameters:(id)parameters imageURL:(NSString *)url progress:(void (^)(NSProgress *))uploadProgress completionHandler:(void (^)(id, NSError *))completionhandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBasePath]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"image/jpeg",@"image/png", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    return [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (url) {
            NSData *imageDatas = [NSData dataWithContentsOfFile:url];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageDatas
                                        name:@"pic"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        completionhandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionhandler(nil,error);
    }];
}


+(id)POST:(NSString *)path parameters:(id)parameters images:(NSArray <UIImage *>*)images progress:(void (^)(NSProgress *))uploadProgress completionHandler:(void (^)(id, NSError *))completionhandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBasePath]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"image/jpeg",@"image/png", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    return [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images.count > 0) {
            for (int i = 0; i < images.count; i ++) {
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                formatter.dateFormat=@"yyyyMMddHHmmss";
                NSString *str=[formatter stringFromDate:[NSDate date]];
                NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
                UIImage *image = images[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
                [formData appendPartWithFileData:imageData name:@"imgs[]" fileName:fileName mimeType:@"image/jpeg"];
            }
        }

        
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionhandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionhandler(nil,error);
    }];
}
@end
