//
//  UIViewController+Recognize.m
//  Pods
//
//  Created by guakeliao on 15/10/13.
//
//

#import "UIViewController+Recognize.h"
#import <ZXingObjC/ZXingObjC.h>
#import <objc/runtime.h>

static char *kCALLBLOCK = "kCALLBLOCK";

@interface UIViewController (
    Pravite) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) void (^callBlock)(id string);

@end

@implementation UIViewController (Pravite)

- (void)setCallBlock:(void (^)(id))callBlock
{
    objc_setAssociatedObject(self, kCALLBLOCK, callBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(id))callBlock
{
    id callBlock = objc_getAssociatedObject(self, kCALLBLOCK);

    return callBlock;
}

@end
@implementation UIViewController (Recognize)

- (void)recognizeImage:(void (^)(id string))successBlock
{
    self.callBlock = [successBlock copy];

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)recognizeWithImage:(UIImage *)image
{
    CGImageRef imageToDecode = image.CGImage;

    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap =
        [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];

    NSError *error = nil;

    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];

    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap hints:hints error:&error];
    if (result)
    {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;

        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;

        self.callBlock(result.text);
    }
    else
    {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }
}
#pragma mark
#pragma mark delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self recognizeWithImage:image];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
