//
//  StaticImageViewController.m
//  ArcFace
//
//  Created by yalichen on 2018/2/5.
//  Copyright © 2018年 ArcSoft. All rights reserved.
//

#import "StaticImageViewController.h"
#import "Utility.h"
#import "asvloffscreen.h"
#import "ammem.h"
#import <Photos/Photos.h>
#import <arcsoft_fsdk_face_detection/arcsoft_fsdk_face_detection.h>
#import "AFVideoProcessor.h"
#import "AFRManager.h"
#import "AreFaceViewController.h"
#import "NetManager.h"
#import "UIView+AMHUD.h"

#define AFR_DEMO_APP_ID         "bjWLdJW5x8su48Y58QFiT3iFphPrXAb1xaohooiyvUj"
#define AFR_DEMO_SDK_FR_KEY     "Uhs5TKx9kv4NbLEBiEnS3YpMtXE9duzDvykNCx7DyoN"
#define AFR_DEMO_SDK_FT_KEY     "Uhs5TKx9kv4NbLEBiEnS3YCYtDK59fkYKJNPMW6YZUY"
#define AFR_DEMO_SDK_FD_KEY     "Uhs5TKx9kv4NbLEBiEnS3YKiHUYTrGtfB8byCtNWDrP"
#define AFR_DEMO_SDK_AGE_KEY    "Uhs5TKx9kv4NbLEBiEnS3Z4gh3WAx79rcU9NapapbcX"
#define AFR_DEMO_SDK_GENDER_KEY "Uhs5TKx9kv4NbLEBiEnS3ZBr6JjuLsfAqDPfiMkNtKM"

#define AFR_FR_MEM_SIZE         1024*1024*40
#define AFR_FT_MEM_SIZE         1024*1024*5
#define AFR_FD_MEM_SIZE         1024*1024*5
#define AFR_AGE_MEM_SIZE        1024*1024*30
#define AFR_GENDER_MEM_SIZE     1024*1024*30

#define AFR_FD_MAX_FACE_NUM     4

@interface AFFaceNewInfo : NSObject
@property(nonatomic,assign) MRECT faceRect;


@end

@implementation AFFaceNewInfo
@end

@interface StaticImageViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,AFVideoProcessorDelegate>
{
    MHandle          _arcsoftFD;
    MVoid*           _memBufferFD;
    
    MHandle          _arcsoftFR;
    MVoid*           _memBufferFR;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotos;

@property (nonatomic, strong) NSMutableArray* arrayAllFaceRectView;

@property (nonatomic, strong) AFVideoProcessor* videoProcessor;

@property (nonatomic, strong) NSData *faceData;
@property (nonatomic, strong) AFRManager*       frManager;

@end

@implementation StaticImageViewController
- (IBAction)registerBtnClicked:(id)sender {
    NSString* name = @"123";
    if (name != NULL && name.length > 1) {
        if([self.videoProcessor registerDetectedPerson:name])
        {
            
            NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];

            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            //                    NSString *imagePath = [docPath stringByAppendingPathComponent:@"faceImage"];
            AFR_FSDK_FACEMODEL faceModel = {0};
//            AFR_FSDK_ExtractFRFeature(_arcsoftFR, offscreenProcess, &faceInput, &faceModel);
            [self.view showBusyHUDForever];

            AFRPerson* currentPerson = [[AFRPerson alloc] init];
            currentPerson.faceFeatureData = [NSData dataWithBytes:faceModel.pbFeature length:faceModel.lFeatureSize];
            NSString *faceInfo = [[NSString alloc] initWithData:self.faceData encoding:kCFStringEncodingUTF8];
            NSLog(@"faceInfo:%@ ",faceInfo);
//
            NSMutableDictionary *imgDic = [NSMutableDictionary new];
            [imgDic setObject:token forKey:@"token"];
            
            [NetManager POST:@"/file/upload" parameters:imgDic image:self.image progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
                NSLog(@"JSONimage:%@ ",jsonObject[@"data"][0]);
                NSMutableDictionary *dic = [NSMutableDictionary new];
                [dic setObject:[NSString stringWithFormat:@"%@",jsonObject[@"data"][0]] forKey:@"faceUrl"];
//                [dic setObject:faceInfo forKey:@"faceInfo"];
                [dic setObject:token forKey:@"token"];

                [dic setObject:@(self.userId) forKey:@"userId"];
                [dic setObject:@(self.userType) forKey:@"userType"];
                [dic setObject:@(1) forKey:@"schoolId"];

                [dic setObject:@(1) forKey:@"sdkType"];
                NSLog(@"dic:%@",dic);
                [NetManager POST:@"/common/face_info/api/v1/saveFaceInfo" parameters:dic progress:nil completionHandler:^(id  _Nonnull jsonObject, NSError * _Nonnull error) {
                    NSLog(@"JSON:%@",jsonObject);
                    if (!error) {
                        [self.view showWarning:@"录入成功"];

                    }else{
                        [self.view showWarning:@"录入失败"];

                    }
                }];

            }];
        }else{
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"录入失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
            NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerHideAlertViewController:) userInfo:alertController repeats:NO];
            [timer fire];
            
        }
    }
}

