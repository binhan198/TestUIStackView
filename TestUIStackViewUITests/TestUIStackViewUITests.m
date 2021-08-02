//
//  TestUIStackViewUITests.m
//  TestUIStackViewUITests
//
//  Created by 周彬涵 on 2020/3/24.
//  Copyright © 2020 周彬涵. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestUIStackViewUITests : XCTestCase

@end

@implementation TestUIStackViewUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

//- (void)testExample {
//    // UI tests must launch the application that they test.
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app launch];
//
//    // Use recording to get started writing UI tests.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}

- (void)testCPUAndTime {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    [app.buttons[@"使用AutoLayout"] tap];
//[self measureWithMetrics:@[[XCTCPUMetric new]] block:^{
    [app.navigationBars[@"ViewControllerAutoLayout"].buttons[@"Back"] tap];
//}];
//    [app.navigationBars[@"ViewControllerAutoLayout"].buttons[@"Back"] tap];

    
    
     
}

@end
