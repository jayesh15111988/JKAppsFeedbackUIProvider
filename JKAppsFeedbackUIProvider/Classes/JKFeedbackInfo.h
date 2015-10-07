//
//  JKFeedbackInfo.h
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/6/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FeedbackSubmissionComplete)(id serverResponse);
typedef void (^FeedbackSubmissionError)(NSError* error);

@interface JKFeedbackInfo : NSObject

- (instancetype)initWithApplogoImage:(UIImage*)logoImage andAppName:(NSString*)appName andFeedbackViewBackgorundColor:(UIColor*)backgroundColor andFeedbackCompletionBlock:(FeedbackSubmissionComplete)completionBlock andFeedbackErrorBlock:(FeedbackSubmissionError)errorBlock;

@property (nonatomic, strong, readonly) UIImage* appLogoImage;
@property (nonatomic, copy, readonly) NSString* appName;
@property (nonatomic, strong, readonly) UIColor* feedbackViewBackgroundColor;
@property (nonatomic, strong) FeedbackSubmissionComplete feedbackSubmissionCompletionBlock;
@property (nonatomic, strong) FeedbackSubmissionError feedbackSubmissionErrorBlock;

@end
