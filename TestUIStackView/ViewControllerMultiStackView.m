//
//  ViewControllerMultiStackView.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/4/2.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewControllerMultiStackView.h"
#import "Masonry.h"

@interface ViewControllerMultiStackView ()

@property (nonatomic, strong) NSArray   *tenItemView;   //10个view

@property (nonatomic, strong) UIStackView   *mainStackView;
@property (nonatomic, assign) NSInteger     rowIndex;
@property (nonatomic, assign) NSInteger     clmIndex;

@property (nonatomic, strong) NSTimer       *timer;

@end

@implementation ViewControllerMultiStackView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainStackView];
    [self.mainStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@236);
    }];
    self.clmIndex = 10;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (UIView *)createView
{
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor colorWithRed:random()%160/255.0 green:random()%160/255.0 blue:random()%160/255.0 alpha:1];
    return v;
}

- (UIStackView *)appendOneStackView
{
    UIStackView *staView = [UIStackView new];
    staView.axis = UILayoutConstraintAxisHorizontal;
    staView.distribution = UIStackViewDistributionFillEqually;
    staView.spacing = 4;
    [self.mainStackView addArrangedSubview:staView];
    [staView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
    }];
    ++self.rowIndex;
    self.clmIndex = 0;
    return staView;
}

- (void)appendOne
{
    UIView *v = [self createView];
    UIStackView *staV = nil;
    if (self.clmIndex >= 10) {
        staV = [self appendOneStackView];
    } else {
        staV = [[self.mainStackView arrangedSubviews] objectAtIndex:self.rowIndex - 1];
    }
    [staV addArrangedSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
    }];
    ++self.clmIndex;
}

- (void)removeLast
{
    if (self.clmIndex <= 0) {
        [self.mainStackView.arrangedSubviews.lastObject removeFromSuperview];
        --self.rowIndex;
        self.clmIndex = 10;
    }
    UIStackView *staV = [[self.mainStackView arrangedSubviews] objectAtIndex:self.rowIndex - 1];
    [staV.arrangedSubviews.lastObject removeFromSuperview];
    --self.clmIndex;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerTrigerred:) userInfo:nil repeats:YES];
}

- (void)timerTrigerred:(NSTimer *)t
{
    static int countIndex = 120;
    
    if (countIndex > 60) {
        [self appendOne];
    } else {
        [self removeLast];
    }

    --countIndex;
    if (countIndex <= 0) {
        countIndex = 120;
    }
}

#pragma mark - Getter

- (UIStackView *)mainStackView
{
    if (!_mainStackView) {
        _mainStackView = [UIStackView new];
        _mainStackView.axis = UILayoutConstraintAxisVertical;
        _mainStackView.distribution = UIStackViewDistributionFillEqually;
        _mainStackView.spacing = 4;
        _mainStackView.alignment = UIStackViewAlignmentCenter;
    }
    return _mainStackView;
}

@end
