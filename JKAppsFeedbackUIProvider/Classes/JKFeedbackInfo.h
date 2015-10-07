//
//  JKFeedbackInfo.h
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/6/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JKFeedbackInfo : NSObject

- (instancetype)initWithApplogoImage:(UIImage*)logoImage andAppName:(NSString*)appName andFeedbackViewBackgorundColor:(UIColor*)backgroundColor;

@property (nonatomic, strong, readonly) UIImage* appLogoImage;
@property (nonatomic, copy, readonly) NSString* appName;
@property (nonatomic, strong, readonly) UIColor* feedbackViewBackgroundColor;

@end
