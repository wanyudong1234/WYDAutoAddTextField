//
//  WYDAutoAddCell.m
//  AutoAddTextField
//
//  Created by wanyudong on 2017/12/11.
//  Copyright © 2017年 wanyudong. All rights reserved.
//

#import "WYDAutoAddCell.h"

@implementation WYDAutoAddCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.titleLable];
    }
    return self;
}

- (UILabel *)titleLable {
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, -5, self.bounds.size.width, self.bounds.size.height)];
        _titleLable.font = [UIFont systemFontOfSize:16];
    }
    return _titleLable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
