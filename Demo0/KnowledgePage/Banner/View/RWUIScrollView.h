//
//  RWUIScrollView.h
//  Hello
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "Constants.h"
#import <UIKit/UIKit.h>
#import "RWUIScrollView.h"
#import "Masonry/Masonry.h"
#import "RWBanner.h"
@interface RWUIScrollView : UIScrollView

- (void)setStyle1;
- (void)LoadImagesFromBanners:(NSArray<RWBanner *>  *)banners;
@end
