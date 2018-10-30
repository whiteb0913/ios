//
//  FaceRecognitionManager.m
//  WisdomSchool
//
//  Created by 许雄辉 on 2018/10/22.
//  Copyright © 2018 tiandingkeji. All rights reserved.
//

#import "FaceRecognitionManager.h"
#import "AreFaceViewController.h"
@implementation FaceRecognitionManager
- (BOOL)faceRecognitionWithType:(NSInteger)type userId:(NSInteger)userId userType:(NSInteger)userType{
    AreFaceViewController *faceVC = [[AreFaceViewController alloc] initWithType:type userId:userId userType:userType];
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootViewController presentViewController:faceVC animated:NO completion:nil];
    return  YES;
}




@end
