//
//  WYDAutoAddTextField.m
//  AutoAddTextField
//
//  Created by wanyudong on 2017/12/8.
//  Copyright © 2017年 wanyudong. All rights reserved.
//

#import "WYDAutoAddTextField.h"
#import "WYDAutoAddCell.h"

@interface WYDAutoAddTextField ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *autoAddView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSArray *emailSuffixs;

@end

@implementation WYDAutoAddTextField

// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _datas = [[NSMutableArray alloc] init];
        _emailSuffixs = [[NSArray alloc] init];
        [self addSubview:self.textField];
        [self addSubview:self.autoAddView];
    }
    return self;
}

- (void)setEmailSuffixDatas:(NSArray *)emalSuffixs {
    if (emalSuffixs != nil) {
        _emailSuffixs = emalSuffixs;
        CGFloat ViewsHeight = 0;
        ViewsHeight = [emalSuffixs count] * 30;
        if (ViewsHeight > 150) {
            ViewsHeight = 150;
        }
        // 更新列表的高度
        self.autoAddView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, ViewsHeight);
        [self.autoAddView reloadData];
    }
}

#pragma mark - 懒加载

- (UITableView *)autoAddView {
    if (_autoAddView == nil) {
        _autoAddView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height+5, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        _autoAddView.delegate = self;
        _autoAddView.dataSource = self;
        _autoAddView.hidden = YES;
        _autoAddView.showsVerticalScrollIndicator = NO;
        _autoAddView.layer.cornerRadius = 5.0f;
        _autoAddView.layer.masksToBounds = YES;
        _autoAddView.layer.borderColor = [[UIColor blackColor] CGColor];
        _autoAddView.layer.borderWidth = 1.0f;
        [_autoAddView registerClass:[WYDAutoAddCell class] forCellReuseIdentifier:@"AutoCompleteRowIdentifier"];
    }
    return _autoAddView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _textField.layer.borderColor = [[UIColor blackColor] CGColor];
        _textField.layer.borderWidth = 1.0f;
        _textField.layer.cornerRadius = 5.0f;
        _textField.layer.masksToBounds = YES;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)textFieldDidChange:(id)sender {
    if ([self.textField.text isEqualToString:@""] || [self.textField.text containsString:@"@"]) {
        _autoAddView.hidden = YES;
        return;
    }else {
        _datas = [[NSMutableArray alloc] init];
        _autoAddView.hidden = NO;
        for (int i=0; i<[_emailSuffixs count]; i++) {
            NSString *usernameText = [NSString stringWithFormat:@"%@@%@",self.textField.text, [_emailSuffixs objectAtIndex:i]];
            [_datas addObject:usernameText];
        }
        
        [_autoAddView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WYDAutoAddCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[WYDAutoAddCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
    cell.textLabel.text = [_datas objectAtIndex:indexPath.row];
    //灰色
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _autoAddView.hidden = YES;
    NSString *selectStr = [_datas objectAtIndex:indexPath.row];
    self.textField.text = selectStr;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden == NO && self.alpha > 0) {
        // 从后往前遍历自己的子控件
        NSInteger count = self.subviews.count;
        for (NSInteger i=count-1; i>=0; i--) {
            UIView *childView = self.subviews[i];
            // 把当前控件上的坐标系转换成子控件上的坐标系
            CGPoint childP = [self convertPoint:point toView:childView];
            UIView *fitView = [childView hitTest:childP withEvent:event];
            if (fitView) { // 寻找到最合适的view
                return fitView;
            }
        }
    }
    return nil;
}

@end
