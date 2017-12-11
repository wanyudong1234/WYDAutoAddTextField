//
//  ViewController.m
//  AutoAddTextField
//
//  Created by wanyudong on 2017/12/8.
//  Copyright © 2017年 wanyudong. All rights reserved.
//

#import "ViewController.h"
#import "WYDAutoAddTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WYDAutoAddTextField *textField = [[WYDAutoAddTextField alloc] initWithFrame:CGRectMake(50, 200, 300, 50)];
    [textField setEmailSuffixDatas:@[@"sina.com", @"163.com", @"gmail.com", @"hotmail.com", @"qq.com"]];
    [self.view addSubview:textField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
