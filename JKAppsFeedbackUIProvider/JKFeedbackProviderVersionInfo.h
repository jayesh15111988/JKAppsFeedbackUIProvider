//
//  JKFeedbackProviderVersionInfo.h
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKFeedbackProviderVersionInfo : NSObject

+ (NSString*)buildAndVersionInfo;
+ (NSString*)bundleIdentifier;

@end
