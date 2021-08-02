//
//  TestUIStackViewTests.m
//  TestUIStackViewTests
//
//  Created by 周彬涵 on 2020/3/24.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewControllerFrame.h"
#import "ViewControllerAutoLayout.h"
#import "ViewControllerUIStackView.h"

@interface TestUIStackViewTests : XCTestCase

@property (nonatomic, strong) ViewControllerFrame       *frameVC;
@property (nonatomic, strong) ViewControllerAutoLayout  *autLaVC;
@property (nonatomic, strong) ViewControllerUIStackView *stackVC;

@end

@implementation TestUIStackViewTests

- (void)setUp {
    self.frameVC = [ViewControllerFrame new];
    self.autLaVC = [ViewControllerAutoLayout new];
    self.stackVC = [ViewControllerUIStackView new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.frameVC = nil;
    self.autLaVC = nil;
    self.stackVC = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

#pragma mark -

- (void)testFrameVC_CPU {
    [self measureWithMetrics:@[[[XCTCPUMetric alloc] initLimitingToCurrentThread:YES]] block:^{
        [self execuWithVC:self.frameVC];
    }];
}
- (void)testFrameVC_Time {
    [self measureBlock:^{
        [self execuWithVC:self.frameVC];
    }];
}

- (void)testAutoLVC_CPU {
    [self measureWithMetrics:@[[[XCTCPUMetric alloc] initLimitingToCurrentThread:YES]] block:^{
        [self execuWithVC:self.autLaVC];
    }];
}
- (void)testAutoLVC_Time {
    [self measureBlock:^{
        [self execuWithVC:self.autLaVC];
    }];
}

- (void)testStackVC_CPU {
    [self measureWithMetrics:@[[[XCTCPUMetric alloc] initLimitingToCurrentThread:YES]] block:^{
        [self execuWithVC:self.stackVC];
    }];
}
- (void)testStackVC_Time {
    [self measureBlock:^{
        [self execuWithVC:self.stackVC];
    }];
}

- (void)execuWithVC:(UIViewController *)vc
{
    for (NSInteger i = 0; i < 5; ++i) {
        for (NSInteger i = 0; i < 10; ++i) {
            [vc performSelector:@selector(appendOne)];
        }
        for (NSInteger i = 0; i < 10; ++i) {
            [vc performSelector:@selector(removeLast)];
        }
    }
}


@end
