//
//  BMTBanner.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel/JSONAPI.h"
#import "SDWebImage/SDImageCache.h"
#import "SDWebImage/SDWebImageDownloader.h"

typedef NS_ENUM(NSInteger, LanguageType) {
  CHINESE = 1,
  ENGLISH = 2
};
typedef NS_ENUM(NSInteger,StatusType)
{
  PUBLISHED=0,
  DELETED=1
};
typedef NS_ENUM (NSInteger ,PosterType)
{
  WEB_HOME=1,
  WEB_KNOWLEDGE,
  WAP_KNOWLEDGE
};
@interface BMTBanner : JSONModel

@property(strong, nonatomic) NSString *altText;
@property(assign, nonatomic) NSInteger height;
@property(assign, nonatomic) NSInteger width;
@property(strong, nonatomic) NSString *href;
@property(strong, nonatomic) NSString *imgSrc;
@property(assign, nonatomic) LanguageType language;

@property (assign, nonatomic) StatusType status;
@property (assign, nonatomic) PosterType type;
@property (weak, nonatomic) UIImage<Optional> *bannerImage;


@end
