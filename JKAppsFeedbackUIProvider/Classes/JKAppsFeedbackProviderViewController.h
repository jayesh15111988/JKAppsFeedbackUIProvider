//
//  JKAppsFeedbackProviderViewController.h
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKFeedbackInfo;

@interface JKAppsFeedbackProviderViewController : UIViewController

@property (nonatomic, strong) NSString* feedbackURLString;

- (instancetype)initWithFeedbackInfoObject:(JKFeedbackInfo*)feedbackInfoObject;

@end