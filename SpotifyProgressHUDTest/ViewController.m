//
//  ViewController.m
//  SpotifyProgressHUDTest
//
//  Created by Paolo Boschini on 9/17/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import "ViewController.h"
#import "SpotifyProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SpotifyProgressHUD *progressView = [[SpotifyProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 150, 150)
                                                               withPointDiameter:16
                                                                    withInterval:0.25];
    progressView.center = self.view.center;
    [self.view addSubview:progressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
