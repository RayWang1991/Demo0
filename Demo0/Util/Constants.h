//
//  Constants.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright (c) 2016 ray wang. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

#import <Foundation/Foundation.h>
#define weakify(x) autoreleasepool{} __weak typeof(&*x) __weak__##x##__ = x;
#define strongify(x) autoreleasepool{}  typeof(&*x) x = __weak__##x##__;
extern NSString *const kNetBaseUrlAddress;
