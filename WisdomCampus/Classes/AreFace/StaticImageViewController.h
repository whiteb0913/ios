//
//  StaticImageViewController.h
//  ArcFace
//
//  Created by yalichen on 2018/2/5.
//  Copyright © 2018年 ArcSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticImageViewController : UIViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger userType;
@end
