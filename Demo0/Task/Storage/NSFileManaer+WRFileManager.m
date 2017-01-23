//
//  WRFileManager.m
//  Demo0
//
//  Created by ray wang on 16/12/15.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "NSFileManaer+WRFileManager.h"

@implementation NSFileManager (WRFileManager)


- (WRPersonModel *)openFileById:(unsigned int)userId {

  NSError *error = nil;
  NSURL *folderURL = [self URLForDirectory:NSDocumentDirectory
                                  inDomain:NSUserDomainMask
                         appropriateForURL:nil
                                    create:YES
                                     error:&error];
  NSLog(@"the doc path is %@", folderURL);
  if (error) {
    NSLog(@"found path fails");
    return nil;
  }

  NSURL *fileURL =
      [NSURL URLWithString:[[folderURL path] stringByAppendingFormat:@"%u.JSON",
                                                                     userId]];
  NSFileHandle
      *handle = [NSFileHandle fileHandleForReadingAtPath:[fileURL path]];
  if (!handle) {
    NSLog(@"can not open %u.JSON!", userId);
  }
  NSData *availableData = [handle availableData];

  NSDictionary
      *dictionary = [NSJSONSerialization JSONObjectWithData:availableData
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
  WRPersonModel *model = [[WRPersonModel alloc] init];
  [model setValuesForKeysWithDictionary:dictionary];
  return model;
}

- (BOOL)writeFileById:(WRPersonModel *)model {
  NSDictionary *dict =
      [model dictionaryWithValuesForKeys:@[@"userId", @"name", @"phone",
          @"email", @"birthday"]];

  NSError *error = nil;
    NSArray *folderURLs= [[NSFileManager defaultManager]
                          URLsForDirectory:NSDocumentDirectory
                          inDomains:NSUserDomainMask];
  NSURL *folderURL = folderURLs.lastObject;
  NSLog(@"the doc path is %@", folderURL);
  if (error) {
    NSLog(@"found path fails with error: %@",error);
    return NO;
  }

  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];

  NSURL *filePath = [NSURL URLWithString:[[folderURL path]
      stringByAppendingFormat:@"/Person%u.JSON",model.userId]];

  return [self createFileAtPath:[filePath path]
                       contents:data
                     attributes:nil];

}
@end
