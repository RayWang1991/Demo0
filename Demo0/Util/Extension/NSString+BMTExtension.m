/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSString+BMTExtension.h"

#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

static const int kMaxLengthForLogString = 1024;

@implementation NSString (BMTExtension)

+ (NSString*)stringForBMTLog:(id)anyTypeObject
{
    return [[anyTypeObject description] stringForBMTLog];
}

- (NSString*)stringForBMTLog
{
    unsigned long length = (unsigned long)[self length];
    if (length > kMaxLengthForLogString) {
        return [NSString stringWithFormat:@"length is %lu, first %d bytes is %@", length, kMaxLengthForLogString, [self substringToIndex:kMaxLengthForLogString]];
    } else {
        return self;
    }
}

- (NSString*)stringByDeletingHomeDirectoryPath
{
    NSMutableString* homeDirectory = [NSMutableString stringWithString:NSHomeDirectory()];
    NSString* const kSlash = @"/";
    if (![homeDirectory hasSuffix:kSlash]) {
        [homeDirectory appendString:kSlash];
    }
    if ([self hasPrefix:homeDirectory]) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, homeDirectory.length) withString:@""];
    }
    assert(NO);
    return self;
}

- (NSString*)lowerHexStringForMD5
{
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];

    // 这里必须是unsigned char,不能为signed char.
    // 如果data[i]是负数,则[NSString stringWithFormat:@"%02X", data[i]]结果为8个字符(注意负号的展开)
    const size_t resultHexLength = CC_MD5_DIGEST_LENGTH;
    unsigned char resultHex[resultHexLength];
    CC_MD5(cData, (CC_LONG)[self length], resultHex);
    NSMutableString* result = [NSMutableString stringWithCapacity:resultHexLength*2];
    for(int i = 0; i < resultHexLength; i++) {
        [result appendFormat:@"%02x", resultHex[i]];
    }
    return result;

}

- (NSString*)base64StringForSha1WithKey:(NSString*)key
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, (size_t)[key length], cData, (size_t)[self length], cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}

- (NSString*)base64URLSafeStringForSha1WithKey:(NSString*)key
{
    NSMutableString* sha1 = [[self base64StringForSha1WithKey:key] mutableCopy];
    // see http://www.cnblogs.com/chengxin1982/p/3928763.html
    [sha1 replaceOccurrencesOfString:@"+" withString:@"-" options:0 range:NSMakeRange(0, [sha1 length])];
    [sha1 replaceOccurrencesOfString:@"/" withString:@"_" options:0 range:NSMakeRange(0, [sha1 length])];
    [sha1 replaceOccurrencesOfString:@"=" withString:@"" options:0 range:NSMakeRange(0, [sha1 length])];
    return sha1;
}

- (NSString *)urlEncode {
  NSMutableString *output = [NSMutableString string];
  const unsigned char *source = (const unsigned char *)[self UTF8String];
  int sourceLen = strlen((const char *)source);
  for (int i = 0; i < sourceLen; ++i) {
    const unsigned char thisChar = source[i];
    if (thisChar == ' '){
      [output appendString:@"+"];
    } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
               (thisChar >= 'a' && thisChar <= 'z') ||
               (thisChar >= 'A' && thisChar <= 'Z') ||
               (thisChar >= '0' && thisChar <= '9')) {
      [output appendFormat:@"%c", thisChar];
    } else {
      [output appendFormat:@"%%%02X", thisChar];
    }
  }
  return output;
}

@end
