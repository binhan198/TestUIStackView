//
//  ViewController.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/3/24.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIStackView       *stackView;
@property (nonatomic, strong) NSMutableArray    *needHiddenViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"使用Frame布局", @"使用AutoLayout", @"UIStackView布局", @"嵌套UIStackView布局", @"ViewControllerScrollStackView"];
    for (NSInteger i = 0; i < titleArray.count; ++i) {
        NSString *title = titleArray[i];
        UIButton *btn = [self createButtonWithTitle:title andTag:i];
        [self.stackView addArrangedSubview:btn];
        //隐藏view
        if (i == 1 || i == 3) {
            btn.hidden = YES;
            [self.needHiddenViews addObject:btn];
        }
    }
    
    [self.view addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.8);
    }];
}

- (UIButton *)createButtonWithTitle:(NSString *)title andTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:random()%130/255.0 green:random()%130/255.0 blue:random()%130/255.0 alpha:1];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds = YES;
    return btn;
}

- (void)btnClicked:(UIButton *)sender
{
    UIViewController *vc = nil;
    switch (sender.tag) {
        case 0:
            vc = [NSClassFromString(@"ViewControllerFrame") new];
            vc.navigationItem.title = @"ViewControllerFrame";
            break;
        case 1:
            vc = [NSClassFromString(@"ViewControllerAutoLayout") new];
            vc.navigationItem.title = @"ViewControllerAutoLayout";
            break;
        case 2:
            vc = [NSClassFromString(@"ViewControllerUIStackView") new];
            vc.navigationItem.title = @"ViewControllerUIStackView";
            break;
        case 3:
            vc = [NSClassFromString(@"ViewControllerMultiStackView") new];
            vc.navigationItem.title = @"ViewControllerMultiStackView";
            break;
        case 4:
            vc = [NSClassFromString(@"ViewControllerScrollStackView") new];
            vc.navigationItem.title = @"ViewControllerScrollStackView";
        default:
            break;
    }
    
    [vc performSelector:@selector(setTenItemView:) withObject:[self createTenView]];
    
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)createTenView
{
    NSMutableArray *arrM = [NSMutableArray new];
    for (NSInteger i = 0; i < 10; ++i) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor colorWithRed:random()%130/255.0 green:random()%130/255.0 blue:random()%130/255.0 alpha:1];
        [arrM addObject:v];
    }
    return arrM;
}

#pragma mark - 隐藏显示view

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIButton *btn in self.needHiddenViews) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.hidden = !btn.hidden;
        }];
    }
}

#pragma mark - Getter

- (UIStackView *)stackView
{
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 20;
//        _stackView.alignment = UIStackViewAlignmentCenter;
    }
    return _stackView;
}

- (NSMutableArray *)needHiddenViews
{
    if (!_needHiddenViews) {
        _needHiddenViews = [NSMutableArray new];
    }
    return _needHiddenViews;
}

@end
