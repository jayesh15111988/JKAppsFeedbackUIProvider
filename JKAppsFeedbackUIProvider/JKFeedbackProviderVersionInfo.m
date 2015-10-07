//
//  JKFeedbackProviderVersionInfo.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKFeedbackProviderVersionInfo.h"

@implementation JKFeedbackProviderVersionInfo

+ (NSString*)buildAndVersionInfo {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    NSString* versionAndBuild = [NSString stringWithFormat:@"Version %@ Build %@ ", version, build];
    #ifdef DEBUG
        versionAndBuild = [versionAndBuild stringByAppendingString:@"DEBUG"];
    #else
        versionAndBuild = [versionAndBuild stringByAppendingString:@"RELEASE"];
    #endif
    return versionAndBuild;
}

+ (NSString*)bundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
}


@end
