//
//  ViewControllerUIStackView.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/4/2.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewControllerUIStackView.h"
#import "Masonry.h"

@interface ViewControllerUIStackView ()

@property (nonatomic, strong) UIStackView   *stackView;
@property (nonatomic, strong) NSArray       *tenItemView;   //10个view
@property (nonatomic, assign) NSInteger     index;
@property (nonatomic, strong) NSTimer       *timer;

@property (nonatomic, assign) double    resultInterval;

@end

@implementation ViewControllerUIStackView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@240);
    }];
    for (UIView *v in self.tenItemView) {
        [self.stackView addArrangedSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        v.hidden = YES;
    }
}

- (void)appendOne
{
    [self.tenItemView[self.index++] setHidden:NO];
    [self reframe];
}

- (void)removeLast
{
    [self.tenItemView[--self.index] setHidden:YES];
    [self reframe];
}

- (void)reframe
{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTrigerred:) userInfo:nil repeats:YES];
}

- (void)timerTrigerred:(NSTimer *)t
{
    static int countIndex = 100;
    static int direction = 1;
    
    
    NSTimeInterval beginInterval = [[NSDate date] timeIntervalSince1970];
    if (direction == 1) {   //增加
        [self appendOne];
    } else if (direction == -1) {   //减少
        [self removeLast];
    } else {
        
    }
    NSTimeInterval endInterval = [[NSDate date] timeIntervalSince1970];
    self.resultInterval += (endInterval - beginInterval);
    
    
    if (self.index >= self.tenItemView.count) {
        direction = -1;
    }
    if (self.index <= 0) {
        direction = 1;
    }
    
    --countIndex;
    if (countIndex <= 0) {
        countIndex = 100;
        direction = 1;
        [self.timer invalidate];
        self.timer = nil;           //resultInterval = 0.024991273880004883
    }
}

#pragma mark -

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

@end
