//
//  BMTBannerEntity.h
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
typedef NS_ENUM(NSInteger, StatusType) {
  PUBLISHED = 0,
  DELETED = 1
};
typedef NS_ENUM (NSInteger, PosterType) {
  WEB_HOME = 1,
  WEB_KNOWLEDGE,
  WAP_KNOWLEDGE
};
@interface BMTBannerEntity : JSONModel

@property(strong, nonatomic) NSString<Optional> *name;// Prim Key
@property(strong, nonatomic) NSString *href;
@property(strong, nonatomic) NSString *imgSrc;
@property(strong, nonatomic) NSString<Optional>  *altText;

@property(strong, nonatomic) NSNumber<Optional>  *height;
@property(strong, nonatomic) NSNumber<Optional>  *width;
@property(strong, nonatomic) NSString<Optional>  *language;

@property(strong, nonatomic) NSNumber<Optional>  *status;
@property(strong, nonatomic) NSNumber<Optional>  *type;

- (instancetype)initWithDBRecord:(NSDictionary *)content;

- (NSDictionary *)encodeForDBRecord;
@end
