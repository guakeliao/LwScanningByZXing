//
//  LwScanView.h
//  LwScanningByZxing
//
//  Created by guakeliao on 15/10/10.
//  Copyright © 2015年 liaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  扫描二维码
 */
@interface LwScanView : UIView

@property (nonatomic, copy) void (^callBack)(id data);


- (void)start;
- (void)stop;

@end
