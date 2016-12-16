/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgePageViewController.m 
 * Created by ray wang on 16/12/16.
 */

#import "KnowledgePageViewController.h"

@implementation KnowledgePageViewController {

}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setViewBasicStyle];
  self.bannersVC = [[BannersViewController alloc] init];
  [self.view addSubview:self.bannersVC.view];
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
