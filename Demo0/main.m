//
//  main.m
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/12.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WRPersonModel.h"
#import "WRCalculator.h"
#import "WRracCal.h"

int main(int argc, char * argv[]) {
    int i1=main_WRrac();
    int i2=main_WRCal();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }

    //[WRPersonModel createPersonForTest];
}
