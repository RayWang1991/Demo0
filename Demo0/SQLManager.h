//
//  SQLManager.h
//  Hello
//
//  Created by ray wang on 16/12/11.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqLite3.h"
#import "WRPersonModel.h"

@interface SQLManager : NSObject {
  sqlite3 *db;
}
+ (instancetype)shareManager;

- (WRPersonModel *)searchLatest;
- (WRPersonModel *)searchWithName:(NSString *)aName;
- (int)insertOrReplace:(WRPersonModel *)model;
- (int)delete:(WRPersonModel *)model;
- (int)deleteLatest;
@end
