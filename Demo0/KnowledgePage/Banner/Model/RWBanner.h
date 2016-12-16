//
//  RWBanner.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWBanner : NSObject
@property(strong, nonatomic) NSString *imgSrc;
@property(strong, nonatomic) NSString *href;
@property(strong, nonatomic) NSString *altText;
@property(assign, nonatomic) NSInteger height;
@property(assign, nonatomic) NSInteger width;
@property(assign, nonatomic) NSInteger Language;


@end
