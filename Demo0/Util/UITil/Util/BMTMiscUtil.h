/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: wuzesheng@bongmi.com
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMTResourceSystemLanguageType.h"

#define kEnglishEnvironment @"en"
#define kChineseEnvironment @"zh-Hans"

@interface BMTMiscUtil : NSObject

+ (NSData *)getIconImageData;

+ (NSData *)getCurrentScreenSnapshotDataForView:(UIView *)view;

+ (NSData *)getThumbnailForCurrentScreenSnapshotOfView:(UIView *)view;

+ (NSData *)getCurrentScreenSnapshotDataForView:(UIView *)view
                                     ofRectArea:(CGRect)rect
                                      withScale:(CGFloat)scale;

+ (BOOL)isChineseLanguageEnvironment;

+ (BMTSystemLanguageType)getLanguageType;

+ (void)setShowTutorialReportView:(BOOL)isShowTutorial;

+ (void)setShowTutorialChartView:(BOOL)isShowTutorial;

+ (void)setShowTutorialMeasureView:(BOOL)isShowTutorial;

+ (void)setShowVerticalChartGuideView:(BOOL)isShowVerticalChartGuideView;

+ (BOOL)showTutorialMeasureView;

+ (BOOL)showTutorialChartView;

+ (BOOL)showTutorialReportView;

+ (BOOL)showVertiCalChartGuideView;

+ (NSDate *)birthdayDefaultDate;

+ (void)closeAllDefaultReminders;

+ (NSMutableArray *)getNewXValueDataStringsWithStartDate:(NSDate *)startDate
                                              andEndDate:(NSDate *)endDate;

+ (NSMutableArray *)XValueDataStringsWithStartDate:(NSDate *)startDate
                                        andEndDate:(NSDate *)endDate;

// Profile -> Contact us
+ (void)openSystemPhone:(NSString *)phoneNumber;

+ (void)openSystemEmail:(NSString *)email;

+ (void)copyStringToPasteboard:(NSString *)content;

// Device -> Electric Quantity
+ (NSString *)getFemometerElectricQuantity:(CGFloat)batteryLevel;

+ (CGFloat)getSystemVersion;

+ (NSMutableArray *)binaryToDecimal:(NSInteger)decimal
                         andBitsNum:(NSInteger)bitsNum;

+ (NSInteger)decimalToBinary:(NSArray *)binaryArray;

+ (NSString *)componentsJoinedByComma:(NSArray *)content;

+ (NSString *)getEncryptedEmail:(NSString *)email;

+ (NSString *)getEncryptedPhoneNumber:(NSString *)phoneNumber;

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidMobile:(NSString *)mobile;

+ (BOOL)isFloatNumber:(NSString *)string;

+ (BOOL)isValidPassword:(NSString *)password;

+ (BOOL)isNumberValue:(NSString *)string;

+ (NSDictionary*)parseQueryForDictionary:(NSString *)query;

+ (CGSize)caculateContentSizeWithText:(NSString *)text
                             maxWidth:(CGFloat)maxWidth
                          andTextFont:(UIFont *)textFont;

+ (void)exchangeButtonTitleAndImagePosition:(UIButton *)button
                                       font:(UIFont *)titleFont
                                      title:(NSString *)title
                                   andImage:(UIImage *)image;

+ (NSString *)getRelativeAvatarAddress:(NSString *)avatarUrl;

+ (NSString *)getRemoteAvatarAddress:(NSString *)relativeAvatarUrl;

+ (NSString *)toThoundsUnitNumberString:(NSInteger)number;

+ (NSString *)toTenThoundsUnitNumberString:(NSInteger)number;

+ (NSInteger)getRandomNumberFrom:(NSInteger)start
                              to:(NSInteger)end;
+ (NSInteger)getUserSource;

@end
