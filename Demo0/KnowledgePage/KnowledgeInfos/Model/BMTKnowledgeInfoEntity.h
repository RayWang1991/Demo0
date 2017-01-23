/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeModel.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel/JSONAPI.h"
#import "SDWebImage/SDImageCache.h"
#import "SDWebImage/SDWebImageDownloader.h"
typedef NS_ENUM(NSInteger, CATEGORY_ID) {
  CAT_1 = 1,
  CAT_2,
  CAT_3,
  CAT_4,
};

@interface BMTKnowledgeInfoEntity : JSONModel
/*@property(nonatomic, assign, readwrite) CGRect backViewFrame;
@property(nonatomic, assign, readwrite) CGRect imageFrame;
@property(nonatomic, assign, readwrite) CGRect titleFrame;
@property(nonatomic, assign, readwrite) CGRect contentFrame;
@property(nonatomic, assign, readwrite) CGRect bottomFrame;
 */
//@property (nonatomic, assign, readwrite) CGRect timeLabelFrame;
@property(nonatomic) NSNumber *infoId;
@property(nonatomic) NSNumber *categoryId;
@property(nonatomic) NSNumber *like;
@property(nonatomic) NSNumber *click;
@property(nonatomic) NSNumber *timestamp;
@property(nonatomic) NSString *title;
@property(nonatomic) NSString *summary;
@property(nonatomic) NSString *thumbSrc;
@property(nonatomic) NSString<Optional>  *language;
@property(nonatomic) NSString *contentSrc;
@property(nonatomic) NSString<Optional>  *content;
@property(nonatomic) NSNumber<Optional>  *status;


- (instancetype)initWithDBRecord:(NSDictionary *)content;

- (NSDictionary *)encodeForDBRecord;

@end