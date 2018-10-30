//
//  ViewController.m
//  ArcFace
//
//  Created by yalichen on 2017/7/31.
//  Copyright © 2017年 ArcSoft. All rights reserved.
//

#import "AreFaceViewController.h"
#import "AFCameraController.h"
#import "GLKitView.h"
#import "Utility.h"
#import "asvloffscreen.h"
#import "AFVideoProcessor.h"
#import "AFRManager.h"
#import "JohnVisionSever.h"
#import "NetManager.h"
#import "ammem.h"
#import <Photos/Photos.h>
#import <arcsoft_fsdk_face_detection/arcsoft_fsdk_face_detection.h>
#import "AFRManager.h"
#import<AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define IMAGE_WIDTH     720
#define IMAGE_HEIGHT    1280
#define clamp(a) (a>255?255:(a<0?0:a))
#define kFilePath @"http://pgrzvzriq.bkt.clouddn.com/"


#define AFR_DEMO_APP_ID         "bjWLdJW5x8su48Y58QFiT3iFphPrXAb1xaohooiyvUj"
#define AFR_DEMO_SDK_FD_KEY     "Uhs5TKx9kv4NbLEBiEnS3YKiHUYTrGtfB8byCtNWDrP"

#define AFR_FD_MEM_SIZE         1024*1024*50
#define AFR_FD_MAX_FACE_NUM     4

@interface AFFaceInfo : NSObject
@property(nonatomic,assign) MRECT faceRect;


@end

@implementation AFFaceInfo
@end


@interface AreFaceViewController ()<AFCameraControllerDelegate, AFVideoProcessorDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ASVLOFFSCREEN*   _offscreenIn;
    
    MHandle          _arcsoftFD;
    MVoid*           _memBufferFD;
}

@property (nonatomic, strong) AFCameraController* cameraController;
@property (nonatomic, strong) AFVideoProcessor* videoProcessor;
@property (nonatomic, strong) NSMutableArray* arrayAllFaceRectView;
@property (nonatomic, strong) AFRManager*       frManager;
@property (weak, nonatomic) IBOutlet UIImageView *getImageView;
@property (weak, nonatomic) IBOutlet GLKitView *glView;

@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *luruBtn;

@property (nonatomic, assign) BOOL hasRecognition;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@property (nonatomic, strong) UIImage *saveImage;

@property (nonatomic, strong) UIImage *compareImage;

@property (nonatomic, strong) UIImage *lastImage;
- (IBAction)btnRegisterClicked:(id)sender;
@end

