/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * BMTKnowlegeInfoCellRefreshDelegate.h 
 * Created by ray wang on 16/12/29.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMTKnowledgeInfoEntity.h"
@protocol BMTKnowledgeInfoCellRefreshDelegate<NSObject>
@required
-(void)setCellViewByEntity:(BMTKnowledgeInfoEntity *)entity atIndexPath:
    (NSIndexPath *)indexPath;
@end