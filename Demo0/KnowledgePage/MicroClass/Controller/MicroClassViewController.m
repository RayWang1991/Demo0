//
//  MicroClassViewController.m
//  Demo0
//
//  Created by ray wang on 16/12/16.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "MicroClassViewController.h"

@interface MicroClassViewController ()

@end

@implementation MicroClassViewController
-(void)loadView{
    self.view= [[BMTMicroClassView alloc] initWithFrame:CGRectMake(0,190,375,
                                                                   80)];
    [self testNetwork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) testNetwork{
  [[SessionRequestManager sharedManager]
      getLatestMicroClassInfoFromServerOnSuccess:nil
                                         failure:nil];
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
