//
//  SQLManager.m
//  Hello
//
//  Created by ray wang on 16/12/11.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "SQLManager.h"

#define  kNameFile (@"Person.sqlite")

@implementation SQLManager

static SQLManager *instance = nil;

+ (instancetype)shareManager {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    if (!instance) {
      instance = [[self alloc] init];
      [instance createDataBaseTableIfNeeded];
    }
  });
  return instance;
}

- (NSString *)applicationDocDirFile {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES);
  NSString *docDir = paths[0];
  NSString *result = [docDir stringByAppendingPathComponent:kNameFile];
  return result;
}

- (void)createDataBaseTableIfNeeded {
  NSString *writeTablePath = [self applicationDocDirFile];
  NSLog(@"the path is %@", writeTablePath);
  if (sqlite3_open([writeTablePath UTF8String], &db) != SQLITE_OK) {
    // open unsuccess
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
  } else {
    // open success
    char *error;
    NSString *createSQL =
        [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS WRPerson"
            "(userId INTEGER PRIMARY KEY,  name TEXT NOT NULL, sex TEXT,"
            "birthday "
            "TEXT, phone TEXT, email TEXT,UNIQUE (userId),UNIQUE(name,sex,"
            "birthday,phone,email));"];
    if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &error)
        != SQLITE_OK) {
      //NSLog(@"The write table execution is error: %s",error);
      sqlite3_close(db);
      NSAssert1(NO, @"create table failed! reason: %s", error);
    }
    sqlite3_close(db);
  }
}

- (WRPersonModel *)searchWithName:(NSString *)aName {
  // No 1 open the db
  NSString *writeTablePath = [self applicationDocDirFile];
  NSLog(@"search: the path is %@", writeTablePath);
  if (sqlite3_open([writeTablePath UTF8String], &db) != SQLITE_OK) {
    // open unsuccessful
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
  } else {
    // No 2 open db successful, then prepare and bind the statement
    NSString *qsql = @"SELECT userId,name,sex,birthday,phone,email FROM "
        "WRPerson "
        "where name = ?";
    sqlite3_stmt *statement;// statement obj

    if (SQLITE_OK
        == sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)) {
      // prepare OK,then bind
      sqlite3_bind_text(statement, 1, "*", -1, NULL);

      if (SQLITE_ROW
          == sqlite3_step(statement)) {// that means found the first data we want to search
        // extract the fields
        unsigned int userId = (unsigned int) sqlite3_column_int(statement, 0);
        char *name = (char *) sqlite3_column_text(statement, 1);
        char *sex = (char *) sqlite3_column_text(statement, 2);
        char *birthday = (char *) sqlite3_column_text(statement, 3);
        char *phone = (char *) sqlite3_column_text(statement, 4);
        char *email = (char *) sqlite3_column_text(statement, 5);

        //NSString *userIdStr = [NSString stringWithUTF8String:count];
        NSString *nameStr = [NSString stringWithUTF8String:name];
        NSString *sexStr = [NSString stringWithUTF8String:sex];
        NSString *bdStr = [NSString stringWithUTF8String:birthday];
        NSString *phoneStr = [NSString stringWithUTF8String:phone];
        NSString *emailStr = [NSString stringWithUTF8String:email];

        // convert the text fields to model
        WRPersonModel *model = [[WRPersonModel alloc]
            initWithUserId:userId
            Name:nameStr
            Sex:sexStr
            Birthday:bdStr
            Phone:phoneStr
            Email:emailStr];

        sqlite3_finalize(statement);
        sqlite3_close(db);
        return model;
      }
    } else {
      // prepare unsuccessful

      sqlite3_close(db);
      NSAssert(NO, @"prepare failed!");
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
  }
  return nil;
}
/* @param model: the inserted student model
 * @return: 0 means insert successful, else error, the error type will be
 * defined later
 * */
- (int)insertOrReplace:(WRPersonModel *)model {
  // 1 open the db
  // 2 prepare
  // 3 bind the function
  // 4 execute the function
  // 5 close the resources

  NSString *writablePath = [self applicationDocDirFile];
  NSLog(@"insertOrReplace: the path is %@", writablePath);
  if (SQLITE_OK != sqlite3_open([writablePath UTF8String], &db)) {
    // open unsuccessful
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
    return 1;
  } else {
    NSString *qsql = [NSString stringWithFormat:
        @" REPLACE INTO WRPerson"
            "(userId,name,sex,birthday,phone,email) VALUES (?,?,?,?,?,?);"];
    sqlite3_stmt *statement = NULL;
    if (SQLITE_OK != sqlite3_prepare_v2(db,
                                        [qsql UTF8String],
                                        -1,
                                        &statement,
                                        NULL)) {
      sqlite3_finalize(statement);
      sqlite3_close(db);
      NSAssert(NO, @"prepare failed!");
      return 2;
    }
    // prepare OK,then bind

    BOOL bindSucc = SQLITE_OK
        == sqlite3_bind_int(statement, 1, model.userId)
        && SQLITE_OK
            == sqlite3_bind_text(statement, 2, [model.name UTF8String], -1,
                                 NULL) && SQLITE_OK
        == sqlite3_bind_text(statement, 3, [model.sex UTF8String], -1,
                             NULL) && SQLITE_OK
        == sqlite3_bind_text(statement, 4, [model.birthday UTF8String], -1,
                             NULL) && SQLITE_OK
        == sqlite3_bind_text(statement, 5, [model.phone UTF8String], -1,
                             NULL) && SQLITE_OK
        == sqlite3_bind_text(statement, 6, [model.email UTF8String], -1,
                             NULL);
    if (!bindSucc) {
      // bind unsuccessful
      sqlite3_finalize(statement);
      sqlite3_close(db);
      NSAssert(NO, @"bind failed!");
      return 3;
    }

    if (SQLITE_DONE != sqlite3_step(statement)) {
      sqlite3_finalize(statement);
      sqlite3_close(db);
      NSAssert(NO, @"insert failed!");
      return 4;
    }
    // insert successful
    sqlite3_finalize(statement);
    sqlite3_close(db);
  }
  return 0;
}

