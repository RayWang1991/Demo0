/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * UserInfoViewController.h 
 * Created by ray wang on 16/12/12.
 */

#import <Foundation/Foundation.h>
#import "KeyValueView.h"
#import <UIKit/UIKit.h>
#import "WRPersonModel.h"
#import "SQLManager.h"
#import "BMTBannerScrollView.h"
#import "NSFileManaer+WRFileManager.h"
#import "KnowledgePageViewController.h"

@interface UserInfoViewController : UIViewController<NSURLConnectionDelegate>
@property(strong, nonatomic) NSMutableData *dataFrag;
@property(strong, nonatomic) UILabel *userInfoTitle;
@property(strong, nonatomic) KeyValueView *userNameView;
@property(strong, nonatomic) KeyValueView *userSexView;
@property(strong, nonatomic) KeyValueView *userBirthdayView;
@property(strong, nonatomic) KeyValueView *userPhoneView;
@property(strong, nonatomic) KeyValueView *userEmailView;
@property(strong, nonatomic) UIButton *getUserInfoButton;
@property(strong, nonatomic) UIButton *readUserInfoButton;
@property(strong, nonatomic) UIButton *saveUserInfoButton;
@property(strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIButton *nextButton;

@property(strong,nonatomic) BMTBannerScrollView *bannerView;
@property(strong, nonatomic) WRPersonModel *personModel;

//TODO the knowledge page should be retained in a navigation view
@property (strong, nonatomic) KnowledgePageViewController *knowledgePageVC;

@end
