/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithUniqueIntegerPrimaryKey.h"
#import "DBTableWithUniqueIntegerPrimaryKey+ForSubclassEyesOnly.h"
#import "CocoaLumberjack/CocoaLumberjack.h"
@implementation DBTableWithUniqueIntegerPrimaryKey

- (BOOL)addItem:(id)item {
  if (!item) {
    return NO;
  }
  id originKeyValue = [item valueForKey:self.keyName];
  if (![self allowAddItemWithKeyValue]) {
      if (originKeyValue != nil) {
          DDLogError(@"you should add a %@ without %@", NSStringFromClass([item class]), self.keyName);
          assert(NO);
          return NO;
      }
  }
  BOOL success = [super addItem:item];
  if (success && originKeyValue == nil) {
      [self setKeyFromInsertRowIdTo:item];
  }
  return success;
}

- (BOOL)addItemOrReplace:(id)item {
  if (!item) {
    return NO;
  }
  id originKeyValue = [item valueForKey:self.keyName];
  BOOL success = [super addItemOrReplace:item];
  if (success && originKeyValue == nil) {
      [self setKeyFromInsertRowIdTo:item];
  }
  return success;
}

- (BOOL)addOrUpdateItem:(id)item {
  if (!item) {
    return NO;
  }
  id keyValue = [item valueForKey:self.keyName];
  if (keyValue == nil || keyValue == [NSNull null]) {
      return [self addItem:item];
  } else {
      return [self updateItem:item];
  }
}

- (BOOL)addItemOrIgnore:(id)item {
  if (!item) {
    return NO;
  }
  id originKeyValue = [item valueForKey:self.keyName];
  BOOL success = [super addItemOrIgnore:item];
  if (success && originKeyValue == nil) {
      [self setKeyFromInsertRowIdTo:item];
  }
  return success;
}

- (void)setKeyFromInsertRowIdTo:(id)item {
    // see http://www.sqlite.org/faq.html#q1
    NSNumber* key = [NSNumber numberWithLongLong:[self.db lastInsertRowId]];
    [item setValue:key forKey:self.keyName];
}

@end
