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
#import "KnowledgeHomePageCategoryTableViewCell.h"
#import "KnowledgeInfoDataSourceManager.h"
#import "SessionRequestManager.h"

@class KnowledgeTableView;
@interface KnowledgePageViewController :
    UIViewController<UITableViewDataSource,UITableViewDelegate>
// header
@property (strong, nonatomic) BannersViewController *bannersVC;
@property (strong, nonatomic) MicroClassViewController *microClassVC;

// table view's body
@property (strong, nonatomic) KnowledgeTableView * tableView;
//@property (strong, nonatomic) NSMutableArray <KnowledgeInfoDataSourceManager*>*dataArray;

@property (strong, nonatomic) KnowledgeInfoDataSourceManager *dataSourceManager;
// footer
@property (strong, nonatomic) UIButton *loadMoreButton;

// data source for table
//@property (strong, nonatomic) NSMutableArray * dataArray;
@end