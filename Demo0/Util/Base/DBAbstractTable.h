/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import <Foundation/Foundation.h>
#import "FMDB/FMDatabase.h"
#import "CocoaLumberjack/CocoaLumberjack.h"

@interface DBAbstractTable : NSObject

@property (nonatomic, readonly) FMDatabase* db;

@property (nonatomic, readonly) NSString* name;

- (id)initWithTableName:(NSString*)name inDatabase:(FMDatabase*)db;

- (BOOL)createTable;

- (BOOL)exists;

- (BOOL)addItem:(id)item;

- (BOOL)addItemOrReplace:(id)item;

- (BOOL)addItemOrIgnore:(id)item;

- (NSArray*)selectItemsWithCol:(NSString*)col otherPart:(NSString *)otherPart withParam:(NSArray *)param;

- (NSArray*)selectItemsWithOtherPart:(NSString*)part withParam:(NSArray*)param;

- (BOOL)existsWithOtherPart:(NSString*)part withParam:(NSArray*)param;

- (BOOL)deleteItemsWithOtherPart:(NSString *)otherPart withParam:(NSArray *)param;

- (BOOL)deleteAllItems;

- (BOOL)dropSelf;

- (NSInteger)selectItemCount;

- (Class)queryClassWithResultDictionary:(NSDictionary*)resultDictionary;

- (BOOL)alterTableAddColumn:(NSString *)column withType:(NSString *)type;

- (BOOL)hasColumn:(NSString *)column;

- (BOOL)checkAndAddColumn:(NSString *)column withType:(NSString *)type;

- (BOOL)upgrade;

@end
