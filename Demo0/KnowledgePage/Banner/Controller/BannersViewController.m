//
//  BannersViewController.m
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "BannersViewController.h"
#define DEFAULTNUMS (3)

@interface BannersViewController ()

@end

@implementation BannersViewController

- (instancetype)init {
  return [self initWithBannerNums:DEFAULTNUMS];
}


- (instancetype)initWithBannerNums:(NSInteger)num {
  self = [super init];
  if (self) {
    self.bannerNums = num;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  //TODO add view after found in either db(first) or server
  //find out if the banners in the db
  //yes no
  self.view = [[RWUIScrollView alloc] init];

}
- (void)viewDidLoad {
  [super viewDidLoad];
  [(RWUIScrollView *) self.view setStyle1];
    self.banners;
  // Do any additional setup after loading the view.
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



#pragma mark private
- (SQLManager *)sqlManager {
  return [SQLManager shareManager];
}
- (SessionRequestManager *)sessionRequestManager {
  return [SessionRequestManager sharedManager];
}

// TODO add search in database gateway here
// TODO add get in server gateway here
- (NSMutableArray<RWBanner *> *)banners {
  if (!_banners) {
    _banners = [[NSMutableArray alloc] init];
    NSInteger foundBanners = _banners.count;

    /*
    foundBanners=[self.sqlManager serchBannersInDB];
    if(foundBanners <self.bannerNums)
    {
        //get rest banner from server
    }
    else{
        //get the banner from database
    }
     */

    // test code

    WRPersonModel *personModel = nil;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];

    @weakify(self)
    [self.sessionRequestManager getObjFromServerSuccess:
            ^(id obj) {
              @strongify(self)
              [mutableArray addObject:obj];
            }
                                                failure:^(NSError **error) {
                                                  // donothing here
                                                }];
  }

  return _banners;
}

@end