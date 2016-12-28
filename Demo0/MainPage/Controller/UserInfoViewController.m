/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * UserInfoViewController.m 
 * Created by ray wang on 16/12/12.
 */

#import "UserInfoViewController.h"
#import "Masonry/Masonry.h"
#import "Constants.h"
//#define weakify( x ) \
    autoreleasepool{} __weak typeof(x) __weak_##x##__ = x;



#define kMainScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kMainScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define maxId (4u)
static unsigned int count = 0u;

@implementation UserInfoViewController {
}
- (void)viewDidLoad {
  [super viewDidLoad];


    // scroll banner
    
    _bannerView=[[BMTBannerScrollView alloc]initWithFrame:CGRectMake(50, 70+10*30, 320, 200)];
    _bannerView.contentSize=CGSizeMake(3*(320), 200);
  [_bannerView setStyle];
//    [_bannerView LoadImagesFromBanners];
    [self.view addSubview:_bannerView];
    
    
  self.view.backgroundColor = [UIColor whiteColor];

  // userInfoTitle
  _userInfoTitle = [[UILabel alloc]
      initWithFrame:CGRectMake(100,
                               70 - 30,
                               kMainScreenWidth - 100 * 2,
                               20)];
  _userInfoTitle.text = @"User Information";
  _userInfoTitle.backgroundColor = [UIColor clearColor];
  _userInfoTitle.textAlignment = NSTextAlignmentCenter;
  _userInfoTitle.font = [UIFont systemFontOfSize:20];

  //userName
  _userNameView = [[KeyValueView alloc]
      initWithFrame:CGRectMake(100,
                               70,
                               kMainScreenWidth - 100 * 2,
                               30)];
  _userNameView.backgroundColor = [UIColor clearColor];

  //userSex
  _userSexView = [[KeyValueView alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30,
                               kMainScreenWidth - 100 * 2,
                               30)];
  _userSexView.backgroundColor = [UIColor clearColor];

  //userBirthday
  _userBirthdayView = [[KeyValueView alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 2,
                               kMainScreenWidth - 100 * 2,
                               30)];
  _userBirthdayView.backgroundColor = [UIColor clearColor];

  //userPhone
  _userPhoneView = [[KeyValueView alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 3,
                               kMainScreenWidth - 100 * 2,
                               30)];
  _userPhoneView.backgroundColor = [UIColor clearColor];

  //userEmail
  _userEmailView = [[KeyValueView alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 4,
                               kMainScreenWidth - 100 * 2,
                               30)];
  _userEmailView.backgroundColor = [UIColor clearColor];

  //getUserInfoButton
  _getUserInfoButton = [[UIButton alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 5,
                               kMainScreenWidth - 100 * 2,
                               25)];

  _getUserInfoButton.backgroundColor = [UIColor redColor];
  [_getUserInfoButton setTitle:@"Get User Info"
      forState:UIControlStateNormal];
  [_getUserInfoButton setTitleColor:[UIColor whiteColor]
      forState:UIControlStateNormal];
  [_getUserInfoButton addTarget:self
      action:@selector(loadWebRequest)
      forControlEvents:UIControlEventTouchUpInside];

  //readUserInfoButton
  _readUserInfoButton = [[UIButton alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 6,
                               kMainScreenWidth - 100 * 2,
                               25)];

  _readUserInfoButton.backgroundColor = [UIColor redColor];
  [_readUserInfoButton setTitle:@"Read User Info"
      forState:UIControlStateNormal];
  [_readUserInfoButton setTitleColor:[UIColor whiteColor]
      forState:UIControlStateNormal];
  [_readUserInfoButton addTarget:self
      action:@selector(readLocalRequest)
      forControlEvents:UIControlEventTouchUpInside];

  //saveUserInfoButton
  _saveUserInfoButton = [[UIButton alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 7,
                               kMainScreenWidth - 100 * 2,
                               25)];

  _saveUserInfoButton.backgroundColor = [UIColor redColor];
  [_saveUserInfoButton setTitle:@"Save User Info"
      forState:UIControlStateNormal];
  [_saveUserInfoButton setTitleColor:[UIColor whiteColor]
      forState:UIControlStateNormal];
  [_saveUserInfoButton addTarget:self
      action:@selector(saveLocalRequest)
      forControlEvents:UIControlEventTouchUpInside];



  //clearButton
  _clearButton = [[UIButton alloc]
      initWithFrame:CGRectMake(100,
                               70 + 30 * 8,
                               kMainScreenWidth - 100 * 2,
                               25)];

  _clearButton.backgroundColor = [UIColor redColor];
  [_clearButton setTitle:@"Clear"
      forState:UIControlStateNormal];
  [_clearButton setTitleColor:[UIColor whiteColor]
      forState:UIControlStateNormal];
  [_clearButton addTarget:self
      action:@selector(clearRequest)
      forControlEvents:UIControlEventTouchUpInside];

  //cnextButton
  _nextButton = [[UIButton alloc]
      initWithFrame:CGRectMake(100,
                               70 - 30 ,
                               50,
                               25)];

  _nextButton.backgroundColor = [UIColor orangeColor];
  [_nextButton setTitle:@"Next"
                forState:UIControlStateNormal];
  [_nextButton setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
  [_nextButton addTarget:self
                   action:@selector(nextPage)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_nextButton];
@weakify(self)
  [_nextButton mas_makeConstraints:^(MASConstraintMaker *maker){
    @strongify(self)
    maker.top.equalTo(self.view).offset(10);
    maker.right.equalTo(self.view).offset(-10);
  }];

  [self.view addSubview:_userInfoTitle];
  [self.view addSubview:_userNameView];
  [self.view addSubview:_userSexView];
  [self.view addSubview:_userBirthdayView];
  [self.view addSubview:_userPhoneView];
  [self.view addSubview:_userEmailView];
  [self.view addSubview:_getUserInfoButton];
  [self.view addSubview:_readUserInfoButton];
  [self.view addSubview:_saveUserInfoButton];
  [self.view addSubview:_clearButton];


  [self refreshView];
}

#pragma  mark event

- (void)readLocalRequest {
  SQLManager *manager = [SQLManager shareManager];
  WRPersonModel *model = [manager searchLatest];
  [self refreshModel:model];
}

- (void)saveLocalRequest {
  SQLManager *manager = [SQLManager shareManager];
  [manager insertOrReplace:self.personModel];
  [[NSFileManager defaultManager] writeFileById:self.personModel];
}

- (void)loadWebRequest {

  // the basic GET formplatform :ios, '8.0'
  // http:// hostName : port / absolute paths ? query (key1 = value1 & key2 =
  // value2)

  // base url of the server
  unsigned int fileId = (count++) % maxId;

  NSURL *base =
      [NSURL URLWithString:[NSString stringWithFormat:@"https://raw.githubusercontent.com/RayWang1991/TestData/master/person%d.json",
                                                      fileId]];
  /* NSString *path = @"/WebServer/docPath?count=1234";
   NSURL *url = [base URLByAppendingPathComponent:path];*/

  // set the request ,the default request is GET
  // or use NSMutableURLRequest *
  NSURLRequest *request = [NSURLRequest requestWithURL:base];

  // set and start the connection
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
      delegate:self];
  [connection start];

  NSLog(@"complete");
}

