//
//  LwCreateView.m
//  Pods
//
//  Created by guakeliao on 15/10/13.
//
//

#import "LwCreateView.h"
#import <ZXingObjC/ZXingObjC.h>

@interface LwCreateView ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation LwCreateView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.textView = [[UITextView alloc] init];
    self.textView.frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    [self addSubview:self.textView];

    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
}
- (void)layoutSubviews
{
    self.textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [super layoutSubviews];
}

- (void)createImage:(CGSize)imageSize successBlock:(void (^)(id image))successBlock
{
    if (self.textView.text.length > 0)
    {
        UIImage *image = [self createImageForString:self.textView.text imageSize:imageSize];
        if (successBlock)
        {
            successBlock(image);
        }
    }
    else
    {
        NSLog(@"请输入...");
    }
}

- (UIImage *)createImageForString:(NSString *)string imageSize:(CGSize)size
{
    if (![string length])
    {
        return nil;
    }

    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:string
                                  format:kBarcodeFormatQRCode
                                   width:size.width
                                  height:size.height
                                   error:&error];
    CGImageRef imageRef = [[ZXImage imageWithMatrix:result] cgimage];

    return [UIImage imageWithCGImage:imageRef];
}
@end