@implementation AreFaceViewController
- (instancetype)initWithType:(NSInteger)type userId:(NSInteger)userId userType:(NSInteger)userType{
    if (self = [super init]) {
        self.type = type;
        self.userId = userId;
        self.userType = userType;
        if (type == 2) {
            self.photoBtn.hidden = YES;
            self.luruBtn.hidden = YES;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus phstatus) {
        NSLog(@"PHAuthorizationStatus = %d", (int)phstatus);
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIInterfaceOrientation uiOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    AVCaptureVideoOrientation videoOrientation = (AVCaptureVideoOrientation)uiOrientation;
    
//    self.switchDetectByFD.on = NO;
//    self.switchDetectByFD.hidden = YES;
    self.arrayAllFaceRectView = [NSMutableArray arrayWithCapacity:0];
    
    // FD
    _memBufferFD = MMemAlloc(MNull, AFR_FD_MEM_SIZE);
    MMemSet(_memBufferFD, 0, AFR_FD_MEM_SIZE);
    AFD_FSDK_InitialFaceEngine((MPChar)AFR_DEMO_APP_ID, (MPChar)AFR_DEMO_SDK_FD_KEY, (MByte*)_memBufferFD, AFR_FD_MEM_SIZE, &_arcsoftFD, AFD_FSDK_OPF_0_HIGHER_EXT, 16, AFR_FD_MAX_FACE_NUM);
    
    // Video processor
    self.videoProcessor = [[AFVideoProcessor alloc] init];
    self.videoProcessor.delegate = self;
    [self.videoProcessor initProcessor];

    
    // Start camera
    self.cameraController = [[AFCameraController alloc]init];
    self.cameraController.delegate = self;
    [self.cameraController setupCaptureSession:videoOrientation];
    if (self.userType == 1) {
        [self.cameraController setupVideoDeviceWithPosition:AVCaptureDevicePositionBack];
    }
    self.frManager = [[AFRManager alloc] init];
    
    [self getPreiOS8LastImage];
    
}

- (void)dealloc
{
    [self.cameraController stopCaptureSession];
    [self.videoProcessor uninitProcessor];
    
    [Utility freeOffscreen:_offscreenIn];
    
    AFD_FSDK_UninitialFaceEngine(_arcsoftFD);
    _arcsoftFD = MNull;
    if(_memBufferFD != MNull)
    {
        MMemFree(MNull, _memBufferFD);
        _memBufferFD = MNull;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.type == 2) {
        [self getImage];
        self.photoBtn.hidden = YES;
        self.luruBtn.hidden = YES;
    }
    [self.cameraController startCaptureSession];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.cameraController stopCaptureSession];
}


//录入按钮点击事件
- (IBAction)btnRegisterClicked:(id)sender {

//        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Register" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:cancelAction];
//
//        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

//            UITextField* nameText = alertController.textFields.firstObject;
            NSString* name = @"123";
            if (name != NULL && name.length > 1) {
                if([self.videoProcessor registerDetectedPerson:name])
                {
                    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//                    NSString *imagePath = [docPath stringByAppendingPathComponent:@"faceImage"];
                    
                    NSString *faceInfo = [[NSString alloc] initWithData:self.videoProcessor.faceData encoding:kCFStringEncodingUTF8];
                    NSLog(@"faceInfo:%@ ",faceInfo);

                    [NetManager POST:@"/file/upload" parameters:nil image:self.saveImage progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
                        NSLog(@"JSON:%@ ",jsonObject[@"data"][0]);
                        
                        NSMutableDictionary *dic = [NSMutableDictionary new];
                        [dic setObject:[NSString stringWithFormat:@"%@%@",kFilePath,jsonObject[@"data"][0]] forKey:@"faceUrl"];
                        [dic setObject:faceInfo forKey:@"faceInfo"];

                        [dic setObject:@(self.userId) forKey:@"userId"];
                        [dic setObject:@(self.userType) forKey:@"userType"];
                        [dic setObject:@(1) forKey:@"sdkType"];
                        [NetManager POST:@"/face_info/api/v1/saveFaceInfo" parameters:dic progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
                            NSLog(@"JSON:%@",jsonObject);
                            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"录入成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                            [self presentViewController:alertController animated:YES completion:nil];
                            NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerHideAlertViewController:) userInfo:alertController repeats:NO];
                            [timer fire];
                        }];
                        
                    }];
                }else{
                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"录入失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alertController animated:YES completion:nil];
                    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerHideAlertViewController:) userInfo:alertController repeats:NO];
                    [timer fire];

                }
            }
//        }];
//        [alertController addAction:okAction];
//
//        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            textField.placeholder = @"name";
//        }];
//
//        [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)timerHideAlertViewController:(id)sender {
    NSTimer *timer = (NSTimer*)sender;
    UIAlertController *alertViewController = (UIAlertController*)timer.userInfo;
    [alertViewController dismissViewControllerAnimated:YES completion:nil];
    alertViewController = nil;
    
}
- (IBAction)photoClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.cameraController stopCaptureSession];

    }else{
        [self.cameraController startCaptureSession];
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:^{
        [self.cameraController stopCaptureSession];
    }];
}


- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)lightClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.cameraController setupLight:sender.selected];


}

