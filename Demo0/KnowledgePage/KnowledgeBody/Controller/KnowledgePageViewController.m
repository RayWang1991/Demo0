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

@implementation KnowledgePageViewController {

}
-(void)laodView{
  self.view= [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setViewBasicStyle];

  self.bannersVC = [[BannersViewController alloc] init];


  self.tableView= [[KnowledgeTableView alloc] initWithFrame:self.view.bounds
                                               style:UITableViewStylePlain];
  [self.view addSubview:self.tableView];

  _tableView.tableHeaderView= _bannersVC.view;
  _tableView.tableFooterView=nil;// TODO, button
  _tableView.delegate=self;
  _tableView.dataSource=self;//TODO, split later

  [_tableView registerClass:[KnowledgeHomePageCategoryTableViewCell class]
     forCellReuseIdentifier:[KnowledgeHomePageCategoryTableViewCell bmt_reuseId]];

  _dataArray= [[NSMutableArray alloc] init];
  for(int i=0;i<20;i++){
    [_dataArray addObject:[[KnowledgeDataSourceModel alloc] initWithRandom]];
  }


}




- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tableViewSettings

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(CGFloat)    tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellStr=[KnowledgeHomePageCategoryTableViewCell bmt_reuseId];//used for reuse
  KnowledgeHomePageCategoryTableViewCell *cell=[self.tableView
      dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];

  NSString * titleText=[NSString stringWithFormat:@"Row %@",self.dataArray[indexPath.row].title];
  NSString * detailText=[NSString stringWithFormat:@"Row %@",self
      .dataArray[indexPath.row].detail];
  //NSString * Text=[NSString stringWithFormat:@"Row %@",self
  // .dataArray[indexPath.row].title];
  cell.titleLabel.text=titleText;
  cell.contentLabel.text=detailText;

  return cell;
}

#pragma mark UISettings
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
@end
