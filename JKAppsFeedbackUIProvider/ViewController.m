//
//  ViewController.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <MJPopupViewController/UIViewController+MJPopupViewController.h>
#import "JKAppsFeedbackProviderViewController.h"
#import "JKFeedbackInfo.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    JKFeedbackInfo* feedbackInfoObject = [[JKFeedbackInfo alloc] initWithApplogoImage:[UIImage imageNamed:@"IMG_20150929_220147.jpg"] andAppName:@"Sample app" andFeedbackViewBackgorundColor:[UIColor colorWithRed:0.5 green:0.6 blue:0.2 alpha:0.5] andFeedbackCompletionBlock:^(id serverResponse) {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
    } andFeedbackErrorBlock:^(NSError *error) {
        
    }];
    JKAppsFeedbackProviderViewController* feedbackController = [[JKAppsFeedbackProviderViewController alloc] initWithFeedbackInfoObject:feedbackInfoObject];
    feedbackController.view.frame = CGRectMake(0, 0, 300, 500);
    [self presentPopupViewController:feedbackController animationType:MJPopupViewAnimationSlideTopTop];
}

@end
