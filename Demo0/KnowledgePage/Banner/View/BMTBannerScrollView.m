//
//  BMTBannerScrollView.m
//  Hello
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "BMTBannerScrollView.h"

@implementation BMTBannerScrollView

- (instancetype)initWithBannerNumber:(NSUInteger)num {
  self=[super init];
  if(self){
    // set bannerImageViews (no images are available here)
    _bannerNumber=num;
    _bannerImageViews= [[NSMutableArray alloc] initWithCapacity:num];
    for(NSUInteger i=0;i<num;i++){
      UIImageView * view=[[UIImageView alloc] initWithFrame:CGRectMake(i *
          375, 0, 375, 190.5)];
      [_bannerImageViews addObject:view];
      [self addSubview:view];
    }

  }
  return self;
}

- (void)setStyle {
  self.frame = CGRectMake(0, 0, 375, 190.5);
  self.contentSize = CGSizeMake(self.bannerNumber * (375), 190.5);

  self.pagingEnabled = YES;
  self.scrollEnabled = YES;
  self.showsVerticalScrollIndicator = NO;
  self.showsHorizontalScrollIndicator = NO;
  self.bounces = YES;
  self.alwaysBounceVertical = NO;
  self.alwaysBounceHorizontal = YES;
  self.backgroundColor = [UIColor blueColor];


}

- (void)LoadImagesFromBanners:(NSArray<BMTEntityBanner *> *)banners {
  NSCAssert(banners.count>=self.bannerNumber,@"banner shortage!");
  NSUInteger n = self.bannerNumber;
  for (NSUInteger i = 0; i < n; i++) {
    UIImageView *imageView =self.bannerImageViews[i];
    NSString *convertedStr = [banners[i]
        .imgSrc stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"^"]
        .invertedSet];
    NSURL *imageURL = [NSURL URLWithString:convertedStr];

    [imageView sd_setImageWithURL:imageURL
                 placeholderImage:[UIImage imageNamed:@"1"
                     ".jpg"]
                         options:SDWebImageRetryFailed
                         progress:^(NSInteger receivedSize,
                                    NSInteger expectedSize) {
                         
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType
                        cacheType, NSURL *completeImageURL) {
                          //save the image here
                           //banners[i].bannerImage=imageView.image;
                            
                          NSLog(@"refesh banner images, done!");
                          switch (cacheType) {
                            case SDImageCacheTypeNone:NSLog(@"Banner Image 直接下载");
                              break;
                            case SDImageCacheTypeDisk:NSLog(@"Banner Image 磁盘缓存");
                              break;
                            case SDImageCacheTypeMemory:NSLog(@"Banner Image 内存缓存");
                              break;
                            default:break;
                          }
                        }];

    NSLog(@"the cache path is: %@",
          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                               NSUserDomainMask,
                                               YES) lastObject]);


    //[imageView setImage:[UIImage imageNamed:@"1.jpg"]];
  }
}



@end
