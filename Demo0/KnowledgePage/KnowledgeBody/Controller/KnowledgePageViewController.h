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
#import "UIView+AddMoreButtonView.h"
#import "UILabel+RefreshPanelView.h"

@class KnowledgeTableView;
@interface KnowledgePageViewController :
    UIViewController<UITableViewDataSource,UITableViewDelegate>
// header
@property (strong, nonatomic) BannersViewController *bannersVC;
@property (strong, nonatomic) MicroClassViewController *microClassVC;
// refresh panel
@property (assign, nonatomic) BOOL shouldRefresh;
@property (strong, nonatomic) UILabel *refreshPanelLabel;
// table view's body
@property (strong, nonatomic) KnowledgeTableView * tableView;
//@property (strong, nonatomic) NSMutableArray <KnowledgeInfoDataSourceManager*>*dataArray;

@property (strong, nonatomic) KnowledgeInfoDataSourceManager *dataSourceManager;
// footer
@property (strong, nonatomic) UIView *loadMoreButtonView;

// data source for table
//@property (strong, nonatomic) NSMutableArray * dataArray;
@end