//
//  ViewController.m
//  PKImagePickerDemo
//
//  Created by pavan krishnamurthy on 7/7/14.
//  Copyright (c) 2014 pavan krishnamurthy. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

#import "PKImagePickerViewController.h"


@interface ViewController ()<PKImagePickerViewControllerDelegate, PKImagePickerCusomizeDelegate>
@property (nonatomic,strong) PKImagePickerViewController *imagePicker;
@property (nonatomic,strong) UIImageView*imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagePicker = [[PKImagePickerViewController alloc]init];
    self.imagePicker.delegate = self;
   
//    uncomment line bellow to enable buttons customization
//    self.imagePicker.customizeDelegate = self;
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 250, 50)];
    [button setTitle:@"Show Camera" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showCamera:) forControlEvents:UIControlEventTouchUpInside];
    [button setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 250, 50)];
    [button1 setTitle:@"Show with Overlay" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showCameraWithOverlay:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:button1];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 200, 200)];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints: NO];
    self.imageView.image = [UIImage imageNamed:@"no_photo_icon"];
    [self.view addSubview:self.imageView ];
    
    [button setTranslatesAutoresizingMaskIntoConstraints: NO];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    NSDictionary *views =  NSDictionaryOfVariableBindings (button,button1,_imageView);
    
    NSDictionary *metrics = @{@"size":@(300)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(200)]"
                                                                            options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button1(200)]"
                                                                      options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView(size)]"
                                                                          options:kNilOptions metrics:metrics views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-50-[button(50)]-5-[button1(50)]-30-[_imageView(size)]"
                                                                      options:kNilOptions metrics:metrics views:views]];
    
    
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:button
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:button1
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:_imageView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showCamera:(id)sender
{
    self.imagePicker.displayOverlay = NO;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(IBAction)showCameraWithOverlay:(id)sender
{
    self.imagePicker.displayOverlay = YES;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}



-(void)ImagePickerImageSelected:(UIImage*)img{
    self.imageView.image = img;
}

-(void)ImagePickerImageSelectionCancelled{

}

-(CAShapeLayer*)ImagePickerOverlayForCameraWithRect:(CGRect)rect
{
        NSInteger radius = (rect.size.width - 30) /2;
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((width-2.0*radius)/2, (height-2.0*radius)/2, 2.0*radius, 2.0*radius) cornerRadius:radius];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];
        
        CAShapeLayer* overlayLayer = [CAShapeLayer layer];
        overlayLayer = [CAShapeLayer layer];
        overlayLayer.path = path.CGPath;
        overlayLayer.fillRule = kCAFillRuleEvenOdd;
        overlayLayer.fillColor = [UIColor grayColor].CGColor;
        overlayLayer.opacity = 0.5;

        return overlayLayer;
}


//demo for buttons customization
//one of PKImagePickerCusomizeDelegate methods
-(UIButton*) ImagePickerCusomizeCameraButton{
    UIButton*camerabutton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2-50, CGRectGetHeight(self.view.bounds)-100, 100, 100)];
    
    UIImage*img = [UIImage imageNamed:@"PKImageBundle.bundle/take-snap"];
    CIImage *_inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    [filter setValue:_inputImage forKey:kCIInputImageKey];
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    [camerabutton setImage:image forState:UIControlStateNormal];
    [camerabutton setImage:img forState:UIControlStateHighlighted];
    return camerabutton;
}


@end
