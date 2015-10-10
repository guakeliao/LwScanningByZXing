//
//  LwScanView.m
//  LwScanningByZxing
//
//  Created by guakeliao on 15/10/10.
//  Copyright © 2015年 liaowei. All rights reserved.
//

#import "LwScanView.h"
#import <ZXingObjC/ZXingObjC.h>

@interface LwScanView ()<ZXCaptureDelegate>

@property (nonatomic, strong) UIImageView *readImageView;
@property (nonatomic, strong) UIImageView *readLineView;
@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, assign) BOOL is_Anmotion;

@end

@implementation LwScanView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commit];
    }
    return self;
}

- (void)commit
{
    self.capture = [[ZXCapture alloc] init];
    self.capture.delegate = self;
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    [self.layer addSublayer:self.capture.layer];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.readImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanBox"]];
    [self addSubview:self.readImageView];
    
    self.readLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanLine"]];
    [self addSubview:self.readLineView];
    
    self.readImageView.frame =
    CGRectMake((rect.size.width - MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4)) / 2,
               (rect.size.height - MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4)) / 2,
               MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4),
               MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4));
    
    self. self.capture.layer.frame = self.bounds;
    self.capture.scanRect = self.readImageView.frame;
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = self.layer.bounds;
    imageLayer.backgroundColor =
    [[UIColor colorWithRed:0.012 green:0.000 blue:0.000 alpha:0.400] CGColor];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.frame = self.frame;
    
    CGRect inset = CGRectInset(self.bounds, 0, 0);
    CGMutablePathRef p1 = CGPathCreateMutable();
    CGPathAddPath(p1, nil,
                  CGPathCreateWithRect(CGRectInset(self.bounds, self.readImageView.frame.origin.x,
                                                   self.readImageView.frame.origin.y),
                                       nil));
    CGPathAddPath(p1, nil, CGPathCreateWithRect(inset, nil));
    maskLayer.path = p1;
    imageLayer.mask = maskLayer;
    [self.layer addSublayer:imageLayer];
}

#pragma mark 扫描动画
- (void)loopDrawLine
{
    self.is_Anmotion = NO;
    self.readLineView.frame =
    CGRectMake(self.readImageView.frame.origin.x, self.readImageView.frame.origin.y,
               self.readImageView.frame.size.width, 10);
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //修改fream的代码写在这里
                         self.readLineView.frame = CGRectMake(self.readLineView.frame.origin.x,
                                                              self.readLineView.frame.origin.y +
                                                              self.readImageView.frame.size.height - 5,
                                                              self.readLineView.frame.size.width, 10);
                         [self.readLineView setAnimationRepeatCount:1];
                     }
                     completion:^(BOOL finished) {
                         if (!self.is_Anmotion)
                         {
                             [self loopDrawLine];
                         }
                     }];
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}


- (void)start
{
    [self loopDrawLine];
    [self.capture start];
}
- (void)stop
{
    self.is_Anmotion = YES;
    self.readLineView.frame =
    CGRectMake(self.readImageView.frame.origin.x, self.readImageView.frame.origin.y,
               self.readImageView.frame.size.width, 0);
    [self.capture stop];
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;

    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self stop];
    
    if (self.callBack) {
        self.callBack(result.text);
    }
}


@end
