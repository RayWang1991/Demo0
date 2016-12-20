/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSFileManager+BMTExtension.h"
#import "CocoaLumberjack/CocoaLumberjack.h"
@implementation NSFileManager (BMTExtension)

- (BOOL)bmt_safeMoveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
{
    NSError* __autoreleasing internalError = nil;
    if (error == nil) {
        error = &internalError;
    }
    BOOL success = YES;
    // 创建所需目录
    NSString* destDir = [dstPath stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destDir]) {
        success = [self createDirectoryAtPath:destDir withIntermediateDirectories:YES attributes:nil error:error];
        if (!success) {
            DDLogInfo(@"[File] NSFileManager createDirectoryAtPath failed, path: %@, error: %@", destDir, *error);
            return NO;
        }
    }
    // 删除原有文件，不然移动会失败
    if ([self fileExistsAtPath:dstPath]) {
        success = [self removeItemAtPath:dstPath error:error];
        if (!success) {
            DDLogInfo(@"[File] NSFileManager removeItemAtPath failed, path: %@, error: %@", dstPath, *error);
            return NO;
        }
    }
    // 移动
    success = [self moveItemAtPath:srcPath toPath:dstPath error:error];
    if (!success) {
        DDLogInfo(@"[File] NSFileManager moveItemAtPath failed, srcPath: %@, dstPath: %@, error: %@", srcPath, dstPath, *error);
    }
    return success;
}

@end
