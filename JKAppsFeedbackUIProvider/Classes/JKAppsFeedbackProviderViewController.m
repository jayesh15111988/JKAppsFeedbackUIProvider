//
//  JKAppsFeedbackProviderViewController.m
//  JKAppsFeedbackUIProvider
//
//  Created by Jayesh Kawli Backup on 10/5/15.
//  Copyright © 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <JKAutolayoutReadyScrollView/ScrollViewAutolayoutCreator.h>
#import <EDColor/EDColor.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import "JKFeedbackProviderVersionInfo.h"
#import "JKFeedbackInfo.h"
#import "JKFeedbackProviderWebRequestManager.h"
#import "JKAppsFeedbackProviderViewController.h"

@interface JKAppsFeedbackProviderViewController ()

@property (nonatomic, assign) NSInteger stepValue;
@property (nonatomic, strong) NSString* appName;

@property (nonatomic, strong) UILabel* sliderValueLabel;
@property (nonatomic, strong) UIImage* appLogoImage;
@property (nonatomic, strong) UITextView* commentsTextView;
@property (nonatomic, strong) UITextView* improvementsTextView;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;
@property (nonatomic, strong) UIColor* feedbackViewBackgroundColor;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, strong) FeedbackSubmissionComplete feedbackSubmissionCompletionBlock;
@property (nonatomic, strong) FeedbackSubmissionError feedbackSubmissionErrorBlock;

@end

@implementation JKAppsFeedbackProviderViewController

- (instancetype)initWithFeedbackInfoObject:(JKFeedbackInfo*)feedbackInfoObject andFeedbackCompletionBlock:(FeedbackSubmissionComplete)completionBlock andFeedbackErrorBlock:(FeedbackSubmissionError)errorBlock{
    if (self = [super init]) {
        _appName = feedbackInfoObject.appName;
        _appLogoImage = feedbackInfoObject.appLogoImage;
        _feedbackViewBackgroundColor = feedbackInfoObject.feedbackViewBackgroundColor;
        _feedbackSubmissionCompletionBlock = completionBlock;
        _feedbackSubmissionErrorBlock = errorBlock;
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"EEEE, dd MMMM yyyy hh:mm a"];
        _feedbackURLString = @"http://jayeshkawli.com/iOSAppsFeedback/iOSAppsFeedback.php";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stepValue = 1;
    UIColor* generalTextColor = [UIColor blackColor];
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake (0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem* flexibleSpace =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector (doneButtonPressed)];
    toolbar.items = @[ flexibleSpace, doneButton ];
    self.view.backgroundColor = self.feedbackViewBackgroundColor;
    ScrollViewAutolayoutCreator* autolayoutEquippedScrollView =
        [[ScrollViewAutolayoutCreator alloc] initWithSuperView:self.view andHorizontalScrollingEnabled:NO];

    self.activityIndicator = [UIActivityIndicatorView new];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.activityIndicator.color = [UIColor blackColor];
    [self.activityIndicator hidesWhenStopped];
    
    UIFont* generalHeaderFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    UIView* scrollViewContent = autolayoutEquippedScrollView.contentView;

    
    [scrollViewContent addSubview:self.activityIndicator];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:scrollViewContent attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:scrollViewContent attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    
    UIImageView* appLogoView = [UIImageView new];
    appLogoView.translatesAutoresizingMaskIntoConstraints = NO;
    appLogoView.contentMode = UIViewContentModeScaleAspectFit;
    appLogoView.image = self.appLogoImage;
    [scrollViewContent addSubview:appLogoView];

    UILabel* appNameLabel = [UILabel new];
    appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    appNameLabel.text = self.appName;
    appNameLabel.textColor = generalTextColor;
    appNameLabel.textAlignment = NSTextAlignmentCenter;
    appNameLabel.font = generalHeaderFont;
    [scrollViewContent addSubview:appNameLabel];

    UIView* commentsView = [UIView new];
    commentsView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollViewContent addSubview:commentsView];

    UILabel* commentsHeaderLabel = [UILabel new];
    commentsHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    commentsHeaderLabel.text = @"Comments";
    commentsHeaderLabel.textColor = generalTextColor;
    commentsHeaderLabel.textAlignment = NSTextAlignmentCenter;
    commentsHeaderLabel.font = generalHeaderFont;
    [commentsView addSubview:commentsHeaderLabel];

    self.commentsTextView = [UITextView new];
    self.commentsTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.commentsTextView.textAlignment = NSTextAlignmentLeft;
    self.commentsTextView.backgroundColor = [UIColor colorWithCrayola:@"Aquamarine"];
    self.commentsTextView.inputAccessoryView = toolbar;
    [commentsView addSubview:self.commentsTextView];

    UIView* imporvementsView = [UIView new];
    imporvementsView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollViewContent addSubview:imporvementsView];

    UILabel* improvementsHeaderLabel = [UILabel new];
    improvementsHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    improvementsHeaderLabel.text = @"Improvements Suggestion";
    improvementsHeaderLabel.textColor = generalTextColor;
    improvementsHeaderLabel.textAlignment = NSTextAlignmentCenter;
    improvementsHeaderLabel.font = generalHeaderFont;
    [imporvementsView addSubview:improvementsHeaderLabel];

    self.improvementsTextView = [UITextView new];
    self.improvementsTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.improvementsTextView.textAlignment = NSTextAlignmentLeft;
    self.improvementsTextView.backgroundColor = [UIColor colorWithCrayola:@"Aquamarine"];
    self.improvementsTextView.inputAccessoryView = toolbar;
    [imporvementsView addSubview:self.improvementsTextView];

    UIView* ratingsView = [UIView new];
    ratingsView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollViewContent addSubview:ratingsView];

    self.sliderValueLabel = [UILabel new];
    self.sliderValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sliderValueLabel.text = @"1";
    self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
    self.sliderValueLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    [ratingsView addSubview:self.sliderValueLabel];

    UILabel* ratingHeaderLabel = [UILabel new];
    ratingHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    ratingHeaderLabel.text = @"App Rating (1-10)";
    ratingHeaderLabel.textColor = generalTextColor;
    ratingHeaderLabel.textAlignment = NSTextAlignmentCenter;
    ratingHeaderLabel.font = generalHeaderFont;
    [ratingsView addSubview:ratingHeaderLabel];

    UISlider* slider = [UISlider new];
    slider.minimumValue = 1;
    slider.maximumValue = 10;
    [slider setTintColor:[UIColor colorWithCrayola:@"Pacific Blue"]];
    [slider addTarget:self action:@selector (sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [ratingsView addSubview:slider];

    UIButton* submitButton = [UIButton new];
    submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [submitButton setTitle:@"Submit Feedback" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor colorWithCrayola:@"Pacific Blue"]];
    [submitButton setTitleColor:[UIColor colorWithCrayola:@"Pine"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector (sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewContent addSubview:submitButton];

    NSDictionary* metrics = @{ @"padding" : @(10), @"doublePadding" : @(20) };
    NSDictionary* views =
        NSDictionaryOfVariableBindings (appLogoView, appNameLabel, commentsView, commentsHeaderLabel, _commentsTextView,
                                        imporvementsView, improvementsHeaderLabel, _improvementsTextView, ratingsView,
                                        _sliderValueLabel, slider, submitButton, ratingHeaderLabel);

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:appLogoView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:appLogoView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:100]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-doublePadding-[appLogoView(100)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[appNameLabel]-padding-|"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[appLogoView]-padding-[appNameLabel(44)]"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[commentsView]-padding-|"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[appNameLabel]-padding-[commentsView(115)]"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[commentsHeaderLabel]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsHeaderLabel(20)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_commentsTextView]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:[commentsHeaderLabel]-padding-[_commentsTextView(75)]"
                                                      options:kNilOptions
                                                      metrics:metrics
                                                        views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[imporvementsView]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:[commentsView]-doublePadding-[imporvementsView(115)]"
                                                      options:kNilOptions
                                                      metrics:metrics
                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"H:|-padding-[improvementsHeaderLabel]-padding-|"
                                                      options:kNilOptions
                                                      metrics:metrics
                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[improvementsHeaderLabel(20)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_improvementsTextView]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                                                      @"V:[improvementsHeaderLabel]-padding-[_improvementsTextView(75)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[ratingsView]-padding-|"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:[imporvementsView]-doublePadding-[ratingsView(100)]"
                                                      options:kNilOptions
                                                      metrics:metrics
                                                        views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[ratingHeaderLabel]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ratingHeaderLabel(24)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[slider]-padding-|"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingHeaderLabel]-padding-[slider(31)]"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];

    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_sliderValueLabel]-padding-|"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];
    [self.view
        addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[slider]-padding-[_sliderValueLabel(30)]"
                                                               options:kNilOptions
                                                               metrics:metrics
                                                                 views:views]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:submitButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:submitButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:260]];
    [self.view
        addConstraints:[NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:[ratingsView]-doublePadding-[submitButton(44)]-padding-|"
                                               options:kNilOptions
                                               metrics:metrics
                                                 views:views]];
}

