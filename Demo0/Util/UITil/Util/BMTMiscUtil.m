/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuzesheng@bongmi.com
 */

#import "BMTMiscUtil.h"

#import "BMTNetConstant.h"
#import "BMTReminderManager.h"
#import "BMTReminderDetailTable.h"
#import "BMTReminderSummaryTable.h"
#import "BMTStorageManager.h"
#import "NSCalendar+BMTDateConvertor.h"

#define kBMTShowTutorialMeasure @"showTutorialMeasure"
#define kBMTShowTutorialChart   @"showTutorialChart"
#define kBMTShowTutorialReport  @"showTutorialReport"
#define kBMTShowVerticalChartGuideView @"showVerticalChartGuideView"

@implementation BMTMiscUtil

+ (NSData *)getIconImageData {
  return UIImageJPEGRepresentation(IMG(@"icon_share"), 1.0);
}

+ (NSData *)getCurrentScreenSnapshotDataForView:(UIView *)view {
  return [BMTMiscUtil getCurrentScreenSnapshotDataForView:view
                                               ofRectArea:view.bounds
                                                withScale:0];
}

+ (NSData *)getThumbnailForCurrentScreenSnapshotOfView:(UIView *)view {
  return [BMTMiscUtil getCurrentScreenSnapshotDataForView:view
                                               ofRectArea:view.bounds
                                                withScale:0.4];
}



+ (NSData *)getCurrentScreenSnapshotDataForView:(UIView *)view
                                     ofRectArea:(CGRect)rect
                                      withScale:(CGFloat)scale{
  UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
  [view drawViewHierarchyInRect:rect afterScreenUpdates:YES];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return UIImageJPEGRepresentation(image, 1.0);
}

+ (BOOL)isChineseLanguageEnvironment {
  NSArray *languages = [NSLocale preferredLanguages];
  NSString *currentLanguage = languages[0];
  return [currentLanguage hasPrefix:kChineseEnvironment];
}

+ (BMTSystemLanguageType)getLanguageType {
  NSArray *languages = [NSLocale preferredLanguages];
  for (NSString *currentLanguage in languages) {
    if ([currentLanguage  hasPrefix:kChineseEnvironment]) {
      return kBMTLanguageTypeChinese;
    }
    if ([currentLanguage hasPrefix:kEnglishEnvironment]) {
      return kBMTLanguageTypeEnglish;
    }
  }
  return kBMTLanguageTypeEnglish;
}

+ (void)setShowTutorialMeasureView:(BOOL)isShowTutorial {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setBool:isShowTutorial forKey:kBMTShowTutorialMeasure];
  [userDefault synchronize];
}

+ (void)setShowTutorialChartView:(BOOL)isShowTutorial {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setBool:isShowTutorial forKey:kBMTShowTutorialChart];
  [userDefault synchronize];
}

+ (void)setShowTutorialReportView:(BOOL)isShowTutorial {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setBool:isShowTutorial forKey:kBMTShowTutorialReport];
  [userDefault synchronize];
}

+ (void)setShowVerticalChartGuideView:(BOOL)isShowVerticalChartGuideView {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setBool:isShowVerticalChartGuideView forKey:kBMTShowVerticalChartGuideView];
  [userDefault synchronize];
}

+ (BOOL)showTutorialMeasureView {
  NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
  if ([userDefult objectForKey:kBMTShowTutorialMeasure] == nil) {

    return YES;
  } else {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:kBMTShowTutorialMeasure];
  }
}

+ (BOOL)showTutorialChartView {
  NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
  if ([userDefult objectForKey:kBMTShowTutorialChart] == nil) {
    return YES;
  } else {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:kBMTShowTutorialChart];
  }
}

+ (BOOL)showTutorialReportView {
  NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
  if ([userDefult objectForKey:kBMTShowTutorialReport] == nil) {
    return YES;
  } else {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:kBMTShowTutorialReport];
  }
}

+ (BOOL)showVertiCalChartGuideView {
  NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
  if ([userDefult objectForKey:kBMTShowVerticalChartGuideView] == nil) {
    return YES;
  } else {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault boolForKey:kBMTShowVerticalChartGuideView];
  }
}

+ (NSDate *)birthdayDefaultDate {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy/MM/dd"];
  return [df dateFromString:@"1990/01/01"];
}

