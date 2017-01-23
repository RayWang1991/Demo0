/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "DBTableWithUniqueIntegerPrimaryKey.h"
#import "DBAbstractTable+ForSubclassEyesOnly.h"

@interface DBTableWithUniqueIntegerPrimaryKey (ForSubclassEyesOnly)

/**
 *  是否允许添加主键上已经有值的item，默认不允许
 *
 *  @return 是否允许添加主键上已经有值的item
 */
- (BOOL)allowAddItemWithKeyValue;

@end
