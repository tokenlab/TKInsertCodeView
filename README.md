# TKInsertCodeView
[![CI Status](http://img.shields.io/travis/tokenlab/TKInsertCodeView.svg?style=flat)](https://travis-ci.org/tokenlab/TKInsertCodeView)
![](https://camo.githubusercontent.com/f0604df64b4db3dad5b2a23439b9c253abedeae3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d332e302d6f72616e67652e737667)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)

TKInsertCodeView is a practical and customizable code insert UIView.

## Example

To run the example project, clone the repo and open `TKInsertCodeView.xcodeproj`

<img src="https://raw.githubusercontent.com/tokenlab/TKInsertCodeView/master/Screenshots/Example.gif" width="320" height="whatever">

## Requirements

* Swift 3
* iOS 9.0 or higher

## Installation

### CocoaPods

TKInsertCodeView is available through Tokenlab's TKPodSpec. To install it, simply add the following lines to your Podfile:

```ruby
pod 'TKInsertCodeView', :git => 'https://github.com/tokenlab/TKInsertCodeView.git'
```

### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'tokenlab/TKInsertCodeView'
```

## Customization

### IBInspectable

You may easily customize through Interface Builder:

|Property|Type|Default value|Description|
|---|---|---|---|
|`numberOfFields`|`Int`| 4| Number of code fields|
|`spacing`| `CGFloat`|10| Space between code fields|
|`cornerRadius`| `CGFloat`|7.0| Code field border|
|`borderWidth`| `CGFloat`|10| Code field border width|
|`borderColor`| `UIColor`|#CBCBCB (gray)| Code field border color|
|`backgroundColorField`| `UIColor`|#F1F1F1 (gray)| Code field background color|
|`selecBorderColor`| `CGFloat`|#007AFF (blue)| Selected code field border color|
|`selecBackgroundColorField`| `UIColor`|#F1F1F1 (gray)| Selected code field background color|
|`invalidBorderColor`| `CGFloat`|#007AFF (blue)| Invalid code field border color|
|`invalidBackgroundColorField`| `UIColor`|#F1F1F1 (gray)| Invalid code field background color|

### Customize CodeFieldView

Or if you want to, you can implement `TKCodeFieldViewProtocol` and use your own `UIView` for code fields:

```swift
protocol TKCodeFieldViewProtocol: class {
    var code: String? {get set}
    func setSelected(_ selected: Bool)
}
```

To apply your customized view:

```swift
insertCodeView.codeFieldView = CustomCodeFieldView.init
```

## Functions

To clear code or insert :
```swift
insertCodeView.code = ""
```

To shake view:
```swift
insertCodeView.shake()
```

To present invalidate layout:
```swift
insertCodeView.invalidate()
```

To display normal layout:
```swift
insertCodeView.validate()
```

To programmatically keyboard up:
```swift
insertCodeView.setBecomeFirstResponder()
```

To programmatically keyboard down:
```swift
insertCodeView.setResignFirstResponder()
```

## TKInsertCodeViewDelegate

There are two optional functions.

When a code field was changed, this one is called:

```swift
func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didChangeCode code: String)
```

When all code fields were fully:
```swift
func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didFinishWritingCode code: String)
```

## Authors

[damboscolo](https://github.com/damboscolo), danielehidalgo@gmail.com

[leosampaio](https://github.com/leosampaio), leo.sampaio.ferraz.ribeiro@gmail.com

## License

TKInsertCodeView is available under the MIT license. See the LICENSE file for more info.
