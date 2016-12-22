//
//  BannersViewController.m
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "BannersViewController.h"
#define DEFAULTNUMS (5)
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0\
        alpha:1.0]
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
  self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 277.5)];
  self.scrollView =
      [[BMTBannerScrollView alloc] initWithBannerNumber:DEFAULTNUMS];

  // set pageControl
  _pageControl = [[UIPageControl alloc]
      initWithFrame:CGRectMake(151.5, 174, 38, 8)];// TODO


}
- (void)viewDidLoad {
  [super viewDidLoad];


  //self.banners;//make sure banners info are ready

  [self.scrollView setStyle1];
  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];

  //_style for page control
  _pageControl.currentPage = 0;
  _pageControl.numberOfPages = self.bannerNums;
  _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
  _pageControl.pageIndicatorTintColor = UIColorFromHex(0xD0DFDE);
  
  [_pageControl addTarget:self
                   action:@selector(pageAction:)
         forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:_pageControl];
  self.banners;
  // [(BMTBannerScrollView *)self.view LoadImagesFromBanners:self.banners];
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

#pragma mark override

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  NSUInteger currentPageNum =
      (NSUInteger) (scrollView.contentOffset.x / CGRectGetWidth(self.scrollView
                                                                    .frame));
  self.pageControl.currentPage = currentPageNum;
}

#pragma mark event
- (void)pageAction:(UIPageControl *)sender {
  int page = (int) sender.currentPage;
  [self.scrollView setContentOffset:CGPointMake(
          page * CGRectGetWidth(self.scrollView
                                    .frame), 0)
                           animated:YES];
}

#pragma mark private
- (SQLManager *)sqlManager {
  return [SQLManager shareManager];
}

- (BMTBannerTable *)bannerTable {
  return [[FMDBManager sharedInstance] bannerTable];
}

- (SessionRequestManager *)sessionRequestManager {
  return [SessionRequestManager sharedManager];
}

// TODO add search in database gateway here
// TODO add get in server gateway here
- (NSArray<BMTEntityBanner *> *)banners {
  if (!_banners || _banners.count < DEFAULTNUMS) {
    /*
    _banners = [[NSMutableArray alloc] init];
    NSInteger foundBanners = _banners.count;
    */
    /*
    foundBanners=[self.sqlManager searchBannersInDB];
    if(foundBanners <self.bannerNums)
    {
        //get rest banner from server
    }
    else{
        //get the banner from database
    }
     */
    // check if the database has what we want
    if (DEFAULTNUMS > self.bannerTable.selectItemCount) {
      NSLog(@"Banner nums in table < DEFAULTNUMS");
      self.bannerTable.deleteAllBanners;
      NSLog(@"delete all banners");

      NSLog(@"get banners from server, start!");
      @weakify(self)
      [self.sessionRequestManager getObjsFromServerSuccess:^(NSArray
                                                             *resultArray) {
            @strongify(self)
            _banners = [NSArray arrayWithArray:resultArray];
            for (BMTEntityBanner *aBanner in _banners) {
              if (aBanner.name == nil) {
                aBanner.name = [[aBanner.imgSrc
                    componentsSeparatedByString:@"imgs/"] lastObject];
              }
            }
            NSLog(@"get banners from server, done!");
            [self refreshBanners];
            [self.bannerTable addBanners:_banners];

          }
                                                   failure:^(NSError *error) {
                                                     // show error here
                                                     NSLog(@"get obj error: "
                                                               "%@", error);
                                                   }
                                                      type:[BMTEntityBanner class]
                                                       num:DEFAULTNUMS];
    } else {
      NSLog(@"banner found in database");
      _banners = [self.bannerTable getBannersOrderedByName:DEFAULTNUMS];
      if (_banners == nil) {
        NSLog(@"get banners failed");
      }
      [self refreshBanners];
    }
  }
  // test code
  //NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
  return _banners;
}
- (BOOL)refreshBanners {
  [self.scrollView LoadImagesFromBanners:_banners];
  return YES;
}


@end
