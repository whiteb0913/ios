//
//  FaceRecognitionManager.h
//  WisdomSchool
//
//  Created by 许雄辉 on 2018/10/22.
//  Copyright © 2018 tiandingkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceRecognitionManager : NSObject
/**
 人脸识别
 
 @param type 1 人脸录入  2 人脸识别
 @param userId 用户id
 @param userType 用户类型 1: 学生，2：教师，3：家长
 @return 识别结果
 */
- (BOOL)faceRecognitionWithType:(NSInteger)type userId:(NSInteger)userId userType:(NSInteger)userType;
@end

NS_ASSUME_NONNULL_END
