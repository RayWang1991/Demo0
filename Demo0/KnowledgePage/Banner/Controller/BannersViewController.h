//
//  BannersViewController.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTBanner.h"
#import "RWUIScrollView.h"
#import "SQLManager.h"
#import "SessionRequestManager.h"
#import "WRPersonModel.h"
#import "Constants.h"

@interface BannersViewController : UIViewController

@property(assign, nonatomic) NSInteger bannerNums;
@property(strong, nonatomic) NSArray<BMTBanner *> *banners;
@property (strong, nonatomic) RWUIScrollView *scrollView;
@property(weak, nonatomic, readonly) SessionRequestManager *sessionRequestManager;
@property(weak, nonatomic, readonly) SQLManager *sqlManager;

- (instancetype)initWithBannerNums:(NSInteger)num;
- (BOOL)refreshBanners;
@end
