//
//  BannersViewController.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWBanner.h"
#import "RWUIScrollView.h"
#import "SQLManager.h"
#import "SessionRequestManager.h"
#import "WRPersonModel.h"
#import "Constants.h"
@interface BannersViewController : UIViewController
@property(assign, nonatomic) NSInteger bannerNums;
@property(strong, nonatomic) NSMutableArray<RWBanner *> *banners;
@property(weak, nonatomic) SessionRequestManager *sessionRequestManager;
@property(weak, nonatomic) SQLManager *sqlManager;

- (instancetype)initWithBannerNums:(NSInteger)num;
@end
