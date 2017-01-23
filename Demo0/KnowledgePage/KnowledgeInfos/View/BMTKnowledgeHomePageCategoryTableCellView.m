/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeHomePageCategoryTableViewCell.m 
 * Created by ray wang on 16/12/22.
 */

#import <SDWebImage/UIImageView+WebCache.h>
#import "BMTKnowledgeHomePageCategoryTableCellView.h"

@implementation BMTKnowledgeHomePageCategoryTableCellView {

}

#pragma mark - override
+ (NSString *)bmt_reuseId {
  return NSStringFromClass(self);
}

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style
                  reuseIdentifier:reuseIdentifier]) {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self contentAddSubViewToSuperView];
    [self setImage];
    [self setStyle];
  }
  return self;
}

#pragma mark - private
- (void)contentAddSubViewToSuperView {
  [self.contentView addSubview:self.backView];
  //[self.backView addSubview:self.imageView];
  [self.backView addSubview:self.contentLabel];
  [self.backView addSubview:self.titleLabel];
  [self.backView addSubview:self.bottomView];
  [self.backView addSubview:self.knowledgeImageView];
}

- (void)setStyle {
  CGFloat x = 15;
  CGFloat width = [UIScreen mainScreen].bounds.size.width - 15 * 2;
  CGFloat height = 100;
  self.contentView.frame =
      CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
  self.backView.frame = CGRectMake(x, 0, width, height);
  self.titleLabel.frame = CGRectMake(105, 10, 240, 20);
  self.contentLabel.frame = CGRectMake(105, 30, 240, 50);
  self.bottomView.frame = CGRectMake(105, 80, 140, 14);
  self.knowledgeImageView.frame = CGRectMake(0, 10, 90, 78);
}

#pragma mark - getter
- (UIView *)backView {
  if (!_backView) {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    //_backView.cornerStyle = BMTRoundedViewStyleAllCorner;
    //_backView.cornerRadius = 4.0f;

  }
  return _backView;
}
- (BMTKnowledgeInfoCellBottomView *)bottomView {
  if (!_bottomView) {
    _bottomView = [[BMTKnowledgeInfoCellBottomView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];


    //_backView.cornerStyle = BMTRoundedViewStyleAllCorner;
    //_backView.cornerRadius = 4.0f;
    //
    _bottomView.eyeImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _bottomView.eyeImageView.image =
        [UIImage imageNamed:@"preview-icon_eye.png"];
    //
    _bottomView.thumbImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 20, 20)];
    _bottomView.thumbImageView.image =
        [UIImage imageNamed:@"preview-icon_small_like_it.png"];
    //
    _bottomView.clickedNumLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 20)];
    _bottomView.clickedNumLabel.text = @"";
    //
    _bottomView.likeNumLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 40, 20)];
    //_bottomView.likeNumLabel.text = @"";


    _bottomView.likeNumLabel.textColor = [UIColor colorWithWhite:0
                                                           alpha:0.26];
    _bottomView.likeNumLabel.font = [UIFont fontWithName:@"Helvetica"
                                                    size:14];

    _bottomView.clickedNumLabel.textColor = [UIColor colorWithWhite:0
                                                              alpha:0.26];
    _bottomView.clickedNumLabel.font = [UIFont fontWithName:@"Helvetica"
                                                       size:14];

    [_bottomView addSubview:_bottomView.eyeImageView];
    [_bottomView addSubview:_bottomView.thumbImageView];
    [_bottomView addSubview:_bottomView.clickedNumLabel];
    [_bottomView addSubview:_bottomView.likeNumLabel];
  }
  return _bottomView;
}
- (UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica"
                                       size:17];
    _titleLabel.textColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.87];
    _titleLabel.numberOfLines = 1;
  }
  return _titleLabel;
}
- (UILabel *)contentLabel {
  if (!_contentLabel) {
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"Helvetica"
                                         size:14];
    _contentLabel.textColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.54];
    _contentLabel.numberOfLines = 2;
  }
  return _contentLabel;
}
- (UIImageView *)knowledgeImageView {
  if (!_knowledgeImageView) {
    _knowledgeImageView = [[UIImageView alloc] init];
  }
  return _knowledgeImageView;
}
#pragma mark - setter
- (void)setImage {
  if (!self.imageView) {
    //set image here
  }
}
- (void)setCellViewByEntity:(BMTKnowledgeInfoEntity *)entity
                atIndexPath:
                    (NSIndexPath *)indexPath {
  NSString *titleText = [NSString stringWithFormat:@"Row %d %@",
                                                   indexPath.row,
                                                   entity.title];
  NSString *detailText = [NSString stringWithFormat:@"%@",
                                                    entity.summary];
  NSNumber *clickedNum = entity.click;
  NSNumber *likeNum = entity.like;
  // turn the chinese URL into % format
  NSString *originalURLStr = entity.thumbSrc;
  NSLog(@"the original URL string is %@", originalURLStr);
  NSString *formatedURLStr = [originalURLStr
      stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
          characterSetWithCharactersInString:@"^ "]
          .invertedSet];
  NSLog(@"the formated URL string is %@", formatedURLStr);
  NSURL *knowledgeImageURL = [NSURL URLWithString:formatedURLStr];
  //NSString * Text=[NSString stringWithFormat:@"Row %@",self
  // .dataArray[indexPath.row].title];
  self.titleLabel.text = titleText;
  self.contentLabel.text = detailText;
  self.bottomView.clickedNumLabel.text = [NSString stringWithFormat:@"%@",
                                                                    clickedNum];
  self.bottomView.likeNumLabel.text = [NSString stringWithFormat:@"%@",
                                                                 likeNum];
  [self.knowledgeImageView sd_setImageWithURL:knowledgeImageURL
                             placeholderImage:[UIImage imageNamed:@"1.jpg"]
                                      options:SDWebImageRetryFailed
                                     progress:nil
                                    completed:
                                        ^(UIImage *image, NSError *error, SDImageCacheType
                                        cacheType, NSURL *completeImageURL) {
                                          //save the image here
                                          //banners[i].bannerImage=imageView.image;

                                          NSLog(@"refesh knowledgeInfo images, done!");
                                          switch (cacheType) {
                                            case SDImageCacheTypeNone:NSLog(@"knowledgeInfo Image 直接下载");
                                              break;
                                            case SDImageCacheTypeDisk:NSLog(@"knowledgeInfo Image 磁盘缓存");
                                              break;
                                            case SDImageCacheTypeMemory:NSLog(@"knowledgeInfo Image 内存缓存");
                                              break;
                                            default:break;
                                          }
                                        }
  ];
}


@end
