/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "CocoaLumberjack/CocoaLumberjack.h"
@protocol JSONIO <NSObject>

- (instancetype)initWithJSON:(id)json;

- (id)encodeToJSON;

@end
