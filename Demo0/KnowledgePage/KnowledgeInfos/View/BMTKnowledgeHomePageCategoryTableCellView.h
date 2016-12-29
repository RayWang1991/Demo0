/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeHomePageCategoryTableViewCell.h 
 * Created by ray wang on 16/12/22.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMTKnowledgeInfoEntity.h"
#import "BMTKnowledgeInfoCellBottomView.h"
#import "BMTKnowledgeInfoCellRefreshDelegate.h"
#import "SDWebImage/SDWebImageManager.h"

@interface BMTKnowledgeHomePageCategoryTableCellView :
    UITableViewCell<BMTKnowledgeInfoCellRefreshDelegate>
@property(strong, nonatomic) UIView *backView;
@property(strong, nonatomic) UIImageView *knowledgeImageView;
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UILabel *contentLabel;
@property(strong, nonatomic) BMTKnowledgeInfoCellBottomView *bottomView;
//@property (strong, nonatomic) BMTKnowledgeInfoEntity *model;

+ (NSString *)bmt_reuseId;

@end
