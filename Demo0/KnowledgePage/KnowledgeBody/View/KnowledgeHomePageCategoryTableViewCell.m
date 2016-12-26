/**
 * Copyright (c) 2016, Bongmi
 * All rights reserved
 * Author: wangrui@bongmi.com
 *
 * KnowledgeHomePageCategoryTableViewCell.m 
 * Created by ray wang on 16/12/22.
 */

#import "KnowledgeHomePageCategoryTableViewCell.h"

@implementation KnowledgeHomePageCategoryTableViewCell {

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
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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

  self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size
      .width, 100);
  self.backView.frame = self.contentView.bounds;
  self.titleLabel.frame = CGRectMake(100, 10, [UIScreen mainScreen].bounds.size
      .width-20, 20);
  self.contentLabel.frame = CGRectMake(100, 30, [UIScreen mainScreen].bounds
      .size
      .width-20, 50);
  self.bottomView.frame = CGRectMake(100, 80, [UIScreen mainScreen].bounds.size
      .width-20, 20);
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
- (UIView *)bottomView {
  if (!_bottomView) {
    _bottomView = [[BottomView alloc] init];
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
    _bottomView.clickedNumLabel.text=@"0";
    //
    _bottomView.likeNumLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 40, 20)];
    _bottomView.likeNumLabel.text=@"0";

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
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC"
                                       size:16];
    _titleLabel.textColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.87];
    _titleLabel.numberOfLines = 2;
  }
  return _titleLabel;
}
- (UILabel *)contentLabel {
  if (!_contentLabel) {
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:@"PingFangSC"
                                         size:16];
    _contentLabel.textColor =
        [[UIColor blackColor] colorWithAlphaComponent:0.87];
    _contentLabel.numberOfLines = 2;
  }
  return _contentLabel;
}
- (UIImageView *)knowledgeImageView {
  if (!_knowledgeImageView) {
    _knowledgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4,
                                                                        4, 78,
                                                                        70)];
  }
  return _knowledgeImageView;
}
#pragma mark - setter
- (void)setImage {
  if (!self.imageView) {
    //set image here
  }
}

@end
