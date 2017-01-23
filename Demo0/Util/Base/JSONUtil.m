/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "JSONUtil.h"
#import "JSONIO.h"
#import "JSONKit_NoWarning/JSONKit.h"
#import "NSFoundation+NSNullEraser.h"
#import "NSString+BMTExtension.h"
#import "CocoaLumberjack/CocoaLumberjack.h"

@implementation JSONUtil

+ (id)nonNSNullJsonFromData:(NSData*)content error:(NSError**)error
{
    NSError* internalError = nil;
    id result = [self mutableJsonFromData:content error:&internalError];
    if (internalError == nil) {
        if ([result respondsToSelector:@selector(eraseNSNullRecursive)]) {
            [result eraseNSNullRecursive];
        } else {
            assert(NO);
        }
    }
    if (error != nil) {
        *error = internalError;
    }
    return result;
}

+ (id)nonNSNullJsonFromData:(NSData*)content
{
    return [self nonNSNullJsonFromData:content error:nil];
}

+ (id)nonNSNullJsonFromString:(NSString*)content error:(NSError**)error
{
    return [self nonNSNullJsonFromData:[content dataUsingEncoding:NSUTF8StringEncoding] error:error];
}

+ (id)nonNSNullJsonFromString:(NSString*)content
{
    return [self nonNSNullJsonFromString:content error:nil];
}

+ (id)mutableJsonFromData:(NSData*)content error:(NSError**)error
{
    if (content == nil) {
        return nil;
    }
    if (content.length == 0) {
        assert(false);
        return nil;
    }
    NSError* internalError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&internalError];
    if (internalError != nil) {
        DDLogError(@"JSONUtil.jsonFromString NSJSONSerialization failed, error: %@, content: %@", internalError, [NSString stringForBMTLog:content]);
        assert(false);
        internalError = nil;
        json = [content mutableObjectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&internalError];
        if (internalError != nil) {
            DDLogError(@"JSONUtil.jsonFromString JSONKit failed, error: %@, content: %@", internalError, [NSString stringForBMTLog:content]);
            assert(false);
        }
    }
    if (error != nil) {
        *error = internalError;
    }
    return json;
}

+ (id)jsonFromData:(NSData*)content error:(NSError**)error
{
    return [self mutableJsonFromData:content error:error];
}

+ (id)jsonFromData:(NSData *)content
{
    return [self jsonFromData:content error:nil];
}

+ (id)jsonFromString:(NSString*)content
{
    return [self jsonFromString:content error:nil];
}

+ (id)jsonFromString:(NSString*)content error:(NSError**)error
{
    return [self jsonFromData:[content dataUsingEncoding:NSUTF8StringEncoding] error:error];
}


+ (id)jsonFromFileInBundle:(NSString *)fileName ofType:(NSString *)type
{
    if (fileName == nil) {
        return nil;
    }

    NSString* filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError* error = nil;
    NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        DDLogError(@"JSONUtil.jsonFromFile:ofType: failed, error: %@", error);
        assert(false);
        return nil;
    }

    return [self jsonFromString:content];
}

+ (NSString*)stringFromJSON:(id)json
{
    if (json == nil) {
        return nil;
    }
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
    if (error != nil) {
        DDLogError(@"JSONUtil.stringFromJSON failed, error: %@, json: %@", error, [NSString stringForBMTLog:json]);
        assert(false);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSString*)stringFromObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    if (![object respondsToSelector:@selector(encodeToJSON)]) {
        DDLogError(@"JSONUtil.stringFromObject failed, object must implement encodeToJSON : %@", [NSString stringForBMTLog:object]);
        assert(false);
        return nil;
    }
    return [JSONUtil stringFromJSON:[object encodeToJSON]];
}

@end
