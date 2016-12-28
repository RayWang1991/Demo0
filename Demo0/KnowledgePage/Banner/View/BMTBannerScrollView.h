//
//  BMTBannerScrollView.h
//  Hello
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "Constants.h"
#import <UIKit/UIKit.h>
#import "BMTBannerScrollView.h"
#import "Masonry/Masonry.h"
#import "BMTEntityBanner.h"
@interface BMTBannerScrollView : UIScrollView
@property (assign,nonatomic) NSUInteger bannerNumber;
@property (strong, nonatomic) NSMutableArray <UIImageView *>* bannerImageViews;

-(instancetype)initWithBannerNumber:(NSUInteger)num;
- (void)setStyle;
- (void)LoadImagesFromBanners:(NSArray<BMTEntityBanner *>  *)banners;
@end
