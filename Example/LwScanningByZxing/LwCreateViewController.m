//
//  LwCreateViewController.m
//  LwScanningByZxing
//
//  Created by guakeliao on 15/10/13.
//  Copyright © 2015年 liaowei. All rights reserved.
//

#import "LwCreateViewController.h"
#import "LwCreateView.h"

@interface LwCreateViewController ()

@property (weak, nonatomic) IBOutlet LwCreateView *createView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LwCreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem =
        [self barButtonItemWithTitle:@"生成" andAction:@selector(createImage:)];
}
- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title andAction:(SEL)action
{
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setTitle:title forState:UIControlStateNormal];
    [buttonItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [buttonItem sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];
    return barItem;
}
- (void)createImage:(id)sender
{
    [self.createView createImage:CGSizeMake(1080, 1080)
                    successBlock:^(id image) {
                      self.imageView.image = image;
                    }];
}

@end
