//
//  CSAPIBasicTaskTests.m
//  CSAPIBasicTaskTests
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccessToken.h"

@interface CSAPIBasicTaskTests : XCTestCase

@end

@implementation CSAPIBasicTaskTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    AccessToken *token = [AccessToken sharedToken];
    [token generateNewTokenWithCompletion:^(NSString * _Nonnull token) {
        XCTAssertEqual(token, [])
    }];
    [[token token] isEqualToString:@"token"];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
