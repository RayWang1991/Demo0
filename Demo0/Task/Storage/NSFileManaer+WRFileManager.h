//
//  WRFileManager.h
//  Demo0
//
//  Created by ray wang on 16/12/15.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRPersonModel.h"

@interface NSFileManager (WRFileManager)

-(WRPersonModel *)openFileById:(unsigned int) userId;
-(BOOL)writeFileById:(WRPersonModel *) model;

@end