- (void)sendFeedback:(UIButton*)sender {
    sender.enabled = NO;
    [self.activityIndicator startAnimating];

    NSString* currentDateAndTimeString = [_dateFormatter stringFromDate:[NSDate date]];
    NSDictionary* feedbackPayload = @{
        @"version" : [JKFeedbackProviderVersionInfo buildAndVersionInfo],
        @"bundleIdentifier" : [JKFeedbackProviderVersionInfo bundleIdentifier],
        @"appName" : self.appName,
        @"comments" : self.commentsTextView.text,
        @"improvementsSuggestion" : self.improvementsTextView.text,
        @"rating" : self.sliderValueLabel.text,
        @"dateTime" : currentDateAndTimeString
    };

    [[[[JKFeedbackProviderWebRequestManager sharedRequestManager] manager]
          rac_POST:self.feedbackURLString
        parameters:feedbackPayload] subscribeNext:^(id x) {
      NSDictionary* response = [x first];
        [self.activityIndicator stopAnimating];
      if ([response[@"success"] boolValue]) {
          if (self.feedbackSubmissionCompletionBlock) {
              self.feedbackSubmissionCompletionBlock (response);
          }
      } else {
          sender.enabled = YES;
          NSDictionary* userInfo =
              @{ NSLocalizedDescriptionKey : NSLocalizedString (@"Failed to send an email with unknown error.", nil) };
          NSError* error =
              [NSError errorWithDomain:[JKFeedbackProviderVersionInfo bundleIdentifier] code:13 userInfo:userInfo];

          if (self.feedbackSubmissionErrorBlock) {
              self.feedbackSubmissionErrorBlock (error);
          }
      }
    } error:^(NSError* error) {
        [self.activityIndicator stopAnimating];
        sender.enabled = YES;
      if (self.feedbackSubmissionErrorBlock) {
          self.feedbackSubmissionErrorBlock (error);
      }
    }];
}

- (void)sliderValueChanged:(UISlider*)slider {
    CGFloat newStep = roundf ((slider.value) / self.stepValue);
    slider.value = newStep * self.stepValue;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%ld", (long)slider.value];
}

- (void)doneButtonPressed {
    [self.view endEditing:YES];
}

@end
