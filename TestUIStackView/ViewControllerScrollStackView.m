//
//  ViewControllerScrollStackView.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/7/6.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewControllerScrollStackView.h"
#import "Masonry.h"

@interface ViewControllerScrollStackView ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIStackView   *stackView;
@property (nonatomic, strong) NSArray       *tenItemView;   //10个view

@end

@implementation ViewControllerScrollStackView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.stackView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(200, 10, 200, 10));
    }];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.centerX.equalTo(self.scrollView);
    }];
    
    for (UIView *v in self.tenItemView) {
        [self.stackView addArrangedSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@80);
        }];
    }
}

#pragma mark - Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    ++i;
    i %= 10;
    
    UIView *v = self.tenItemView[i];
    v.hidden = !v.hidden;
}

#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollView;
}

- (UIStackView *)stackView
{
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 20;
    }
    return _stackView;
}

@end
