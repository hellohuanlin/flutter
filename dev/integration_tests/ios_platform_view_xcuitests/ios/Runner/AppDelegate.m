// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@interface TextFieldPlatformView: NSObject<FlutterPlatformView>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation TextFieldPlatformView
- (instancetype)init {
  if ((self = [super init])) {
    _textField = [[UITextField alloc] init];
    _textField.text = @"Platform Text Field";
    _textField.backgroundColor = UIColor.blueColor;
  }
  return self;
}

- (UIView *)view {
  return self.textField;
}
@end

@interface TextFieldPlatformViewFactory: NSObject<FlutterPlatformViewFactory>
@end
@implementation TextFieldPlatformViewFactory
- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args {
  return [[TextFieldPlatformView alloc] init];
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  [[self registrarForPlugin:@"flutter"] registerViewFactory:[[TextFieldPlatformViewFactory alloc] init] withId:@"text_field"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