//CMSampleBufferRef 转换为UIImage 需要先转换输出RGBA，否则图像为灰色
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    
    
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    uint8_t *yBuffer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t yPitch = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    uint8_t *cbCrBuffer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 1);
    size_t cbCrPitch = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 1);
    
    int bytesPerPixel = 4;
    uint8_t *rgbBuffer = malloc(width * height * bytesPerPixel);
    
    for(int y = 0; y < height; y++) {
        uint8_t *rgbBufferLine = &rgbBuffer[y * width * bytesPerPixel];
        uint8_t *yBufferLine = &yBuffer[y * yPitch];
        uint8_t *cbCrBufferLine = &cbCrBuffer[(y >> 1) * cbCrPitch];
        
        for(int x = 0; x < width; x++) {
            int16_t y = yBufferLine[x];
            int16_t cb = cbCrBufferLine[x & ~1] - 128;
            int16_t cr = cbCrBufferLine[x | 1] - 128;
            
            uint8_t *rgbOutput = &rgbBufferLine[x*bytesPerPixel];
            
            int16_t r = (int16_t)roundf( y + cr *  1.4 );
            int16_t g = (int16_t)roundf( y + cb * -0.343 + cr * -0.711 );
            int16_t b = (int16_t)roundf( y + cb *  1.765);
            
            rgbOutput[0] = 0xff;
            rgbOutput[1] = clamp(b);
            rgbOutput[2] = clamp(g);
            rgbOutput[3] = clamp(r);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbBuffer, width, height, 8, width * bytesPerPixel, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(quartzImage);
    free(rgbBuffer);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return image;
}

-(PHAsset *)latestAsset {
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    return [assetsFetchResults firstObject];
}


-(void)getPreiOS8LastImage{
    [self fetchImageWithAsset:[self latestAsset] imageBlock:^(NSData *imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        [self.photoBtn setBackgroundImage:image forState:UIControlStateNormal];

    }];
}

/** 解决旋转90度问题 */
- (UIImage *)fixOrientation:(UIImage *)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/**
 通过资源获取图片的数据
 
 @param mAsset 资源文件
 @param imageBlock 图片数据回传
 */
- (void)fetchImageWithAsset:(PHAsset*)mAsset imageBlock:(void(^)(NSData *imageData))imageBlock {
    
    [[PHImageManager defaultManager] requestImageDataForAsset:mAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        if (orientation != UIImageOrientationUp) {
            UIImage* image = [UIImage imageWithData:imageData];
            // j旋转图片
            image = [self fixOrientation:image];
            // 新的 数据信息 （不准确的）
            imageData = UIImageJPEGRepresentation(image, 0.5);
        }
        
        // 直接得到最终的 NSData 数据
        if (imageBlock) {
            imageBlock(imageData);
        }
        
    }];
}

//服务器下载图片
- (void)getImage{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@(self.userId) forKey:@"userId"];
    [dic setObject:@(self.userType) forKey:@"userType"];
    [dic setObject:@(1) forKey:@"sdkType"];
    
    [NetManager POST:@"/face_info/api/v1/getFaceInfoByUserIdAndType" parameters:dic progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *imagePath = [cachePath stringByAppendingString:@"saveimg.jpg"];
        if (!error) {
            NSLog(@"jsonObject0:%@  url%@",jsonObject,jsonObject[@"data"][@"faceUrl"]);
            NSURL *url = [NSURL URLWithString:jsonObject[@"data"][@"faceUrl"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            self.compareImage = [UIImage imageWithData:data];

            [UIImageJPEGRepresentation(self.compareImage, 1.0) writeToFile:imagePath atomically:YES];
        }
        //加载本地图片
        self.compareImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];

    }];
}
#pragma mark - AFCameraControllerDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer);
    UIImage *tmpImage = [self imageFromSampleBuffer:sampleBuffer];
    
    //人脸识别
    if (self.type == 2 && self.compareImage && !self.hasRecognition) {
        [JohnVisionSever doRecognitionWithRegistImage:self.compareImage compare:tmpImage result:^(int error_regist, int error_compare, int error_reslut, float compareReslut) {

            if (error_regist == 1000 && error_compare == 1000 && error_reslut == 1000) {
                if (compareReslut > 0.56) {
                    NSLog(@"识别成功：%@",[NSThread currentThread]);
                    self.hasRecognition = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                    !_faceRecognitionBlock ?: _faceRecognitionBlock(YES);
                    [self dismissViewControllerAnimated:YES completion:nil];
                    });

                }else{
                    NSLog(@"人脸信息比较失败");

                }
            }else{
                NSLog(@"识别失败");
            }
            NSLog(@"errorcode: regist:%d,error_compare:%d,error_reslut:%d compareReslut:%lf",error_regist,error_compare,error_reslut,compareReslut);
        }];

    }
    
    
    
//    LPASVLOFFSCREEN pOffscreenIn = [Utility createOffscreenwithUImage:tmpImage];
    
//    AFR_FSDK_FACEMODEL faceModel = {0};
//    AFR_FSDK_ExtractFRFeature(_arcsoftFR, pOffscreenImg, &faceInput, &faceModel);
//
//    AFRPerson* currentPerson = [[AFRPerson alloc] init];
//    currentPerson.faceFeatureData = [NSData dataWithBytes:faceModel.pbFeature length:faceModel.lFeatureSize];
    
    LPASVLOFFSCREEN pOffscreenIn = [self offscreenFromSampleBuffer:sampleBuffer];
    NSArray *arrayFaceInfo = [self.videoProcessor process:pOffscreenIn];
    
