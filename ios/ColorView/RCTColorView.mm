#import "RCTColorView.h"

#import <react/renderer/components/AppSpec/ComponentDescriptors.h>
#import <react/renderer/components/AppSpec/EventEmitters.h>
#import <react/renderer/components/AppSpec/Props.h>
#import <react/renderer/components/AppSpec/RCTComponentViewHelpers.h>

// #import "RCTFabricComponentsPlugins.h"
#import "FabricComponentExample-Swift.h"

using namespace facebook::react;

@interface RCTColorView () <RCTComponentViewProtocol>

@end

@implementation RCTColorView {
    ColorView * _view;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<NativeColorViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const NativeColorViewProps>();
    _props = defaultProps;

    _view = [ColorView new];

    self.contentView = _view;
  }

  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<NativeColorViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<NativeColorViewProps const>(props);

    // Convert the C++ string prop to NSString.
    NSString *newColor = [NSString stringWithUTF8String:newViewProps.color.c_str()];
    NSString *oldColor = [NSString stringWithUTF8String:oldViewProps.color.c_str()];
    
    [_view updatePropsWithNewColor:newColor oldColor:oldColor];

    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> FabricDeclarativeViewCls(void)
{
    return RCTColorView.class;
}

- hexStringToColor:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *stringScanner = [NSScanner scannerWithString:noHashString];

    unsigned hex;
    if (![stringScanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

@end
