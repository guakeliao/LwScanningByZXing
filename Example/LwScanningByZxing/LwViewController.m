//
//  LwViewController.m
//  LwScanningByZxing
//
//  Created by liaowei on 10/09/2015.
//  Copyright (c) 2015 liaowei. All rights reserved.
//

#import "LwViewController.h"
#import "LwScanView.h"
#import "LwCreateViewController.h"

@interface LwViewController ()

@property (weak, nonatomic) IBOutlet LwScanView *scanView;

@end

@implementation LwViewController

#pragma mark
#pragma mark Init

#pragma mark
#pragma mark Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForData];
    [self prepareForView];
    [self prepareForAction];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scanView start];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.scanView stop];
}

#pragma mark
#pragma mark PrepareConfig

- (void)prepareForData
{
}

- (void)prepareForView
{
    self.title = @"扫描二维码";
    self.navigationItem.leftBarButtonItem =
        [self barButtonItemWithTitle:@"生成" andAction:@selector(createImage:)];

    //识别二维码
    //    self.callBack = ^(id data) {
    //        NSLog(@"%@", data);
    //    };
}

- (void)prepareForAction
{
    //扫描二维码
    self.scanView.callBack = ^(id data) {
      NSLog(@"%@", data);
    };
}

#pragma mark
#pragma mark Event Response
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
    LwCreateViewController *createVC = [[LwCreateViewController alloc] init];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:createVC]
//          animated:YES
//        completion:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}
#pragma mark
#pragma mark Getter/Setter
#pragma mark - Private Methods

@end
