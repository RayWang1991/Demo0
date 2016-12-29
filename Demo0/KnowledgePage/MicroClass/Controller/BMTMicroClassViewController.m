//
//  BMTMicroClassViewController.m
//  Demo0
//
//  Created by ray wang on 16/12/16.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "BMTMicroClassViewController.h"

@interface BMTMicroClassViewController ()

@end

@implementation BMTMicroClassViewController
- (instancetype)init {
  self = [super init];
  if (self) {
    _dataManager = [BMTMicroClassInfoDataManager sharedManager];
  }
  return self;
}

- (void)loadView {
  self.view = [[BMTMicroClassView alloc] initWithFrame:CGRectMake(0, 190, 375,
                                                                  80)];
  //[self testNetwork];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(dataArrived:)
                                               name:@"MicroClassInfoDataArrived"
                                             object:nil];
  [self.dataManager getLatestMicroClassInfo];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)testNetwork {
  [[SessionRequestManager sharedManager]
      getLatestMicroClassInfoFromServerOnSuccess:nil
                                         failure:nil];
}
- (void)dataArrived:(NSNotification *)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    BMTMicroClassView *microClassView = (BMTMicroClassView *) self.view;
    [microClassView setUpWithEntity:self.dataManager.microClassInfoEntity];
  });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