-(void)timerHideAlertViewController:(id)sender {
    NSTimer *timer = (NSTimer*)sender;
    UIAlertController *alertViewController = (UIAlertController*)timer.userInfo;
    [alertViewController dismissViewControllerAnimated:YES completion:nil];
    alertViewController = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus phstatus) {
        NSLog(@"PHAuthorizationStatus = %d", (int)phstatus);
    }];
    
    // FD
    _memBufferFD = MMemAlloc(MNull, AFR_FD_MEM_SIZE);
    MMemSet(_memBufferFD, 0, AFR_FD_MEM_SIZE);
    AFD_FSDK_InitialFaceEngine((MPChar)AFR_DEMO_APP_ID, (MPChar)AFR_DEMO_SDK_FD_KEY, (MByte*)_memBufferFD, AFR_FD_MEM_SIZE, &_arcsoftFD, AFD_FSDK_OPF_0_HIGHER_EXT, 16, AFR_FD_MAX_FACE_NUM);
    // FR
    _memBufferFR = MMemAlloc(MNull,AFR_FR_MEM_SIZE);
    MMemSet(_memBufferFR, 0, AFR_FR_MEM_SIZE);
    AFR_FSDK_InitialEngine((MPChar)AFR_DEMO_APP_ID, (MPChar)AFR_DEMO_SDK_FR_KEY, (MByte*)_memBufferFR, AFR_FR_MEM_SIZE, &_arcsoftFR);
    self.arrayAllFaceRectView = [NSMutableArray arrayWithCapacity:0];
    
    
    // Video processor
    self.videoProcessor = [[AFVideoProcessor alloc] init];
    self.videoProcessor.delegate = self;
    self.videoProcessor.detectFaceUseFD = NO;
    [self.videoProcessor initProcessor];
    
    self.frManager = [[AFRManager alloc] init];

    self.imageView.image = self.image;
    [self faceImage:self.image];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = _image;

}
- (void)dealloc {
    AFD_FSDK_UninitialFaceEngine(_arcsoftFD);
    _arcsoftFD = MNull;
    if(_memBufferFD != MNull)
    {
        MMemFree(MNull, _memBufferFD);
        _memBufferFD = MNull;
    }
    [self.videoProcessor uninitProcessor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AFVideoProcessorDelegate
- (void)processRecognized:(NSString *)personName
{
    NSLog(@"name:%@",personName);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnPhotosClicked:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    self.btnPhotos.enabled = NO;
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
                AFFaceNewInfo *faceInfo = [[AFFaceNewInfo alloc] init];
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
                self.btnPhotos.enabled = YES;

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
                    AFFaceNewInfo *faceInfo = [arrayFaceInfo objectAtIndex:face];
                    faceRectView.hidden = NO;
                    faceRectView.frame = [self dataFaceRect2ViewFaceRect:faceInfo.faceRect];
                }
            }


        });
    });
}
- (void)faceImage:(UIImage *)image{
    __weak id weakSelf = self;

    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        LPASVLOFFSCREEN pOffscreen = [Utility createOffscreenwithUImage:image];
        
        LPAFD_FSDK_FACERES pFaceResFD = MNull;
        AFD_FSDK_StillImageFaceDetection(_arcsoftFD, pOffscreen, &pFaceResFD);
        
        MInt32 nFaceNum = 0;
        MRECT* pRectFace = MNull;
        MInt32* pFaceOrientaion = MNull;
        __block AFR_FSDK_FACEINPUT faceInput = {0};
        if (pFaceResFD) {
            nFaceNum = pFaceResFD->nFace;
            pRectFace = pFaceResFD->rcFace;
        }

        if (nFaceNum > 0)
        {
            faceInput.rcFace = pFaceResFD->rcFace[0];
            faceInput.lOrient = pFaceResFD->lfaceOrient[0];

            pFaceOrientaion = new MInt32[nFaceNum];
            MMemCpy(pFaceOrientaion, pFaceResFD->lfaceOrient, nFaceNum*sizeof(MInt32));
        }
        
        NSMutableArray *arrayFaceInfo = [NSMutableArray arrayWithCapacity:0];
        if(pFaceResFD && pFaceResFD->nFace > 0) {
            for (int face=0; face<pFaceResFD->nFace; face++) {
                AFFaceNewInfo *faceInfo = [[AFFaceNewInfo alloc] init];
                faceInfo.faceRect = pFaceResFD->rcFace[face];
                [arrayFaceInfo addObject:faceInfo];
            }
        }
        
        if(nFaceNum > 0)
        {
            AFR_FSDK_FACEMODEL faceModel = {0};
            AFR_FSDK_ExtractFRFeature(_arcsoftFR, pOffscreen, &faceInput, &faceModel);
            
            AFRPerson* currentPerson = [[AFRPerson alloc] init];
            currentPerson.faceFeatureData = [NSData dataWithBytes:faceModel.pbFeature length:faceModel.lFeatureSize];
            
            self.faceData = [NSData dataWithBytes:faceModel.pbFeature length:faceModel.lFeatureSize];
        }
        
        [self.videoProcessor process:pOffscreen];
        [self.videoProcessor registerDetectedPerson:@"123456"];
        [Utility freeOffscreen:pOffscreen];
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            if(weakSelf)
            {
                self.btnPhotos.enabled = YES;
                
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
                    AFFaceNewInfo *faceInfo = [arrayFaceInfo objectAtIndex:face];
                    faceRectView.hidden = NO;
                    faceRectView.frame = [self dataFaceRect2ViewFaceRect:faceInfo.faceRect];
                }
            }
            
            
        });
    });
}

- (CGRect)dataFaceRect2ViewFaceRect:(MRECT)faceRect
{
    CGRect frameFaceRect = {0};
    CGRect imageDisplayRect = self.imageView.bounds;
    CGSize imageSize = self.imageView.image.size;
    if(imageSize.width*CGRectGetHeight(self.imageView.bounds) > imageSize.height*CGRectGetWidth(self.imageView.bounds))
    {
        imageDisplayRect.size.height = imageSize.height*CGRectGetWidth(self.imageView.bounds)/imageSize.width;
        imageDisplayRect.origin.y = (CGRectGetHeight(self.imageView.bounds)-imageDisplayRect.size.height)/2;
    }
    else
    {
        imageDisplayRect.size.width = imageSize.width*CGRectGetHeight(self.imageView.bounds)/imageSize.height;
        imageDisplayRect.origin.x = (CGRectGetWidth(self.imageView.bounds)-imageDisplayRect.size.width)/2;
    }
    
    MRECT faceRectInImage = faceRect;
    UIImageOrientation imageOrientation = self.imageView.image.imageOrientation;
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
