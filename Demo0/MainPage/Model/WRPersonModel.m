/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * personModel.m 
 * Created by ray wang on 16/12/12.
 */

#import "WRPersonModel.h"
#import <UIKit/UIKit.h>

@implementation WRPersonModel {

}

- (instancetype)initWithUserId:(unsigned int)anId
                          Name:(NSString *)aName
                           Sex:(NSString *)isMale
                      Birthday:(NSString *)aBirthday
                         Phone:(NSString *)aPhoneNum
                         Email:(NSString *)anEmail {
  self = [super init];
  if (self) {
    _userId = anId;
    _name = aName;
    _sex = isMale;
    _birthday = aBirthday;
    _phone = aPhoneNum;
    _email = anEmail;
  }
  return self;
}

+ (void)createPersonForTest {
  NSDictionary *dict = @{
      @"count": @0,
      @"name": @"frank",
      @"sex": @(YES),
      @"birthday": @"2016.12.12",
      @"phone": @"12345678",
      @"email": @"frank@125.com"
  };

  BOOL isValid1 = [NSJSONSerialization isValidJSONObject:dict];
  NSData *dictJson = [NSJSONSerialization dataWithJSONObject:dict
      options:NSJSONWritingPrettyPrinted
      error:nil];
  NSString *json = [NSJSONSerialization JSONObjectWithData:dictJson
      options:0
      error:nil];

  NSLog(@"%d", isValid1);
  NSLog(@"%@", dictJson);
  NSLog(@"%@", json);

}

@end
