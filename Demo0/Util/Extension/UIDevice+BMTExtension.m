/**
 * Copyright (c) 2015, Bongmi
 * All rights reserved
 * Author: lixianliang@bongmi.com
 */

#import "UIDevice+BMTExtension.h"

@implementation UIDevice (BMTExtension)

- (void)bmt_rotateTo:(UIInterfaceOrientation)orientation
{
    [self setValue:@(orientation) forKey:@"orientation"];
}

@end