//    AFR_FSDK_FACEMODEL faceModel = {0};
//    AFR_FSDK_ExtractFRFeature(_arcsoftFR, pOffscreenImg, &faceInput, &faceModel);
//    //
//    AFRPerson* currentPerson = [[AFRPerson alloc] init];
//    currentPerson.faceFeatureData = [NSData dataWithBytes:faceModel.pbFeature length:faceModel.lFeatureSize];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.saveImage = tmpImage;
        [self.glView renderWithCVPixelBuffer:cameraFrame orientation:0 mirror:NO];
        if(self.arrayAllFaceRectView.count >= arrayFaceInfo.count)
        {
            for (NSUInteger face=arrayFaceInfo.count; face<self.arrayAllFaceRectView.count; face++) {
                UIView *faceRectView = [self.arrayAllFaceRectView objectAtIndex:face];
                faceRectView.hidden = YES;
            }
        }
        else
        {
            for (NSUInteger face=self.arrayAllFaceRectView.count; face<arrayFaceInfo.count; face++) {
                UIStoryboard *faceRectStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIView *faceRectView = [faceRectStoryboard instantiateViewControllerWithIdentifier:@"FaceRectVideoController"].view;
                [self.view addSubview:faceRectView];
                [self.arrayAllFaceRectView addObject:faceRectView];
            }
        }
        
        for (NSUInteger face=0; face<arrayFaceInfo.count; face++) {
            UIView *faceRectView = [self.arrayAllFaceRectView objectAtIndex:face];
            AFVideoFaceInfo *faceInfo = [arrayFaceInfo objectAtIndex:face];
            faceRectView.hidden = NO;
            faceRectView.frame = [self dataFaceRect2ViewFaceRect:faceInfo.faceRect];
            
            UILabel* labelInfo = (UILabel*)[faceRectView viewWithTag:1];
//            labelInfo.text = [NSString stringWithFormat:@"age:%d gender:%d", faceInfo.age, faceInfo.gender];

            labelInfo.text = [NSString stringWithFormat:@""];
        }
    });
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.photoBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.photoImageView.image = image;
    self.photoImageView.hidden = NO;
    for (NSUInteger face=0; face<self.arrayAllFaceRectView.count; face++) {
        UIView *faceRectView = [self.arrayAllFaceRectView objectAtIndex:face];
        faceRectView.hidden = YES;
    }
    __weak id weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        LPASVLOFFSCREEN pOffscreen = [Utility createOffscreenwithUImage:image];
        
        LPAFD_FSDK_FACERES pFaceResFD = MNull;
        AFD_FSDK_StillImageFaceDetection(_arcsoftFD, pOffscreen, &pFaceResFD);
        NSMutableArray *arrayFaceInfo = [NSMutableArray arrayWithCapacity:0];
        if(pFaceResFD && pFaceResFD->nFace > 0) {
            for (int face=0; face<pFaceResFD->nFace; face++) {
                AFFaceInfo *faceInfo = [[AFFaceInfo alloc] init];
                faceInfo.faceRect = pFaceResFD->rcFace[face];
                [arrayFaceInfo addObject:faceInfo];
            }
        }
        
        [self.videoProcessor process:pOffscreen];
        [self.videoProcessor registerDetectedPerson:@"123456"];
        [Utility freeOffscreen:pOffscreen];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if(weakSelf)
            {
//                self.btnPhotos.enabled = YES;
                
                if(self.arrayAllFaceRectView.count >= arrayFaceInfo.count)
                {
                    for (NSUInteger face=arrayFaceInfo.count; face<self.arrayAllFaceRectView.count; face++) {
                        UIView *faceRectView = [self.arrayAllFaceRectView objectAtIndex:face];
                        faceRectView.hidden = YES;
                    }
                }
                else
                {
                    for (NSUInteger face=self.arrayAllFaceRectView.count; face<arrayFaceInfo.count; face++) {
                        UIStoryboard *faceRectStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIView *faceRectView = [faceRectStoryboard instantiateViewControllerWithIdentifier:@"FaceRectVideoController"].view;
                        [self.view addSubview:faceRectView];
                        [self.arrayAllFaceRectView addObject:faceRectView];
                        
                        UILabel* labelInfo = (UILabel*)[faceRectView viewWithTag:1];
                        labelInfo.hidden = YES;
                    }
                }
                
                for (NSUInteger face=0; face<arrayFaceInfo.count; face++) {
                    UIView *faceRectView = [self.arrayAllFaceRectView objectAtIndex:face];
                    AFFaceInfo *faceInfo = [arrayFaceInfo objectAtIndex:face];
                    faceRectView.hidden = NO;
                    faceRectView.frame = [self imageDataFaceRect2ViewFaceRect:faceInfo.faceRect];
                }
            }
            
            
        });
    });
}
#pragma mark - AFVideoProcessorDelegate
- (void)processRecognized:(NSString *)personName
{
//    self.labelName.text = personName;
}

