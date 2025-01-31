import UIKit

// MARK: - Fabric Integration Types

typealias ComponentDescriptorProvider = () -> Void
func concreteComponentDescriptorProvider<T>(_: T.Type) -> ComponentDescriptorProvider {
  return {}
}

protocol ComponentViewProtocol {}

struct NativeColorViewProps {
  var color: String = ""
}

final class NativeColorViewComponentDescriptor {}

// MARK: - ColorView

final class ColorView: UIView, ComponentViewProtocol {
  private let contentView: UIView
  private var props: NativeColorViewProps

  override init(frame: CGRect) {
    contentView = UIView()
    props = NativeColorViewProps() // default props
    super.init(frame: frame)
    addSubview(contentView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateProps(newProps: NativeColorViewProps, oldProps: NativeColorViewProps) {
    if oldProps.color != newProps.color,
       let newColor = hexStringToColor(newProps.color)
    {
      contentView.backgroundColor = newColor
    }
    props = newProps
  }

  @objc
  func updatePropsWithNewColor(_ newColor: NSString, oldColor: NSString) {
    let newProps = NativeColorViewProps(color: newColor as String)
    let oldProps = NativeColorViewProps(color: oldColor as String)
    updateProps(newProps: newProps, oldProps: oldProps)
  }

  static func componentDescriptorProvider() -> ComponentDescriptorProvider {
    return concreteComponentDescriptorProvider(NativeColorViewComponentDescriptor.self)
  }

//  static var FabricDeclarativeViewCls: RCTComponentViewProtocol.Type {
//    return ColorView.self
//  }

  private func hexStringToColor(_ stringToConvert: String) -> UIColor? {
    let noHashString = stringToConvert.replacingOccurrences(of: "#", with: "")
    guard let hex = Int(noHashString, radix: 16) else { return nil }
    let r = CGFloat((hex >> 16) & 0xFF) / 255.0
    let g = CGFloat((hex >> 8) & 0xFF) / 255.0
    let b = CGFloat(hex & 0xFF) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
}
