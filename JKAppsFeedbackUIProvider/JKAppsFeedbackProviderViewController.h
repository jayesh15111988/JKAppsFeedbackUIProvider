//
//  JKAppsFeedbackProviderViewController.h
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FeedbackSubmissionComplete)(id serverResponse);
typedef void (^FeedbackSubmissionError)(NSError* error);

@interface JKAppsFeedbackProviderViewController : UIViewController

@property (nonatomic, strong) NSString* feedbackURLString;

- (instancetype)initWithApplicationName:(NSString*)appName andAppLogoImage:(UIImage*)appLogoImage andFeedbackSubmissionCompletionBlock:(FeedbackSubmissionComplete)submissionCompletionBlock andFeedbackSubmissionErrorBlock:(FeedbackSubmissionError)submissionErrorBlock;

@end