//
//  BMTBannersViewController.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMTBannerEntity.h"
#import "BMTBannerScrollView.h"
#import "SQLManager.h"
#import "FMDBManager.h"
#import "SessionRequestManager.h"
#import "WRPersonModel.h"
#import "Constants.h"

@interface BMTBannersViewController : UIViewController<UIScrollViewDelegate>

@property(assign, nonatomic) NSInteger bannerNums;
@property(strong, nonatomic) NSArray<BMTBannerEntity *> *banners;
@property (strong, nonatomic) BMTBannerScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property(weak, nonatomic, readonly) SessionRequestManager *sessionRequestManager;
@property(weak, nonatomic, readonly) SQLManager *sqlManager;
@property (weak, nonatomic, readonly) FMDBManager *fmdbManager;
@property (weak, nonatomic, readonly) BMTBannerTable *bannerTable;
- (instancetype)initWithBannerNums:(NSInteger)num;
- (BOOL)refreshBanners;
@end
