/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "DeepCopyable.h"
#import "CocoaLumberjack/CocoaLumberjack.h"
@interface MergeableObject : DeepCopyable

- (void)mergeFrom:(MergeableObject*)otherEntity;

@end
