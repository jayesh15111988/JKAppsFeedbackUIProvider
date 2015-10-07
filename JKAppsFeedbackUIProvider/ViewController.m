//
//  ViewController.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKAppsFeedbackProviderViewController.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JKAppsFeedbackProviderViewController* feedbackController = [[JKAppsFeedbackProviderViewController alloc] init];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:feedbackController animated:YES completion:NULL];
     }

@end
