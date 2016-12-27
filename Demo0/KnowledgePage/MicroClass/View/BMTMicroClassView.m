/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTMicroClassView.m 
 * Created by ray wang on 16/12/27.
 */

#import <SDWebImage/UIImageView+WebCache.h>
#import "BMTMicroClassView.h"
#import "UILabel+RefreshPanelView.h"

@implementation BMTMicroClassView {

}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self addSubviews];
  self.backgroundColor = [UIColor clearColor];
  return self;
}
- (void)setUpWithEntity:(BMTMicroClassInfoEntity *)entity {
  self.weikeLabel.text = @"微课";
  [self.speakImageView setImage:[UIImage imageNamed:@"weike_2x.png"]];
  self.titleLabel.text = entity.title;

  self.participantsLabel.text = [entity.participants.description
      stringByAppendingString:@"人"];

  NSString *originalURLStr = entity.avatarAddress;

  NSLog(@"the original URL string is %@", originalURLStr);
  NSString *formatedURLStr = [originalURLStr
      stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
          characterSetWithCharactersInString:@"^ "]
          .invertedSet];

  NSLog(@"the formated URL string is %@", formatedURLStr);
  NSURL *knowledgeImageURL = [NSURL URLWithString:formatedURLStr];
  //NSString * Text=[NSString stringWithFormat:@"Row %@",self
  // .dataArray[indexPath.row].title];

  [self.avatarImageView sd_setImageWithURL:knowledgeImageURL
                          placeholderImage:[UIImage imageNamed:@"2.jpg"]
                                   options:SDWebImageRetryFailed
                                  progress:nil
                                 completed:
                                     ^(UIImage *image, NSError *error, SDImageCacheType
                                     cacheType, NSURL *completeImageURL) {
                                       //save the image here
                                       //banners[i].bannerImage=imageView.image;

                                       NSLog(@"refesh knowledgeInfo images, done!");
                                       switch (cacheType) {
                                         case SDImageCacheTypeNone:NSLog(@"knowledgeInfo Image 直接下载");
                                           break;
                                         case SDImageCacheTypeDisk:NSLog(@"knowledgeInfo Image 磁盘缓存");
                                           break;
                                         case SDImageCacheTypeMemory:NSLog(@"knowledgeInfo Image 内存缓存");
                                           break;
                                         default:break;
                                       }
                                     }];
  self.timeLabel.text = [self convertTime:entity.startTimestamp];
}

#pragma - private
- (void)addSubviews {

  _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,60,
                                                                   60)];

  _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(88,20,200,17)];

  _participantsLabel= [[UILabel alloc] initWithFrame:CGRectMake(88,45,60,14)];

  _timeLabel= [[UILabel alloc] initWithFrame:CGRectMake(150,45,70,14)];

  _speakImageView= [[UIImageView alloc] initWithFrame:CGRectMake(327,14,31,30)];

  _weikeLabel= [[UILabel alloc] initWithFrame:CGRectMake(327,51,20,15)];
  _weikeLabel.textAlignment=NSTextAlignmentCenter;

  [self addSubview:_avatarImageView];
  [self addSubview:_titleLabel];
  [self addSubview:_participantsLabel];
  [self addSubview:_speakImageView];
  [self addSubview:_weikeLabel];
  [self addSubview:_timeLabel];

}

- (NSString *)convertTime:(NSNumber *)time {
  return @"tomorrow 19:00";
}
@end