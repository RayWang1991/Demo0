/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * FMDBTest.m 
 * Created by ray wang on 16/12/20.
 */

#import <sqlite3.h>
#import "FMDBTest.h"

@implementation FMDBTest {

}
+ (void)test1_basic {
//part 1: find the document dir

  NSString *docsdir = NSSearchPathForDirectoriesInDomains
      (NSDocumentationDirectory, NSUserDomainMask, YES)[0];

  NSString *dbpath = [docsdir stringByAppendingPathComponent:@"dbName.db"];

  FMDatabase *db = [FMDatabase databaseWithPath:dbpath];
  //the FMDatabase obj is a object representing a SQLite database

  // part 2 opend the database
  [db open];

  // execute sql sentence
  FMResultSet *resultSet = [db executeQuery:@"select * from people"];

  // iterate the result set
  while ([resultSet next]) {
    NSLog(@"%@,%@",
          [resultSet stringForColumn:@"firstname"],
          [resultSet stringForColumn:@"lastname"]);
  }
  [db close];
}

+ (void)test2_1_databaseWithPath {

}

+ (void)test2_2_open {

}

// test2.3 executeQuery
- (FMResultSet *)excuteQuery:(NSString *)sql
        withArgumentsInArray:(NSArray *)arrayArgs
                orDictionary:(NSDictionary *)dictionaryArgs
                    orVAList:(va_list)args {
  //
  if (![self databaseExists]) {
    return 0x00;
    // using zero as nil?
  }

  // check if database is used in other thread
  if (_isExecutingStatement) {
    [self warnInUse];
    return 0x00;
  }
  _isExecutingStatement = YES;

  int rc=0x00;

  sqlite3_stmt * pstmt =0x00;
  // prepare for sqlite
  FMStatement * statement =0x00;
  // wrap for statement,do not use directly in practice
  FMResultSet *resultSet=0x00;
  // result set

  // check if sql nil and if is executing
  if(_traceExecution && sql) {
    NSLog(@"%@ executeQuery:%@", self, sql);
  }

  // get prepared
  // the prepared costs a lot, it should be cached to reuse
  if(_shouldCacheStatemts){
    statement=[self cachedStatemtForQuery:sql];
    // statement is a wrap, too
    pstmt=statemet? [statement statement] : 0x00;

    [statement reset];
    // Y reset?
  }

  if(!pstmt){
    // no cached pstmt, here is the same with sqlite3 prepare_STMT
    rc = sqlite3_prepare_v2(_db,[sql UTF8String],-1,&pstmt,0);

    // if error, deal with it, and
    // finallize
    // close

    if (SQLITE_OK != rc) {
      if (_logsErrors) {
        NSLog(@"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
        NSLog(@"DB Query: %@", sql);
        NSLog(@"DB Path: %@", _databasePath);
      }

      if (_crashOnErrors) {
        NSAssert(false, @"DB Error: %d \"%@\"", [self lastErrorCode], [self lastErrorMessage]);
        // abort() terminate the execution, system exception
        abort();
      }

      sqlite3_finalize(pStmt);
      _isExecutingStatement = NO;
      // the execution is done
      return nil;
    }

    // here prepare OK
    id obj;
    int idx=0;
    // get the arg number in pstmt;
    int queryCount= sqlite3_bind_parameter_count(pStmt);
    // how to realize?
    @"select * from namedparamcounttest where a = :a"
    // ":" connect an arg
}


@end