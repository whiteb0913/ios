//
//  AreFaceViewController.h
//  WisdomSchool
//
//  Created by 许雄辉 on 2018/10/16.
//  Copyright © 2018 tiandingkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreFaceViewController : UIViewController

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) void(^faceRecognitionBlock)(BOOL result);
/**
 识别类型

 @param type 1录入 2识别
 @return return value description
 */
- (instancetype)initWithType:(NSInteger)type userId:(NSInteger)userId userType:(NSInteger)userType;

@end

NS_ASSUME_NONNULL_END
