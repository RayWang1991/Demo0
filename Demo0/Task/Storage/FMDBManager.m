/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * FMDBManager.m 
 * Created by ray wang on 16/12/19.
 */

#import "FMDBManager.h"

@implementation FMDBManager {

}
+(instancetype)sharedManager{
  static FMDBManager *manager=nil;
  static dispatch_once_t once;
  dispatch_once(&once,^{
    if(!manager){
      manager=[[self alloc]init];
    }
  });
  return manager;
}

-(void)prepare{
  //NSError * error=[]
}

-(NSError *)prepareInternal{
  NSString *path=NSSearchPathForDirectoriesInDomains
  (NSDocumentationDirectory,NSUserDomainMask,YES)[0];
  path=[path stringByAppendingPathComponent:DBNAME];

  self.db=[FMDatabase databaseWithPath:path];
  if(self.db==nil){
    NSLog(@"prepare failed path: %@",path);
    return [NSError errorWithDomain:WRStorageDomain
                               code:1
                        userInfo:@{@"reason":@"storage error"}];
  } else{
      return nil;
  }
}
@end