- (void)clearRequest {
  @autoreleasepool {
    _personModel = nil;
    [self refreshModel:_personModel];
  }
}

-(void)nextPage{
}

#pragma mark network
// TODO ：split the network module
- (void)connection:(NSURLConnection *)connection
didReceiveResponse:
    (NSURLResponse *)response {
  NSLog(@"%@", response);
  // deal with the error case;

}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {

  if (!_dataFrag) {
    _dataFrag = [[NSMutableData alloc] init];
  }

  [_dataFrag appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
/*
 
    NSDictionary *dict = @{
                           @"name": @"frank",
                           @"sex": @(YES),
                           @"birthday": @"2016.12.12",
                           @"phone": @"12345678",
                           @"email": @"frank@125.com"
                           };
    
    NSData *dictJson=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * json=[NSJSONSerialization JSONObjectWithData:dictJson options:0 error:nil];
    
    
    
    NSString* obj = [NSJSONSerialization JSONObjectWithData:dictJson
        options:NSJSONReadingMutableContainers error:nil];
  NSLog(@"%@", dictJson);
  NSLog(@"%@", obj);
 */
  @autoreleasepool {
    NSLog(@"the connection will be finished");
    NSLog(@"%@", _dataFrag);
    id jsonDic = [NSJSONSerialization JSONObjectWithData:_dataFrag
        options:NSJSONReadingMutableContainers
        error:nil];
    NSLog(@"%@,%@", jsonDic, [jsonDic class]);
    if ([jsonDic isKindOfClass:[NSDictionary class]]) {
      jsonDic = (NSDictionary *) jsonDic;

      unsigned int uId = (unsigned int) [jsonDic[@"userId"] integerValue];
      NSString *userName = jsonDic[@"name"];
      NSString *userSex = [jsonDic[@"sex"] integerValue] ? @"male" : @"female";
      NSString *userPhone = jsonDic[@"phone"];
      NSString *userEmail = jsonDic[@"email"];
      NSString *userBirthday = jsonDic[@"birthday"];

      WRPersonModel *aModel =
          [[WRPersonModel alloc] initWithUserId:uId
              Name:userName
              Sex:userSex
              Birthday:userBirthday
              Phone:userPhone
              Email:userEmail];
      [self refreshModel:aModel];

    } else {
      NSLog(@"unavailable model format");
    }
    _dataFrag = nil;
  }
}

#pragma mark private method
- (void)refreshModel:(WRPersonModel *)aModel {
  self.personModel = aModel;
  [self refreshView];
}

- (void)refreshView {
  [_userNameView setUpKey:@"NAME"
      value:self.personModel.name];
  [_userSexView setUpKey:@"SEX"
      value:self.personModel.sex];
  [_userBirthdayView setUpKey:@"BD"
      value:self.personModel.birthday];
  [_userPhoneView setUpKey:@"PHONE"
      value:self.personModel.phone];
  [_userEmailView setUpKey:@"EMAIL"
      value:self.personModel.email];
}

@end
