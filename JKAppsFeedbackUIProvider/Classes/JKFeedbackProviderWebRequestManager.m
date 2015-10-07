//
//  JKFeedbackProviderWebRequestManager.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "JKFeedbackProviderWebRequestManager.h"

@implementation JKFeedbackProviderWebRequestManager

+ (instancetype)sharedRequestManager {
    
    static dispatch_once_t onceToken;
    static JKFeedbackProviderWebRequestManager* sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JKFeedbackProviderWebRequestManager alloc] init];
        sharedInstance.manager = [[AFHTTPRequestOperationManager alloc] init];
        sharedInstance.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        sharedInstance.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        sharedInstance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                                            @"application/json", nil];
        
    });
    return sharedInstance;
}


@end
