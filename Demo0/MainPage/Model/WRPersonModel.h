/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * personModel.h 
 * Created by ray wang on 16/12/12.
 */

#import <Foundation/Foundation.h>

@interface WRPersonModel : NSObject

@property(assign, nonatomic) unsigned int userId;
@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) NSString *sex;
@property(strong, nonatomic) NSString *birthday;
@property(strong, nonatomic) NSString *phone;
@property(strong, nonatomic) NSString *email;

//+(void)createPersonForTest;
- (instancetype)initWithUserId:(unsigned int)anId
                          Name:(NSString *)aName
                           Sex:(NSString *)isMale
                      Birthday:(NSString *)aBirthday
                         Phone:(NSString *)aPhoneNum
                         Email:(NSString *)anEmail;
@end
