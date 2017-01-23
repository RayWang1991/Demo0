/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSObject+BMTExtension.h"
#import "CocoaLumberjack/CocoaLumberjack.h"
#import "Aspects.h"

@implementation NSObject (BMTExtension)

- (void)whenDealloc:(void(^)())action
{
    NSError* error = nil;
    // 由于编译器禁止在ARC下引用@selector(dealloc)，因此此处用String做workaround
    [self aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>info) {
        action();
    } error:&error];
    assert(error == nil);
}

- (void)printCallStackSymbols {
  NSArray *syms = [NSThread  callStackSymbols];
  if ([syms count] > 1) {
    DDLogDebug(@"<%@ %p> %@ - caller: %@ ", [self class], self, NSStringFromSelector(_cmd), syms);
  } else {
    DDLogDebug(@"<%@ %p> %@", [self class], self, NSStringFromSelector(_cmd));
  }
}

@end
