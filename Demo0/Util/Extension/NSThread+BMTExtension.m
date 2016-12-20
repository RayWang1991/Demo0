/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */


#import "NSThread+BMTExtension.h"

@implementation NSThread (BMTExtension)

- (void)performBlock:(void(^)())block
{
    [self performSelector:@selector(onlyForRunBlock:) onThread:self withObject:block waitUntilDone:NO];
}

- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay
{
    [self performBlock:^{
        [self performSelector:@selector(onlyForRunBlock:) withObject:block afterDelay:delay];
    }];
}

- (void)onlyForRunBlock:(void(^)())block
{
    block();
}

@end
