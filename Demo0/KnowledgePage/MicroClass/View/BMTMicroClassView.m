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
  self.backgroundColor = [UIColor whiteColor];
  return self;
}
- (void)setUpWithEntity:(BMTMicroClassInfoEntity *)entity {
  self.weikeLabel.text = @"微课";
  [self.speakImageView setImage:[UIImage imageNamed:@"weike_2x.png"]];
  self.titleLabel.text = entity.title;

  self.participantsLabel.text = [entity.applicants.description
      stringByAppendingString:@"人"];

  NSString *originalURLStr = [@"http://lollypop-avatar.qiniudn.com/"
      stringByAppendingString:entity.avatarAddress];

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

  _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60,
                                                                   60)];
  _avatarImageView.layer.masksToBounds = YES;
  _avatarImageView.layer.cornerRadius = _avatarImageView.bounds.size.width / 2;

  _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 20, 200, 17)];
  _titleLabel.font = [UIFont fontWithName:@"Helvetica"
                                     size:17];
  _participantsLabel =
      [[UILabel alloc] initWithFrame:CGRectMake(88, 45, 60, 14)];
  _participantsLabel.font = [UIFont fontWithName:@"Helvetica"
                                            size:14];
  _participantsLabel.textColor = [UIColor colorWithWhite:0
                                                   alpha:0.54];
  _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 45, 120, 14)];
  _timeLabel.font = [UIFont fontWithName:@"Helvetica"
                                    size:14];
  _timeLabel.textColor = [UIColor colorWithWhite:0
                                           alpha:0.54];
  _speakImageView =
      [[UIImageView alloc] initWithFrame:CGRectMake(327, 14, 31, 30)];

  _weikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(327, 51, 30, 15)];
  _weikeLabel.textAlignment = NSTextAlignmentCenter;
  _weikeLabel.font = [UIFont fontWithName:@"Helvetica"
                                     size:14];

  UIView
      *separator = [[UIView alloc] initWithFrame:CGRectMake(307, 15, 1, 50)];
  separator.backgroundColor = [UIColor colorWithWhite:0
                                                alpha:0.12];

  [self addSubview:_avatarImageView];
  [self addSubview:_titleLabel];
  [self addSubview:_participantsLabel];
  [self addSubview:_speakImageView];
  [self addSubview:_weikeLabel];
  [self addSubview:_timeLabel];
  [self addSubview:separator];

}

- (NSString *)convertTime:(NSNumber *)time {
  NSMutableString *retString = [NSMutableString string];
  NSDate *now = [NSDate date];
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
  NSCalendar *gregorian =
      [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

  NSDateComponents *nowComp = [gregorian components:
          (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMonth
              | NSCalendarUnitDay | NSCalendarUnitYear)
                                           fromDate:now];

  NSDateComponents *dateComp = [gregorian components:
          (NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMonth
              | NSCalendarUnitDay | NSCalendarUnitYear)
                                            fromDate:date];

  if (dateComp.year == nowComp.year && dateComp.month == nowComp.month) {
    if (dateComp.day == nowComp.day) {
      [retString appendString:@"今天"];
    } else if (dateComp.day == nowComp.day + 1) {
      [retString appendString:@"明天"];
    } else if (dateComp.day == nowComp.day + 2) {
      [retString appendString:@"后天"];
    } else {
      [retString appendFormat:@"%d月%d日",
                              dateComp.month,
                              dateComp.day];
    }
  } else {
    [retString appendFormat:@"%d月%d日",
                            dateComp.month,
                            dateComp.day];
  }

  NSString *(^ getFullTime)(NSInteger)=^(NSInteger aTime) {
    return
        aTime < 10 ?
            [NSString stringWithFormat:@"0%d",
                                       aTime] :
            [NSString stringWithFormat:@"%d",
                                       aTime];
  };

  [retString appendFormat:@" %@:%@",
                          getFullTime(dateComp.hour),
                          getFullTime(dateComp.minute)];

  return retString;
}
@end
