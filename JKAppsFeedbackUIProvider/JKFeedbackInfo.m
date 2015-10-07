//
//  JKFeedbackInfo.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/6/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKFeedbackInfo.h"

@implementation JKFeedbackInfo

- (instancetype)initWithApplogoImage:(UIImage*)logoImage andAppName:(NSString*)appName andFeedbackViewBackgorundColor:(UIColor*)backgroundColor andFeedbackCompletionBlock:(FeedbackSubmissionComplete)completionBlock andFeedbackErrorBlock:(FeedbackSubmissionError)errorBlock {
    if (self = [super init]) {
        _appLogoImage = logoImage;
        _appName = appName;
        _feedbackViewBackgroundColor = backgroundColor;
        _feedbackSubmissionCompletionBlock = completionBlock;
        _feedbackSubmissionErrorBlock = errorBlock;
    }
    return self;
}

@end