#pragma mark - Private Methods
- (LPASVLOFFSCREEN)offscreenFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (NULL == sampleBuffer)
        return NULL;
    
    CVImageBufferRef cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer);
    int bufferWidth = (int) CVPixelBufferGetWidth(cameraFrame);
    int bufferHeight = (int) CVPixelBufferGetHeight(cameraFrame);
    OSType pixelType =  CVPixelBufferGetPixelFormatType(cameraFrame);
    
    CVPixelBufferLockBaseAddress(cameraFrame, 0);
    
    if (kCVPixelFormatType_32BGRA == pixelType)
    {
        if (_offscreenIn != NULL)
        {
            if (_offscreenIn->i32Width != bufferWidth || _offscreenIn->i32Height != bufferHeight || ASVL_PAF_RGB32_B8G8R8A8 != _offscreenIn->u32PixelArrayFormat) {
                [Utility freeOffscreen:_offscreenIn];
                _offscreenIn = NULL;
            }
        }
        
        if (_offscreenIn == NULL) {
            _offscreenIn = [Utility createOffscreen:bufferWidth height:bufferHeight format:ASVL_PAF_RGB32_B8G8R8A8];
        }
        
        ASVLOFFSCREEN* pOff = _offscreenIn;
        
        size_t   rowBytePlane0 = CVPixelBufferGetBytesPerRowOfPlane(cameraFrame, 0);
        uint8_t  *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(cameraFrame);
        
        
        if (rowBytePlane0 == pOff->pi32Pitch[0])
        {
            memcpy(pOff->ppu8Plane[0], baseAddress, bufferHeight * pOff->pi32Pitch[0]);
        }
        else
        {
            for (int i = 0; i < bufferHeight; ++i) {
                memcpy(pOff->ppu8Plane[0] + i * pOff->pi32Pitch[0] , baseAddress + i * rowBytePlane0, pOff->pi32Pitch[0] );
            }
        }
    }
    else if (kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange == pixelType
             || kCVPixelFormatType_420YpCbCr8BiPlanarFullRange == pixelType) // NV12
    {
        if (_offscreenIn != NULL)
        {
            if (_offscreenIn->i32Width != bufferWidth || _offscreenIn->i32Height != bufferHeight || ASVL_PAF_NV12 != _offscreenIn->u32PixelArrayFormat) {
                [Utility freeOffscreen:_offscreenIn];
                _offscreenIn = NULL;
            }
        }
        
        if (_offscreenIn == NULL) {
            _offscreenIn = [Utility createOffscreen:bufferWidth height:bufferHeight format:ASVL_PAF_NV12];
        }
        
        ASVLOFFSCREEN* pOff = _offscreenIn;
        
        uint8_t  *baseAddress0 = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(cameraFrame, 0); // Y
        uint8_t  *baseAddress1 = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(cameraFrame, 1); // UV
        
        size_t   rowBytePlane0 = CVPixelBufferGetBytesPerRowOfPlane(cameraFrame, 0);
        size_t   rowBytePlane1 = CVPixelBufferGetBytesPerRowOfPlane(cameraFrame, 1);
        
        // YData
        if (rowBytePlane0 == pOff->pi32Pitch[0])
        {
            memcpy(pOff->ppu8Plane[0], baseAddress0, rowBytePlane0*bufferHeight);
        }
        else
        {
            for (int i = 0; i < bufferHeight; ++i) {
                memcpy(pOff->ppu8Plane[0] + i * bufferWidth, baseAddress0 + i * rowBytePlane0, bufferWidth);
            }
        }
        // uv data
        if (rowBytePlane1 == pOff->pi32Pitch[1])
        {
            memcpy(pOff->ppu8Plane[1], baseAddress1, rowBytePlane1 * bufferHeight / 2);
        }
        else
        {
            uint8_t  *pPlanUV = pOff->ppu8Plane[1];
            for (int i = 0; i < bufferHeight / 2; ++i) {
                memcpy(pPlanUV + i * bufferWidth, baseAddress1+ i * rowBytePlane1, bufferWidth);
            }
        }
    }
    
    CVPixelBufferUnlockBaseAddress(cameraFrame, 0);
    
    return _offscreenIn;
}

