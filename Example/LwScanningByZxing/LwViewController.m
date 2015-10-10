//
//  LwViewController.m
//  LwScanningByZxing
//
//  Created by liaowei on 10/09/2015.
//  Copyright (c) 2015 liaowei. All rights reserved.
//

#import "LwViewController.h"
#import "LwScanView.h"

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
}

- (void)prepareForAction
{
}


#pragma mark
#pragma mark Event Response

#pragma mark
#pragma mark Getter/Setter
#pragma mark - Private Methods

@end
