//
//  AppDelegate.h
//  HTTPRequestTest
//
//  Created by ray wang on 16/12/12.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfoViewController.h"
#import "BMTKnowledgePageViewController.h"
#import "FMDBManager.h"

@interface AppDelegate : UIResponder<UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

