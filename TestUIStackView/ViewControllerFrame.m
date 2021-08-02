//
//  ViewControllerFrame.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/4/2.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewControllerFrame.h"

@interface ViewControllerFrame ()

@property (nonatomic, strong) UIView    *contentView;
@property (nonatomic, strong) NSArray   *tenItemView;   //10个view
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer   *timer;

@property (nonatomic, assign) double    resultInterval;

@end

@implementation ViewControllerFrame

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentView];
    for (UIView *v in self.tenItemView) {
        [self.contentView addSubview:v];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.center = self.view.center;
}

- (void)appendOne
{
    [self.tenItemView[self.index++] setHidden:NO];
//    [self.contentView addSubview:self.tenItemView[self.index++]];
    [self reframe];
}

- (void)removeLast
{
    [self.tenItemView[--self.index] setHidden:YES];
//    [self.tenItemView[--self.index] removeFromSuperview];
    [self reframe];
}

- (void)reframe
{
    self.contentView.frame = CGRectMake(0, 0, 240, self.index * 60 - 20);
    for (NSInteger i = 0; i < self.index; ++i) {
        UIView *v = self.tenItemView[i];
        v.frame = CGRectMake(0, i * 60, 240, 40);
    }
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
        self.timer = nil;           //resultInterval = 0.021113395690917969
    }
}

#pragma mark -

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

@end
