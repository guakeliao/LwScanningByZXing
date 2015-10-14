//
//  UIViewController+Recognize.h
//  Pods
//
//  Created by guakeliao on 15/10/13.
//
//

#import <UIKit/UIKit.h>
/**
 *  从相册识别二维码
 */
@interface UIViewController (
    Recognize) 
/**
 *  调用从相册识别二维码
 *
 *  @param successBlock block里返回的是string
 */
- (void)recognizeImage:(void (^)(id string))successBlock;

@end
