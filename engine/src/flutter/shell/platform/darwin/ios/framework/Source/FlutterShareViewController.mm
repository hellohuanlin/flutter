#import "flutter/shell/platform/darwin/ios/framework/Headers/FlutterShareViewController.h"

#import "flutter/shell/platform/darwin/ios/flutter_framework_swift.h"

@interface FlutterShareViewController ()
@property(nonatomic, strong) MyShareExtensionDismissControlRecognizer* recognizer;
@end

@implementation FlutterShareViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.recognizer = [[MyShareExtensionDismissControlRecognizer alloc] init];
  [self.view addGestureRecognizer:self.recognizer];

  self.flutterViewController = [[FlutterViewController alloc] initWithProject:nil
                                                                      nibName:nil
                                                                       bundle:nil];
  [self addChildViewController:self.flutterViewController];
  [self.view addSubview:self.flutterViewController.view];
  self.flutterViewController.view.frame = self.view.bounds;
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  NSError* error = [NSError errorWithDomain:NSBundle.mainBundle.bundleIdentifier
                                       code:0
                                   userInfo:nil];
  [self.extensionContext cancelRequestWithError:error];
}

- (FlutterShareViewControllerSwipeDismissStrategy)strategy {
  switch (self.recognizer.strategy) {
    case MyShareExtensionDismissControlRecognizerDismissStrategyFullSheet:
      return FlutterShareViewControllerSwipeDismissStrategyFullSheet;
    case MyShareExtensionDismissControlRecognizerDismissStrategyProhibited:
      return FlutterShareViewControllerSwipeDismissStrategyProhibited;
    case MyShareExtensionDismissControlRecognizerDismissStrategyTopRegion:
      return FlutterShareViewControllerSwipeDismissStrategyTopRegion;
  }
  return FlutterShareViewControllerSwipeDismissStrategyFullSheet;
}

- (void)setStrategy:(FlutterShareViewControllerSwipeDismissStrategy)strategy {
  MyShareExtensionDismissControlRecognizerDismissStrategy recognizerStrategy;
  switch (strategy) {
    case FlutterShareViewControllerSwipeDismissStrategyFullSheet:
      recognizerStrategy = MyShareExtensionDismissControlRecognizerDismissStrategyFullSheet;
      break;
    case FlutterShareViewControllerSwipeDismissStrategyProhibited:
      recognizerStrategy = MyShareExtensionDismissControlRecognizerDismissStrategyProhibited;
      break;
    case FlutterShareViewControllerSwipeDismissStrategyTopRegion:
      recognizerStrategy = MyShareExtensionDismissControlRecognizerDismissStrategyTopRegion;
      break;
  }

  self.recognizer.strategy = recognizerStrategy;
}

@end
