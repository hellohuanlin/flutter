import UIKit

@objc public enum MyShareExtensionDismissControlRecognizerDismissStrategy: Int {
  case topRegion
  case prohibited
  case fullSheet
}

@objc public final class MyShareExtensionDismissControlRecognizer: UIGestureRecognizer {

  @objc public var strategy: MyShareExtensionDismissControlRecognizerDismissStrategy = .fullSheet

  private var beganLocation: CGPoint = .zero
  private var dismissRecognizer: UIGestureRecognizer? = nil

  public init() {
    super.init(target: nil, action: nil)
    delegate = self
  }

  private func setDismissRecognizerEnabled(location: CGPoint) {
    dismissRecognizer?.isEnabled = location.y <= 50
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    guard let touch = touches.first else { return }
    beganLocation = touch.location(in: view)
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .failed
  }

  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .cancelled
  }
}

extension MyShareExtensionDismissControlRecognizer: UIGestureRecognizerDelegate {

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {

    if (dismissRecognizer == nil && otherGestureRecognizer.isBackgroundDismissRecognizer) {
      dismissRecognizer = otherGestureRecognizer

      switch strategy {
      case .topRegion:
        setDismissRecognizerEnabled(location: beganLocation)
      case .prohibited:
        dismissRecognizer?.isEnabled = false
      case .fullSheet:
        break
      }
    }
    return false
  }

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    switch strategy {
    case .topRegion:
      setDismissRecognizerEnabled(location: touch.location(in: touch.view))
    case .prohibited:
      break
    case .fullSheet:
      break
    }
    return true
  }
}

fileprivate extension UIGestureRecognizer {
  var isBackgroundDismissRecognizer: Bool {
    return name?.hasSuffix("UISheetInteractionBackgroundDismissRecognizer") ?? false
  }
}
