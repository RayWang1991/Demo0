/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>

@interface NSObject (BMTAutoDetached)

// wrap initWithDelegate:
- (instancetype)initWithAutoDetachedDelegate:(id)delegate;

// wrap setDelegate:
- (void)setAutoDetachedDelegate:(id)delegate;

// wrap setDatasource:
- (void)setAutoDetachedDataSource:(id)dataSource;

// wrap addObserver:forKeyPath:options:context:
- (void)addAutoDetachedObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context;

@end
