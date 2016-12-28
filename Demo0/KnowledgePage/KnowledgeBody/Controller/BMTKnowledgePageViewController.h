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
#import "BMTBannersViewController.h"
#import "MicroClassViewController.h"
#import "Constants.h"
#import "BMTKnowledgeHomePageCategoryTableCellView.h"
#import "BMTKnowledgeInfoDataSourceManager.h"
#import "SessionRequestManager.h"
#import "UIView+AddMoreButtonView.h"
#import "UILabel+RefreshPanelView.h"
#import "BMTKnowledgeInfoCategoryTabBarsView.h"

@class BMTKnowledgeTableView;
@interface BMTKnowledgePageViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate>
// header
@property(strong, nonatomic) BMTBannersViewController *bannersVC;
@property(strong, nonatomic) MicroClassViewController *microClassVC;
@property (strong, nonatomic) BMTKnowledgeInfoCategoryTabBarsView *categoryBarsView;
// refresh panel
@property(assign, nonatomic) BOOL shouldRefresh;
@property(strong, nonatomic) UILabel *refreshPanelLabel;
// table view's body
@property(strong, nonatomic) BMTKnowledgeTableView *tableView;
//@property (strong, nonatomic) NSMutableArray <BMTKnowledgeInfoDataSourceManager*>*dataArray;

@property(strong, nonatomic) BMTKnowledgeInfoDataSourceManager<BMTGetKnowledgeInfoDelegate>
    *dataSourceManager;
// footer
@property(strong, nonatomic) UIView *loadMoreButtonView;

// data source for table
//@property (strong, nonatomic) NSMutableArray * dataArray;
@end