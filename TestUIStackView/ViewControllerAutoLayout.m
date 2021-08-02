//
//  ViewControllerAutoLayout.m
//  TestUIStackView
//
//  Created by 周彬涵 on 2020/4/2.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import "ViewControllerAutoLayout.h"
#import "Masonry.h"

@interface ViewControllerAutoLayout ()

@property (nonatomic, strong) UIView    *contentView;
@property (nonatomic, strong) NSArray   *tenItemView;   //10个view
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer   *timer;

@property (nonatomic, assign) double    resultInterval;

@end

@implementation ViewControllerAutoLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@240);
    }];
}

- (void)appendOne
{
    [self.contentView addSubview:self.tenItemView[self.index++]];
    [self reframe];
}

- (void)removeLast
{
    [self.tenItemView[--self.index] removeFromSuperview];
    [self reframe];
}

- (void)reframe
{
    if (self.index == 1) {  //只有一个
        UIView *v = self.tenItemView.firstObject;
        [v mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
            make.height.equalTo(@40);
        }];
        return;
    }
    
    UIView *formerV = nil;
    for (NSInteger i = 0; i < self.index; ++i) {
        
        UIView *v = self.tenItemView[i];
        if (i == 0) {   //第一个
            [v mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.contentView);
                make.height.equalTo(@40);
            }];
        } else if (i == self.index - 1) {   //最后一个
            [v mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(formerV.mas_bottom).offset(20);
                make.left.bottom.right.equalTo(self.contentView);
                make.height.equalTo(@40);
            }];
        } else {
            [v mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(formerV.mas_bottom).offset(20);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@40);
            }];
        }
        formerV = v;
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
        self.timer = nil;           //resultInterval = 0.47253060340881348
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
