//
//  LwCreateView.h
//  Pods
//
//  Created by guakeliao on 15/10/13.
//
//

#import <UIKit/UIKit.h>
/**
 *  生成二维码
 */
@interface LwCreateView : UIView

/**
 *  调用生成二维码图片
 *
 *  @param successBlock block里返回的是image
 */
- (void)createImage:(CGSize)imageSize successBlock:(void (^)(id image))successBlock;

@end
