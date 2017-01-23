//
//  RWUIScrollView.m
//  Hello
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "RWUIScrollView.h"

@implementation RWUIScrollView

- (void)setStyle1 {
  self.frame = CGRectMake(0, 0, 375, 190.5);
  self.contentSize = CGSizeMake(4 * (375), 190.5);

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
  NSUInteger n = [banners count];
  for (NSUInteger i = 0; i < n; i++) {
    UIImageView *imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(i * 375, 0, 375, 190.5)];\
        NSLog(@"the original string is: %@ ", banners[i].imgSrc);
    NSString *convertedStr = [banners[i]
        .imgSrc stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"^"]
        .invertedSet];
    NSURL *imageURL = [NSURL URLWithString:convertedStr];

    [self addSubview:imageView];
    [imageView sd_setImageWithURL:imageURL
                 placeholderImage:[UIImage imageNamed:@"1"
                     ".jpg"]
                         options:SDWebImageRetryFailed
                         progress:^(NSInteger receivedSize,
                                    NSInteger expectedSize) {
                         
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType
                        cacheType, NSURL *imageURL) {
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
