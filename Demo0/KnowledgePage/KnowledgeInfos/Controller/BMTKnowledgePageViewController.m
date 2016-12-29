/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgePageViewController.m 
 * Created by ray wang on 16/12/16.
 */

#import <SDWebImage/UIImageView+WebCache.h>
#import "BMTKnowledgePageViewController.h"
#import "BMTKnowledgeTableView.h"
#import "UILabel+RefreshPanelView.h"
#define DEFAULT_KNOWLEDGE_NUMBERS (81u)

@implementation BMTKnowledgePageViewController
- (void)loadView {
  self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _bannersVC = [[BMTBannersViewController alloc] init];
  _microClassVC = [[BMTMicroClassViewController alloc] init];
  _tableView = [[BMTKnowledgeTableView alloc] initWithFrame:self.view.bounds
                                                      style:UITableViewStylePlain];
  [self.view addSubview:self.tableView];
/*
  _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        -REFRESH_PANEL_HEIGHT,
                                                                        375,
                                                                        320)];
                                                                        */
  _tableView.tableHeaderView =
      [[BMTKnowledgeHeaderView alloc] initWithFrame:CGRectMake(0,
                                                               -REFRESH_PANEL_HEIGHT,
                                                               375,
                                                               320)];
  _tableView.tableHeaderView.backgroundColor = [UIColor colorWithWhite:0
                                                                 alpha:0.12];
  CGFloat catBarHeight = 30;
  CGFloat headerHeight = _tableView.tableHeaderView.bounds.size.height;
  _categoryBarsView =
      [[BMTKnowledgeInfoCategoryTabBarsView alloc] initWithFrame:CGRectMake(0,
                                                                            headerHeight
                                                                                - catBarHeight,
                                                                            375,
                                                                            catBarHeight)];
  _categoryBarsView.delegate=self;
  [_tableView.tableHeaderView addSubview:_bannersVC.view];

  [_tableView.tableHeaderView addSubview:_microClassVC.view];

  [_tableView.tableHeaderView addSubview:_categoryBarsView];

  // refresh panel and microClass are subviews too

  _loadMoreButtonView = [[UIView alloc] initWithAddMoreButton];
  _tableView.tableFooterView = _loadMoreButtonView;
  UIButton *addMoreButton = _loadMoreButtonView.subviews[0];
  [addMoreButton addTarget:self
                    action:@selector
                    (addMoreButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];

  _refreshPanelLabel = [[UILabel alloc] initWithHintText];

  [_tableView.tableHeaderView addSubview:_refreshPanelLabel];

  _tableView.delegate = self;
  _tableView.dataSource = self;//TODO, split later

  [_tableView registerClass:[BMTKnowledgeHomePageCategoryTableCellView class]
     forCellReuseIdentifier:[BMTKnowledgeHomePageCategoryTableCellView bmt_reuseId]];

  _dataSourceManager = [[BMTKnowledgeInfoDataSourceManager alloc] init];

  [self setViewBasicStyle];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(dataArrived:)
                                               name:@"KnowledgeInfoDataArrived"
                                             object:nil];

  [self.dataSourceManager getMoreKnowledgeInfo:5
                                    categoryId:1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)testNetRequest {
  SessionRequestManager *requestManager = [SessionRequestManager sharedManager];
  [requestManager getKnowledgeInfosFromServerSuccess:^(NSArray *array) { ; }
                                             failure:^(NSError *error) { ; }
                                          categoryId:1
                                              offset:0
                                              number:5];
}
- (void)testGetInfoMoreNumber:(NSUInteger)number
                        catId:(NSUInteger)catId {
  [self.dataSourceManager getMoreKnowledgeInfo:number
                                    categoryId:catId];
}
- (void)testFirstGetInfoNumber:(NSUInteger)number
                         catId:(NSUInteger)catId {
  [self.dataSourceManager getRefreshedKnowledgeInfo:number
                                         categoryId:catId];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - event
- (void)dataArrived:(NSNotification *)notification {
  NSInteger askedNum =
      [notification.userInfo[@"askedNum"] integerValue];
  NSInteger returnNum =
      [notification.userInfo[@"returnNum"] integerValue];
  // return Number -1 error, 0 do not get
  if (returnNum <= 0) {
    NSLog(@"get info error");
    dispatch_async(dispatch_get_main_queue(), ^{
      self.loadMoreButtonView.hidden = YES;
    });
  } else {
    if (returnNum < askedNum) {
      NSLog(@"get info shortage");
    } else {
      NSLog(@"get info success");
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.tableView reloadData];
      self.loadMoreButtonView.hidden = NO;
    });
  }

}

- (void)addMoreButtonClicked {
  [self.dataSourceManager getMoreKnowledgeInfo:DEFAULT_KNOWLEDGE_NUMBERS
                                    categoryId:1];
}

-(void) changeCategoryTo:(NSUInteger)catId{
  
}
#pragma mark - tableViewSettings

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataSourceManager.knowledgeInfoEntityArray[0].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellStr =
      [BMTKnowledgeHomePageCategoryTableCellView bmt_reuseId];//used for reuse
  BMTKnowledgeHomePageCategoryTableCellView *cell = [self.tableView
      dequeueReusableCellWithIdentifier:cellStr
                           forIndexPath:indexPath];

  // make sure that the data source has index lager than indexPath
  // so the cell here should not show data directly, the data refresh
  // should always done after data arrived!
  // the code here is only responsible to provide cell views !!!!

  if (self.dataSourceManager.knowledgeInfoEntityArray[0].count >= indexPath
      .row) {
    [cell setCellViewByEntity:self.dataSourceManager
            .knowledgeInfoEntityArray[0][(NSUInteger) indexPath.row]
                  atIndexPath:indexPath];
  }

  return cell;
}

#pragma mark - UISettings
- (void)setViewBasicStyle {
  self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setSubViewsToSuperView {
  //[self.view addSubview:self.bannersVC.view];
  //TODO add [self.view addSubview:self.mClassVC];
}

#pragma mark - refresh UI

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.tableView.contentOffset.y < -REFRESH_PANEL_HEIGHT - 30) {
    [self.refreshPanelLabel setCompleteText];
    self.shouldRefresh = YES;
  } else {
    [self.refreshPanelLabel setHintText];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
  if ((self.tableView.contentOffset.y >= -REFRESH_PANEL_HEIGHT - 5)
      && self.shouldRefresh) {
    self.shouldRefresh = NO;
    [self.dataSourceManager getRefreshedKnowledgeInfo:5
                                           categoryId:1];
  }
}

#pragma mark - private
- (BMTKnowledgeInfoDataSourceManager *)dataSourceManager {
  return [BMTKnowledgeInfoDataSourceManager sharedManager];
}

@end
