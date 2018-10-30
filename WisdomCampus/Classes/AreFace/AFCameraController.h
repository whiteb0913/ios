//
//  ViewController.m
//  ArcFace
//
//  Created by yalichen on 2017/7/31.
//  Copyright © 2017年 ArcSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@protocol AFCameraControllerDelegate <NSObject>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;
@end


@interface AFCameraController : NSObject

@property (nonatomic, weak)     id <AFCameraControllerDelegate>    delegate;

- (BOOL) setupCaptureSession:(AVCaptureVideoOrientation)videoOrientation;
- (BOOL) setupVideoDeviceWithPosition:(AVCaptureDevicePosition)videoPosition;
- (void) startCaptureSession;
- (void) stopCaptureSession;

- (void) setupLight:(BOOL)isOn;

@end




