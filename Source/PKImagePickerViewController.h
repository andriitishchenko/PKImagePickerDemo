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

/**
    The PKImagePickerCusomizeDelegate protocol defines methods that your delegate object must implement for customization UI buttons. The methods of this protocol allow use customized buttons.
 
       REQUIRE setup property(nonatomic,assign) id<PKImagePickerCusomizeDelegate> customizeDelegate;
 */
@protocol PKImagePickerCusomizeDelegate <NSObject>
@optional
/**
 *  Custom camera button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeCameraButton;

/**
 *  Custom flash button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeFlashButton;

/**
 *  Custom front button switch.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeFrontCameraButton;

/**
 *  Custom albom button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeAlbumButton;

/**
 *  Custom cancel button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeCancelButton;

/**
 *  Custom select photo button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeSelectPhotoButton;

/**
 *  Custom cancel selected photo button.
 *  require setup id<PKImagePickerCusomizeDelegate> customizeDelegate
 *
 *  @return UIButton
 */
-(UIButton*) ImagePickerCusomizeCancelSelectPhotoButton;
@end