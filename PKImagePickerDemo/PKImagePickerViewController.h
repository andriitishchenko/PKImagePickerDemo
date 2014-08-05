//
//  MyImagePickerViewController.h
//  cameratestapp
//
//  Created by pavan krishnamurthy on 6/24/14.
//  Copyright (c) 2014 pavan krishnamurthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PKImagePickerViewControllerDelegate;

@interface PKImagePickerViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) id<PKImagePickerViewControllerDelegate> delegate;
@property(nonatomic,assign) BOOL displayOverlay;
@end

@protocol PKImagePickerViewControllerDelegate <NSObject>

-(void)ImagePickerImageSelected:(UIImage*)img;
-(void)ImagePickerImageSelectionCancelled;
@optional
-(CAShapeLayer*)ImagePickerOverlayForCameraWithRect:(CGRect)rect;
@end
