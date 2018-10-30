//
//  AFVideoProcessor.h
//  ArcFace
//
//  Created by yalichen on 2017/8/1.
//  Copyright © 2017年 ArcSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "asvloffscreen.h"
#import "ammem.h"
#import "merror.h"
#import "Utility.h"
#import "AFRManager.h"
#import <arcsoft_fsdk_face_recognition/arcsoft_fsdk_face_recognition.h>
#import <arcsoft_fsdk_face_tracking/arcsoft_fsdk_face_tracking.h>
#import <arcsoft_fsdk_face_detection/arcsoft_fsdk_face_detection.h>
#import <arcsoft_fsdk_age_estimation/arcsoft_fsdk_age_estimation.h>
#import <arcsoft_fsdk_gender_estimation/arcsoft_fsdk_gender_estimation.h>
@class AFRPerson;
@protocol AFVideoProcessorDelegate <NSObject>

- (void)processRecognized:(NSString*)personName;

@end

@interface AFVideoFaceInfo : NSObject
@property(nonatomic,assign) MRECT faceRect;
@property(nonatomic,assign) MInt32 age;
@property(nonatomic,assign) MInt32 gender;
@end

@interface AFVideoProcessor : NSObject

@property(atomic, assign) BOOL detectFaceUseFD;
@property(nonatomic, weak) id<AFVideoProcessorDelegate> delegate;
@property (nonatomic, assign) AFR_FSDK_FACEMODEL uploadModel;


@property (nonatomic, strong) NSData *faceData;

@property (nonatomic, assign) MByte faceByte;

- (void)initProcessor;
- (void)uninitProcessor;
- (NSArray*)process:(LPASVLOFFSCREEN)offscreen;
- (BOOL)registerDetectedPerson:(NSString*)personName;

@end
