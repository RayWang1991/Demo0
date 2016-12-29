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
#define DEFAULT_KNOWLEDGE_NUM (5u)

@implementation BMTKnowledgePageViewController {

}
- (void)loadView {
  /*
  CGFloat height = UIScreen.mainScreen.bounds.size.height + REFRESH_PANEL_HEIGHT;
  CGFloat width = UIScreen.mainScreen.bounds.size.width + REFRESH_PANEL_HEIGHT;

  self.view = [[UIView alloc] initWithFrame:CGRectMake(0, -REFRESH_PANEL_HEIGHT,
                                                       width, height)];
                                                       */
  self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _bannersVC = [[BMTBannersViewController alloc] init];

  _microClassVC =[[BMTMicroClassViewController alloc]init];

  _tableView = [[BMTKnowledgeTableView alloc] initWithFrame:self.view.bounds
                                                   style:UITableViewStylePlain];
  [self.view addSubview:self.tableView];

  _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        -REFRESH_PANEL_HEIGHT,
                                                                        375,
                                                                        320)];
  CGFloat catBarHeight = 30;
  CGFloat headerHeight=_tableView.tableHeaderView.bounds.size.height;
  _categoryBarsView =
      [[BMTKnowledgeInfoCategoryTabBarsView alloc] initWithFrame:CGRectMake(0,
                                                                  headerHeight-catBarHeight,
                                                                  375,
                                                                  catBarHeight)];

  [_tableView.tableHeaderView addSubview:_categoryBarsView];

  [_tableView.tableHeaderView addSubview:_bannersVC.view];
  [_tableView.tableHeaderView addSubview:_microClassVC.view];
  // should be adding sub view cause
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

  // [self testFirstGetInfoNumber:DEFAULT_KNOWLEDGE_NUMBERS catId:CAT_1];
  //[self testNetRequest];

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
  NSNumber *clickedNum = self.dataSourceManager
      .knowledgeInfoEntityArray[0][indexPath.row]
      .click;
  NSNumber *likeNum = self.dataSourceManager
      .knowledgeInfoEntityArray[0][indexPath.row]
      .like;
  // turn the chinese URL into % format
  NSString *originalURLStr =
      self.dataSourceManager
          .knowledgeInfoEntityArray[0][indexPath.row].thumbSrc;
  NSLog(@"the original URL string is %@", originalURLStr);
  NSString *formatedURLStr = [originalURLStr
      stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
          characterSetWithCharactersInString:@"^ "]
          .invertedSet];
  NSLog(@"the formated URL string is %@", formatedURLStr);
  NSURL *knowledgeImageURL = [NSURL URLWithString:formatedURLStr];
  //NSString * Text=[NSString stringWithFormat:@"Row %@",self
  // .dataArray[indexPath.row].title];
  cell.titleLabel.text = titleText;
  cell.contentLabel.text = detailText;
  cell.bottomView.clickedNumLabel.text = [NSString stringWithFormat:@"%@",
                                                                    clickedNum];
  cell.bottomView.likeNumLabel.text = [NSString stringWithFormat:@"%@",
                                                                 likeNum];
  [cell.knowledgeImageView sd_setImageWithURL:knowledgeImageURL
                             placeholderImage:[UIImage imageNamed:@"1.jpg"]
                                      options:SDWebImageRetryFailed
                                     progress:nil
                                    completed:
                                        ^(UIImage *image, NSError *error, SDImageCacheType
                                        cacheType, NSURL *completeImageURL) {
                                          //save the image here
                                          //banners[i].bannerImage=imageView.image;

                                          NSLog(@"refesh knowledgeInfo images, done!");
                                          switch (cacheType) {
                                            case SDImageCacheTypeNone:NSLog(@"knowledgeInfo Image 直接下载");
                                              break;
                                            case SDImageCacheTypeDisk:NSLog(@"knowledgeInfo Image 磁盘缓存");
                                              break;
                                            case SDImageCacheTypeMemory:NSLog(@"knowledgeInfo Image 内存缓存");
                                              break;
                                            default:break;
                                          }
                                        }
  ];

  return cell;
}

#pragma mark - UISettings
- (void)setViewBasicStyle {
  self.view.backgroundColor = [UIColor orangeColor];
}

/*
-(BMTBannersViewController *)bannersVC {
  if(!_bannersVC){
    _bannersVC=[[BMTBannersViewController alloc]init];
  }
  return _bannersVC;
}
*/

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
