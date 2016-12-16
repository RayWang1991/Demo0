/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgePageViewController.h 
 * Created by ray wang on 16/12/16.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMLayoutConstraint.h"
#import "BannersViewController.h"
#import "MicroClassViewController.h"
#import "Constants.h"
@interface KnowledgePageViewController : UIViewController
@property (strong, nonatomic) BannersViewController *bannersVC;
@property (strong, nonatomic) MicroClassViewController *mClassVC;
@end