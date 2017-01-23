/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSFileManager (BMTExtension)

- (BOOL)bmt_safeMoveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

@end