+ (void)closeAllDefaultReminders {
  __block NSArray *allReminder;
  [[BMTStorageManager sharedInstance]
   inDBForReminderSummary:^NSError *(FMDatabase *db, BMTReminderSummaryTable *table) {
     allReminder = [table getAllReminderSummaries];
     return nil;
   }];
  
  for (BMTEntityReminderSummary *reminder in allReminder) {
    if ([reminder.onFlag boolValue]) {
      reminder.onFlag = @(0);
      @weakify(self);
      [BMTReminderManager updateReminderSummary:reminder
                         withCompletionCallback:^(id result, NSError *error) {
         DDLogDebug(@"reminder update finished with error:%@", error);
         @strongify(self);
         __block NSArray *reminderDetails;
         [[BMTStorageManager sharedInstance]
          inDBForReminderDetail:^NSError *(FMDatabase *db, BMTReminderDetailTable *table) {
            reminderDetails = [table getAllReminderDetailsBySummaryId:reminder.summaryId];
            return nil;
          }];
         [BMTReminderManager cancelReminderNotificationWithDetails:reminderDetails];
       }];
    }
  }
}

+ (NSMutableArray *)XValueDataStringsWithStartDate:(NSDate *)startDate
                                        andEndDate:(NSDate *)endDate {
   NSMutableArray *xValueStrings = [[NSMutableArray alloc] init];
   NSCalendar *calendar =
   [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
   NSDateComponents *dayComps;
   NSDateComponents *monthComps;
   while ([startDate timeIntervalSinceDate:endDate] <= 0.0) {
     dayComps = [calendar components:NSCalendarUnitDay fromDate:startDate];
     monthComps = [calendar components:NSCalendarUnitMonth fromDate:startDate];
     NSInteger day = [dayComps day];
     NSInteger month = [monthComps month];
     if (day == 1) {
       if ([[self class] isChineseLanguageEnvironment]) {
         [xValueStrings addObject:[NSString stringWithFormat:@"%ld%@", month, l10n(@"General.Month")]];
       } else {
         NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
         formatterMonth.dateFormat = @"MMM";
         [xValueStrings addObject:[NSString stringWithFormat:@"%@", [formatterMonth stringFromDate:startDate]]];
       }
     } else {
       [xValueStrings addObject:[NSString stringWithFormat:@"%ld", day]];
     }
     startDate = [calendar bmt_dateFromDate:startDate withDayOffset:1];
  }
   return xValueStrings;
}

+ (NSMutableArray *)getNewXValueDataStringsWithStartDate:(NSDate *)startDate
                                              andEndDate:(NSDate *)endDate {
  NSMutableArray *xValueStrings = [[NSMutableArray alloc] init];
  NSCalendar *calendar =
  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *dayComps;
  NSDateComponents *monthComps;
  while ([startDate timeIntervalSinceDate:endDate] <= 0.0) {
    dayComps = [calendar components:NSCalendarUnitDay fromDate:startDate];
    monthComps = [calendar components:NSCalendarUnitMonth fromDate:startDate];
    NSInteger day = [dayComps day];
    NSInteger month = [monthComps month];
    [xValueStrings addObject:[NSString stringWithFormat:@"%ld/%ld", month, day]];
    startDate = [calendar bmt_dateFromDate:startDate withDayOffset:1];
  }
  return xValueStrings;
}

#pragma mark - Profile -> Contact us

+ (void)openSystemPhone:(NSString *)phoneNumber {
  [[UIApplication sharedApplication] openURL:
   [NSURL URLWithString:
    [NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
}

+ (void)openSystemEmail:(NSString *)email {
  [[UIApplication sharedApplication] openURL:
   [NSURL URLWithString:
    [NSString stringWithFormat:@"mailto://%@", email]]];
}

+ (void)copyStringToPasteboard:(NSString *)content {
  [[UIPasteboard generalPasteboard] setPersistent:YES];
  [[UIPasteboard generalPasteboard] setValue:content
                           forPasteboardType:[UIPasteboardTypeListString objectAtIndex:0]];
}

#pragma mark - Device -> Electric Quantity

+ (NSString *)getFemometerElectricQuantity:(CGFloat)batteryLevel {
  if (batteryLevel > 0.0 && batteryLevel <= 10.0) {
    return l10n(@"Device.ElectricQuantity.Low");
  } else if (batteryLevel > 10.0 && batteryLevel <= 90.0) {
    return l10n(@"Device.ElectricQuantity.Mid");
  } else if (batteryLevel > 90.0 && batteryLevel <= 100.0) {
    return l10n(@"Device.ElectricQuantity.High");
  } else {
    return nil;
  }
}

+ (CGFloat)getSystemVersion {
  CGFloat systemVersionNum =
  [[[UIDevice currentDevice] systemVersion] doubleValue];
  return systemVersionNum;
}


+ (NSMutableArray *)binaryToDecimal:(NSInteger)decimal
                         andBitsNum:(NSInteger)bitsNum {
  NSInteger num = decimal;
  NSInteger remainder = 0;
  NSInteger divisor = 0;
  
  NSString *prepare = @"";
  while (true) {
    remainder = num % 2;
    divisor = num / 2;
    num = divisor;
    prepare = [prepare stringByAppendingFormat:@"%ld", remainder];
    
    if (divisor == 0) {
      break;
    }
  }
  
  NSMutableArray *binaryArray = [[NSMutableArray alloc] init];
  for (NSInteger index = 0; index < bitsNum; index++) {
    if (index < prepare.length) {
      [binaryArray addObject:[[NSNumber alloc] initWithInteger:
                              [[prepare substringWithRange:NSMakeRange(index , 1)] integerValue]]];
    } else {
      [binaryArray addObject:[[NSNumber alloc] initWithInteger:0]];
    }
  }
  return binaryArray;
}

+ (NSInteger)decimalToBinary:(NSArray *)binaryArray {
  NSInteger decimal = 0;
  for (NSInteger index = binaryArray.count - 1; index >= 0; index--) {
    decimal += [binaryArray[index] integerValue] * (1 << index);
  }
  return decimal;
}

+ (NSString *)componentsJoinedByComma:(NSArray *)content {
  if ([[self class] isChineseLanguageEnvironment]) {
    return [content componentsJoinedByString:@"、"];
  } else {
    return [content componentsJoinedByString:@", "];
  }
}


+ (NSString *)getEncryptedPhoneNumber:(NSString *)phoneNumber {
  return [phoneNumber stringByReplacingOccurrencesOfString:
          [phoneNumber substringWithRange:NSMakeRange(3,4)] withString:@"****"];
}

+ (NSString *)getEncryptedEmail:(NSString *)email {
  NSRange range = [email rangeOfString:@"@"];
  NSString *subStringBeforeAt = [email substringToIndex:range.location];
  NSString *subStringAfterAt = [email substringFromIndex:range.location];
  if (subStringBeforeAt.length <= 3) {
    return [[subStringBeforeAt stringByAppendingString:@"****"]
            stringByAppendingString:subStringAfterAt];
  } else {
    return [[[subStringBeforeAt substringWithRange:NSMakeRange(0, 3)] stringByAppendingString:@"****"]
            stringByAppendingString:subStringAfterAt];
  }
}

+ (BOOL)isValidMobile:(NSString *)mobile {
  // 电信号段:133/153/180/181/189/177
  // 联通号段:130/131/132/155/156/185/186/145/176
  // 移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
  // 虚拟运营商:170
  //  NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
  //  NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
  //return [phoneTest evaluateWithObject:mobile];
  if (mobile.length == 11) {
    return [mobile hasPrefix:@"1"];
  }
  return NO;
}

+ (BOOL)isValidEmail:(NSString *)email {
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

+ (BOOL)isFloatNumber:(NSString *)string {
  return [string containsString:@"."];
}

+ (BOOL)isValidPassword:(NSString *)password {
  NSString *passwordRegex = @"((?=.*\\d)(?=.*\\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))^.{8,18}$";
  NSPredicate *passowrdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
  return [passowrdTest evaluateWithObject:password];
}

+ (BOOL)isNumberValue:(NSString *)string {
  NSString *passwordRegex = @"^[+-]?([0-9]*\\.?[0-9]+|[0-9]+\\.?[0-9]*)([eE][+-]?[0-9]+)?$";
  NSPredicate *passowrdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
  return [passowrdTest evaluateWithObject:string];
}

+ (NSDictionary*)parseQueryForDictionary:(NSString *)query {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  for (NSString *param in [query componentsSeparatedByString:@"&"]) {
    NSArray *datas = [param componentsSeparatedByString:@"="];
    if([datas count] == 2) {
      [params setObject:[datas lastObject]
                 forKey:[datas firstObject]];
    } else if ([datas count] > 2) {
      NSMutableString *key = [NSMutableString stringWithString:datas[1]];
      for (NSInteger index = 2; index < datas.count; index++) {
        [key appendString:@"="];
        [key appendString:datas[index]];
      }
      [params setObject:key
                 forKey:[datas firstObject]];
    }
  }
  return params;
}

+ (CGSize)caculateContentSizeWithText:(NSString *)text
                             maxWidth:(CGFloat)maxWidth
                          andTextFont:(UIFont *)textFont {
  if (text.length == 0) {
    return CGSizeZero;
  }
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
  [attributedString addAttribute:NSFontAttributeName
                           value:textFont
                           range:NSMakeRange(0 ,attributedString.length)];
//  CGSize textSize = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
//                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                                   context:nil].size;
  NSRange range = NSMakeRange(0, attributedString.length);
  NSDictionary* dic = [attributedString attributesAtIndex:0 effectiveRange:&range];
  NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
  if (!paragraphStyle || nil == paragraphStyle) {
    paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = 0.0; 
    paragraphStyle.headIndent = 0;
    paragraphStyle.tailIndent = 0;
    paragraphStyle.lineHeightMultiple = 0;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.firstLineHeadIndent = 0;
    paragraphStyle.paragraphSpacing = 0;
    paragraphStyle.paragraphSpacingBefore = 0;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
  }
  
  //设置默认字体属性
  UIFont *font = dic[NSFontAttributeName];
  if (!font || nil == font) {
    font = [UIFont fontWithName:@"Bariol" size:12.0];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
  }
  
  NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
  [attDic setObject:font forKey:NSFontAttributeName];
  [attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
  
  CGSize textSize = [[attributedString string] boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:attDic
                                                            context:nil].size;
  
  return textSize;
}

+ (void)exchangeButtonTitleAndImagePosition:(UIButton *)button
                                       font:(UIFont *)titleFont
                                      title:(NSString *)title
                                   andImage:(UIImage *)image {
  CGFloat titleWidth = [self caculateContentSizeWithText:title
                                                maxWidth:WIDTH_SCREEN
                                             andTextFont:titleFont].width;
  CGFloat imageWidth = image.size.width;
  [button setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth + 2, 0, - titleWidth - 2)];
  [button setTitleEdgeInsets:UIEdgeInsetsMake(0, - imageWidth - 2, 0, imageWidth + 2)];
}

+ (NSString *)getRelativeAvatarAddress:(NSString *)avatarUrl {
  NSRange range = [avatarUrl rangeOfString:kNetAvatarAdddressHost];
  return [avatarUrl substringFromIndex:range.length];
}

+ (NSString *)getRemoteAvatarAddress:(NSString *)relativeAvatarUrl {
  return [kNetAvatarAdddressHost stringByAppendingString:relativeAvatarUrl];
}

+ (NSString *)toThoundsUnitNumberString:(NSInteger)number {
  static NSInteger hUnit = 100;
  static NSInteger kUnit = 1000;
  static NSInteger tUnit = 100000;
  static NSInteger mUnit = 1000000;
  static NSInteger minLimit = 1000;
  static NSInteger maxLimit = 1000000;
  
  if (number < minLimit) {
    return [NSString stringWithFormat:@"%ld", number];
  } else if (number >= minLimit && number < maxLimit) {
    NSInteger kNum = number / kUnit;
    NSInteger hNum = number % kUnit / hUnit;
    return [NSString stringWithFormat:@"%ld.%ldk", kNum, hNum];
  } else {
    NSInteger mNum = number / mUnit;
    NSInteger tNum = number % mUnit / tUnit;
    return [NSString stringWithFormat:@"%ld.%ldM", mNum, tNum];
  }
}

+ (NSString *)toTenThoundsUnitNumberString:(NSInteger)number {
  static NSInteger wUnit = 100000;
  
  if (number < wUnit) {
    return [NSString stringWithFormat:@"%ld", (long)number];
  } else {
    return @"10W+";
  }
}

+ (NSInteger)getRandomNumberFrom:(NSInteger)start
                              to:(NSInteger)end {
  return (start + (arc4random() % (end - start + 1)));
}

+ (NSInteger)getUserSource {
  NSInteger source = 0;
#ifdef THERACKER_VERSION
  source = 2;  // easy@home
#endif
  
#ifdef THERMOMETER_VERSION
  source = 0; // femometer
#endif
  return source;
}

@end
