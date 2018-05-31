//
//  UIViewController+YYUserGuide.m
//  YYUserGuideDemo
//
//  Created by ouyongyong on 2018/5/31.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import "UIViewController+YYUserGuide.h"

@interface YYUserGuideViewController : UIViewController
@property (nonatomic, strong) NSMutableArray* guideViews;
@end

@implementation YYUserGuideViewController

- (NSMutableArray *)guideViews {
    if (!_guideViews) {
        _guideViews = @[].mutableCopy;
    }
    return _guideViews;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    for (UIView* view in _guideViews) {
        BOOL hasBtn = NO;
        for (UIView* subView in view.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton* btn = (UIButton*)subView;
                [btn addTarget:self action:@selector(clickGuideBtn:) forControlEvents:UIControlEventTouchUpInside];
                hasBtn = YES;
            }
            
        }
        if (!hasBtn) {
            UIControl* control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
            control.backgroundColor = [UIColor clearColor];
            [control addTarget:self action:@selector(clickGuideBtn:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:control];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self popGuideView];
}

- (void)clickGuideBtn:(id)sender {
    UIView* btn = sender;
    UIView* guide = btn.superview;
    if (guide) {
        [guide removeFromSuperview];
        [self.guideViews removeObject:guide];
    }
    [self popGuideView];
}

- (void)popGuideView {
    if (self.guideViews.count > 0) {
        UIView* guideView = self.guideViews.firstObject;
        [guideView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [guideView setAutoresizingMask:0xf];
        [self.view addSubview:guideView];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
@end

@implementation UIViewController (YYUserGuide)

- (NSString*)yy_keyForGuideWithNib:(NSString*)nibName {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), nibName];
}

- (BOOL)yy_hasShowedGuideNib:(NSString*)nibName {
    NSString* key = [self yy_keyForGuideWithNib:nibName];
    NSNumber* res = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return (res.boolValue == YES);
}

- (void)yy_showUserGuideWithNib:(NSString*)nibName {
    if ([self yy_hasShowedGuideNib:nibName]) {
        return;
    }
    
    NSArray* arr = [[UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil];
    if (!arr || arr.count == 0) {
        return;
    }
    YYUserGuideViewController* pvc = [[YYUserGuideViewController alloc] init];
    pvc.providesPresentationContextTransitionStyle = YES;
    pvc.definesPresentationContext = YES;
    pvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [pvc.guideViews addObjectsFromArray:arr];
    [self presentViewController:pvc animated:NO completion:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:[self yy_keyForGuideWithNib:nibName]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
