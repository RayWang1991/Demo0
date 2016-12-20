/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "UIScreen+BMTExtension.h"
#import "UIDevice+BMTExtension.h"


@implementation UIScreen (BMTExtension)

- (UIInterfaceOrientation)bmt_currentInterfaceOrientation
{
    id<UICoordinateSpace> currentCoordinateSpace = self.coordinateSpace;
    id<UICoordinateSpace> portaitCoordinateSpace = self.fixedCoordinateSpace;
    CGSize portaintSize = self.nativeBounds.size;
    CGPoint position = [currentCoordinateSpace convertPoint:CGPointZero toCoordinateSpace:portaitCoordinateSpace];
    if (CGPointEqualToPoint(position, CGPointZero)) {
        // 方向不变
        return UIInterfaceOrientationPortrait;
    } else if (CGPointEqualToPoint(position, CGPointMake(portaintSize.width, portaintSize.height))) {
        // 180度旋转
        return UIInterfaceOrientationPortraitUpsideDown;
    } else if (CGPointEqualToPoint(position, CGPointMake(0, portaintSize.width))) {
        // home按键在屏幕的右边
        return UIInterfaceOrientationLandscapeRight;
    } else if (CGPointEqualToPoint(position, CGPointMake(portaintSize.height, 0))) {
        // home按键在屏幕的左边
        return UIInterfaceOrientationLandscapeLeft;
    } else {
        assert(NO);
        return UIInterfaceOrientationUnknown;
    }
}

@end