- (CGRect)dataFaceRect2ViewFaceRect:(MRECT)faceRect
{
    CGRect frameFaceRect = {0};
    CGRect frameGLView = self.glView.frame;
    frameFaceRect.size.width = CGRectGetWidth(frameGLView)*(faceRect.right-faceRect.left)/IMAGE_WIDTH;
    frameFaceRect.size.height = CGRectGetHeight(frameGLView)*(faceRect.bottom-faceRect.top)/IMAGE_HEIGHT;
    frameFaceRect.origin.x = CGRectGetWidth(frameGLView)*faceRect.left/IMAGE_WIDTH;
    frameFaceRect.origin.y = CGRectGetHeight(frameGLView)*faceRect.top/IMAGE_HEIGHT;
    
    return frameFaceRect;
}


- (CGRect)imageDataFaceRect2ViewFaceRect:(MRECT)faceRect
{
    CGRect frameFaceRect = {0};
    CGRect imageDisplayRect = self.photoImageView.bounds;
    CGSize imageSize = self.photoImageView.image.size;
    if(imageSize.width*CGRectGetHeight(self.photoImageView.bounds) > imageSize.height*CGRectGetWidth(self.photoImageView.bounds))
    {
        imageDisplayRect.size.height = imageSize.height*CGRectGetWidth(self.photoImageView.bounds)/imageSize.width;
        imageDisplayRect.origin.y = (CGRectGetHeight(self.photoImageView.bounds)-imageDisplayRect.size.height)/2;
    }
    else
    {
        imageDisplayRect.size.width = imageSize.width*CGRectGetHeight(self.photoImageView.bounds)/imageSize.height;
        imageDisplayRect.origin.x = (CGRectGetWidth(self.photoImageView.bounds)-imageDisplayRect.size.width)/2;
    }
    
    MRECT faceRectInImage = faceRect;
    UIImageOrientation imageOrientation = self.photoImageView.image.imageOrientation;
    switch (imageOrientation) {
        case UIImageOrientationRight:
        {
            faceRectInImage.left = imageSize.width-faceRect.bottom;
            faceRectInImage.right = imageSize.width-faceRect.top;
            faceRectInImage.top = faceRect.left;
            faceRectInImage.bottom = faceRect.right;
        }
            break;
        case UIImageOrientationLeft:
        {
            faceRectInImage.left = faceRect.top;
            faceRectInImage.right = faceRect.bottom;
            faceRectInImage.top = imageSize.height-faceRect.right;
            faceRectInImage.bottom = imageSize.height-faceRect.left;
        }
            break;
        case UIImageOrientationDown:
        {
            faceRectInImage.left = imageSize.width-faceRect.right;
            faceRectInImage.right = imageSize.width-faceRect.left;
            faceRectInImage.top = imageSize.height-faceRect.bottom;
            faceRectInImage.bottom = imageSize.height-faceRect.top;
        }
            break;
        default:
            break;
    }
    
    frameFaceRect.size.width = CGRectGetWidth(imageDisplayRect)*(faceRectInImage.right-faceRectInImage.left)/imageSize.width;
    frameFaceRect.size.height = CGRectGetHeight(imageDisplayRect)*(faceRectInImage.bottom-faceRectInImage.top)/imageSize.height;
    frameFaceRect.origin.x = imageDisplayRect.origin.x+CGRectGetWidth(imageDisplayRect)*faceRectInImage.left/imageSize.width;
    frameFaceRect.origin.y = imageDisplayRect.origin.y+CGRectGetHeight(imageDisplayRect)*faceRectInImage.top/imageSize.height;
    return frameFaceRect;
}
@end
