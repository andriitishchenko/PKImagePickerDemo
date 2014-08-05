//
//  MyImagePickerViewController.h
//  cameratestapp
//
//  Created by pavan krishnamurthy on 6/24/14.
//  Copyright (c) 2014 pavan krishnamurthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PKImagePickerViewControllerDelegate;
@protocol PKImagePickerCusomizeDelegate;

@interface PKImagePickerViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,assign) id<PKImagePickerViewControllerDelegate> delegate;
@property(nonatomic,assign) id<PKImagePickerCusomizeDelegate> customizeDelegate;
@property(nonatomic,assign) BOOL displayOverlay;
@end

@protocol PKImagePickerViewControllerDelegate <NSObject>
-(void)ImagePickerImageSelected:(UIImage*)img;
-(void)ImagePickerImageSelectionCancelled;
@optional
-(CAShapeLayer*)ImagePickerOverlayForCameraWithRect:(CGRect)rect;
@end


@protocol PKImagePickerCusomizeDelegate <NSObject>
@optional
-(UIButton*) ImagePickerCusomizeCameraButton;
-(UIButton*) ImagePickerCusomizeFlashButton;
-(UIButton*) ImagePickerCusomizeFrontCameraButton;
-(UIButton*) ImagePickerCusomizeAlbumButton;
-(UIButton*) ImagePickerCusomizeCancelButton;
-(UIButton*) ImagePickerCusomizeSelectPhotoButton;
-(UIButton*) ImagePickerCusomizeCancelSelectPhotoButton;
@end