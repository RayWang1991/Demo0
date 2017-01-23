/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "NSObject+BMTAutoDetached.h"
#import "NSObject+BMTExtension.h"
#import "Constants.h"
@interface BMTAutoDetachedHelper : NSObject
@end

@implementation BMTAutoDetachedHelper

- (instancetype)initWithDelegate:(id)delegate { return nil; };
- (void)setDelegate:(id)delegate {};
- (void)setDataSource:(id)dataSource {};

@end

@implementation NSObject (BMTAutoDetached)

// wrap initWithDelegate:
- (instancetype)initWithAutoDetachedDelegate:(id)delegate {
  assert([self respondsToSelector:@selector(initWithDelegate:)]);
  assert([self respondsToSelector:@selector(setDelegate:)]);
  self = [(id)self initWithDelegate:delegate];
  @weakify(self);
  [delegate whenDealloc:^{
    @strongify(self);
    [(id)self setDelegate:nil];
  }];
  return self;
}

// wrap setDelegate:
- (void)setAutoDetachedDelegate:(id)delegate {
  assert([self respondsToSelector:@selector(setDelegate:)]);
  [(id)self setDelegate:delegate];
  @weakify(self);
  [delegate whenDealloc:^{
    @strongify(self);
    [(id)self setDelegate:nil];
  }];
}

// wrap setDataSource:
- (void)setAutoDetachedDataSource:(id)dataSource {
  assert([self respondsToSelector:@selector(setDataSource:)]);
  [(id)self setDataSource:dataSource];
  @weakify(self);
  [dataSource whenDealloc:^{
    @strongify(self);
    [(id)self setDataSource:nil];
  }];
}

// wrap addObserver:forKeyPath:options:context:
- (void)addAutoDetachedObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context {
  [self addObserver:observer
         forKeyPath:keyPath
            options:options
            context:context];
  @weakify(self);
  @weakify(observer);
  [observer whenDealloc:^{
    @strongify(self);
    @strongify(observer);
    [self removeObserver:observer forKeyPath:keyPath];
  }];
}

@end
