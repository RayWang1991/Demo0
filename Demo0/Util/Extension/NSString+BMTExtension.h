/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSString (BMTExtension)

+ (NSString*)stringForBMTLog:(id)anyTypeObject;

- (NSString*)stringForBMTLog;

- (NSString*)stringByDeletingHomeDirectoryPath;

- (NSString*)lowerHexStringForMD5;

- (NSString*)base64StringForSha1WithKey:(NSString*)key;

- (NSString*)base64URLSafeStringForSha1WithKey:(NSString*)key;

- (NSString *)urlEncode;

@end