- (WRPersonModel *)searchLatest {
  // No 1 open the db
  NSString *writeTablePath = [self applicationDocDirFile];
  NSLog(@"search: the path is %@", writeTablePath);
  if (sqlite3_open([writeTablePath UTF8String], &db) != SQLITE_OK) {
    // open unsuccessful
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
  } else {
    // No 2 open db successful, then prepare and bind the statement
    NSString *qsql = @"SELECT userId,name,sex,birthday,phone,email FROM "
        "WRPerson "
        "ORDER BY userId LIMIT 0,1";
    sqlite3_stmt *statement;// statement obj

    if (SQLITE_OK == sqlite3_prepare_v2(db,
                                        [qsql UTF8String],
                                        -1,
                                        &statement,
                                        NULL)) {
      // prepare OK,then step

      if (SQLITE_ROW
          == sqlite3_step(statement)) {// that means found the first data we want to search
        // extract the fields

        unsigned int userId = (unsigned int) sqlite3_column_int(statement, 0);
        char *name = (char *) sqlite3_column_text(statement, 1);
        char *sex = (char *) sqlite3_column_text(statement, 2);
        char *birthday = (char *) sqlite3_column_text(statement, 3);
        char *phone = (char *) sqlite3_column_text(statement, 4);
        char *email = (char *) sqlite3_column_text(statement, 5);

        //NSString *userIdStr = [NSString stringWithUTF8String:userId];
        NSString *nameStr = [NSString stringWithUTF8String:name];
        NSString *sexStr = [NSString stringWithUTF8String:sex];
        NSString *bdStr = [NSString stringWithUTF8String:birthday];
        NSString *phoneStr = [NSString stringWithUTF8String:phone];
        NSString *emailStr = [NSString stringWithUTF8String:email];

        // convert the text fields to model
        WRPersonModel *model = [[WRPersonModel alloc]
            initWithUserId:userId
            Name:nameStr
            Sex:sexStr
            Birthday:bdStr
            Phone:phoneStr
            Email:emailStr];

        sqlite3_finalize(statement);
        sqlite3_close(db);
        return model;
      }
    } else {
      // prepare unsuccessful

      sqlite3_close(db);
      NSAssert(NO, @"prepare failed!");
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
  }
  return nil;
}

- (int)delete:(WRPersonModel *)model {
  // 1 open the db
  // 2 prepare
  // 3 bind the function
  // 4 execute the function
  // 5 close the resources

  NSString *writablePath = [self applicationDocDirFile];
  NSLog(@"delete: the path is %@", writablePath);
  if (SQLITE_OK != sqlite3_open([writablePath UTF8String], &db)) {
    // open unsuccessful
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
    return 1;
  }
  char *error = NULL;
  NSString *delete = [NSString stringWithFormat:
      @"DELETE INTO WRPerson"
          "(userId,name,sex,birthday,phone,email) VALUES(?);"];
  if (SQLITE_OK != sqlite3_exec(db, [delete UTF8String], NULL, NULL, &error)) {
    sqlite3_close(db);
    NSAssert(NO, @"delete failed! error: %s", error);
    return 2;
  }
  sqlite3_close(db);
  NSAssert(NO, @"delete failed! error: %s", error);
  return 0;
}

- (int)deleteLatest {
  // 1 open the db
  // 2 prepare
  // 3 bind the function
  // 4 execute the function
  // 5 close the resources

  NSString *writablePath = [self applicationDocDirFile];
  NSLog(@"delete: the path is %@", writablePath);
  if (SQLITE_OK != sqlite3_open([writablePath UTF8String], &db)) {
    // open unsuccessful
    // NSLog(@"Open db error");
    sqlite3_close(db);
    NSAssert(NO, @"Open db failed!");
    return 1;
  }
  char *error = NULL;
  NSString *delete = [NSString stringWithFormat:
      @"DELETE FROM WRPerson WHERE userId = 0 ;"];
  if (SQLITE_OK != sqlite3_exec(db, [delete UTF8String], NULL, NULL, &error)) {
    sqlite3_close(db);
    NSAssert(NO, @"delete failed! error: %s", error);
    return 2;
  }
  sqlite3_close(db);
  NSAssert(NO, @"delete failed! error: %s", error);
  return 0;
}
@end
