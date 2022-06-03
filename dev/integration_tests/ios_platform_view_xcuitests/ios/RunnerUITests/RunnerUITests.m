//
//  RunnerUITests.m
//  RunnerUITests
//
//  Created by Huan Lin on 6/3/22.
//

@import XCTest;

@interface XCUIElement(KeyboardFocus)
@property (nonatomic, readonly) BOOL flt_hasKeyboardFocus;
@end

@implementation XCUIElement(KeyboardFocus)
- (BOOL)flt_hasKeyboardFocus {
  return [[self valueForKey:@"hasKeyboardFocus"] boolValue];
}
@end

@interface RunnerUITests : XCTestCase

@end

@implementation RunnerUITests

- (void)setUp {
  self.continueAfterFailure = NO;
}

- (void)testPlatformViewFocus {
  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app launch];

  XCUIElement *platformView = app.textFields[@"platform_view[0]"];
  XCTAssertTrue([platformView waitForExistenceWithTimeout:1]);
  XCUIElement *flutterTextField = app.textFields[@"Flutter Text Field"];
  XCTAssertTrue([flutterTextField waitForExistenceWithTimeout:1]);


  [flutterTextField tap];
  XCTAssertTrue([app.windows.element waitForExistenceWithTimeout:1]);
  XCTAssertFalse(platformView.flt_hasKeyboardFocus);
  XCTAssertTrue(flutterTextField.flt_hasKeyboardFocus);

  // Tapping on platformView should unfocus the previously focused flutterTextField
  [platformView tap];
  XCTAssertTrue(platformView.flt_hasKeyboardFocus);
  XCTAssertFalse(flutterTextField.flt_hasKeyboardFocus);

}

@end

