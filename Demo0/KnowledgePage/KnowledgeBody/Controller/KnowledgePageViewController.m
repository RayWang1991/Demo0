/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgePageViewController.m 
 * Created by ray wang on 16/12/16.
 */

#import "KnowledgePageViewController.h"
#import "KnowledgeTableView.h"
#define DEFAULT_KNOWLEDGE_NUM (5u)

@implementation KnowledgePageViewController {

}
- (void)loadView {
  self.view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setViewBasicStyle];

  self.bannersVC = [[BannersViewController alloc] init];

  self.tableView = [[KnowledgeTableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
  [self.view addSubview:self.tableView];

  _tableView.tableHeaderView = _bannersVC.view;
  _tableView.tableFooterView = nil;// TODO, button
  _tableView.delegate = self;
  _tableView.dataSource = self;//TODO, split later

  [_tableView registerClass:[KnowledgeHomePageCategoryTableViewCell class]
     forCellReuseIdentifier:[KnowledgeHomePageCategoryTableViewCell bmt_reuseId]];

  _dataSourceManager = [[KnowledgeInfoDataSourceManager alloc] init];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(dataArrived:)
                                               name:@"KnowledgeInfoDataArrived"
                                             object:nil];

  [self.dataSourceManager getMoreKnowledgeInfo:5
                                    categoryId:1];

 // [self testFirstGetInfoNumber:DEFAULT_KNOWLEDGE_NUMBERS catId:CAT_1];
  //[self testNetRequest];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)testNetRequest {
  SessionRequestManager *requestManager = [SessionRequestManager sharedManager];
  [requestManager getKnowledgeBriefsFromServerSuccess:^(NSArray *array) { ; }
                                              failure:^(NSError *error) { ; }
                                           categoryId:1
                                               offset:0
                                               number:5];
}
- (void)testGetInfoMoreNumber:(NSUInteger)number
                        catId:(NSUInteger)catId {
  NSInteger gotNumber = [self.dataSourceManager getMoreKnowledgeInfo:number
                                                               categoryId:catId];
}
- (void)testFirstGetInfoNumber:(NSUInteger)number
                         catId:(NSUInteger)catId {
  NSInteger gotNumber = [self.dataSourceManager getRefreshedKnowledgeInfo:number
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
#pragma mark - dataArrive
- (void)dataArrived:(NSNotification *)notification {
  NSInteger askedNum =
      [notification.userInfo[@"askedNum"] integerValue];
  NSInteger returnNum =
      [notification.userInfo[@"returnNum"] integerValue];
  //
  if (returnNum < 0) {
    NSLog(@"get info error");

  } else {
    if (returnNum < askedNum) {
      NSLog(@"get info shortage");
    } else {
      NSLog(@"get info success");
    }
    [self.tableView reloadData];
  }
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
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellStr =
      [KnowledgeHomePageCategoryTableViewCell bmt_reuseId];//used for reuse
  KnowledgeHomePageCategoryTableViewCell *cell = [self.tableView
      dequeueReusableCellWithIdentifier:cellStr
                           forIndexPath:indexPath];

  NSString *titleText = [NSString stringWithFormat:@"Row %d %@",
                                                   indexPath.row,
                                                   self.dataSourceManager
                                                       .knowledgeInfoEntityArray[0][indexPath
                                                       .row]
                                                       .title];
  NSString *detailText = [NSString stringWithFormat:@"%@",

                                                    self.dataSourceManager
                                                        .knowledgeInfoEntityArray[0][indexPath
                                                        .row]
                                                        .summary];
  //NSString * Text=[NSString stringWithFormat:@"Row %@",self
  // .dataArray[indexPath.row].title];
  cell.titleLabel.text = titleText;
  cell.contentLabel.text = detailText;

  return cell;
}

#pragma mark - UISettings
- (void)setViewBasicStyle {
  self.view.backgroundColor = [UIColor orangeColor];
}

/*
-(BannersViewController *)bannersVC {
  if(!_bannersVC){
    _bannersVC=[[BannersViewController alloc]init];
  }
  return _bannersVC;
}
*/

- (void)setSubViewsToSuperView {
  [self.view addSubview:self.bannersVC.view];
  //TODO add [self.view addSubview:self.mClassVC];
}

#pragma mark - private
- (KnowledgeInfoDataSourceManager *)dataSourceManager {
  return [KnowledgeInfoDataSourceManager sharedManager];
}
@end
