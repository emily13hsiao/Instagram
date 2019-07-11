//
//  TimelineViewController.h
//  Instagram
//
//  Created by emily13hsiao on 7/8/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimelineViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIImage *selectedImage;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

NS_ASSUME_NONNULL_END
