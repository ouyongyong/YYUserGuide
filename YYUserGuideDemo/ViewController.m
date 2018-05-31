//
//  ViewController.m
//  YYUserGuideDemo
//
//  Created by ouyongyong on 2018/5/31.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+YYUserGuide.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickShowGuide:(id)sender {
    [self yy_showUserGuideWithNib:@"Guide"];
}

@end
