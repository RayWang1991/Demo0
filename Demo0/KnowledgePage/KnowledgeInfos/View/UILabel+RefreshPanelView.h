/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * UILabel+RefreshPanel.h 
 * Created by ray wang on 16/12/26.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define REFRESH_PANEL_HEIGHT (30)
#define REFRESH_PANEL_HINT_TEXT @"下拉刷新"
#define REFRESH_PANEL_COMPLETE_TEXT @"放开刷新"

@interface UILabel (RefreshPanelView)
-(instancetype) initWithHintText;
-(void) setHintText;
-(void) setCompleteText;
@end