# TKInsertCodeView
[![CI Status](http://img.shields.io/travis/tokenlab/TKInsertCodeView.svg?style=flat)](https://travis-ci.org/tokenlab/TKInsertCodeView)
![](https://camo.githubusercontent.com/f0604df64b4db3dad5b2a23439b9c253abedeae3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d332e302d6f72616e67652e737667)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)

TKInsertCodeView is a practical and customizable code insert UIView.

## Example

To run the example project, clone the repo and open `TKInsertCodeView.xcodeproj`

## Requirements

* Swift 3
* iOS 9.0 or higher

## Installation

### CocoaPods

TKInsertCodeView is available through Tokenlab's TKPodSpec. To install it, simply add the following lines to your Podfile:

```ruby
pod 'TKInsertCodeView', :git => 'https://github.com/tokenlab/TKPodSpecs.git'
```

### Carthage
Simply add the following lines to your Cartfile:

```ruby
github 'tokenlab/TKInsertCodeView'
```

## Customizations

### IBInspectables

You may easily customize through Interface Builder:

|Var|Type|Default value|Description|
|---|---|---|---|
|`secretCode`| `Bool`|false| Hide/show inserted code|
|`numberOfFields`|`Int`| 4| Number of code fields|
|`spacing`| `CGFloat`|10| Space between code fields|
|`cornerRadius`| `CGFloat`|7.0| Code field border|
|`borderWidth`| `CGFloat`|10| Code field border width|
|`fontName`| `String`|Helvetica| Code font|
|`fontSize`| `CGFloat`|17| Code font size|
|`textColor`| `UIColor`|#686868 (gray)| Code text color|
|`backgroundFieldColor`| `UIColor`|#F1F1F1 (gray)| Code field background color|
|`borderColor`| `UIColor`|#CBCBCB (gray)| Code field border color|
|`selecBackgroundColorField`| `UIColor`|#F1F1F1 (gray)| Selected code field background color|
|`selecBorderColor`| `CGFloat`|#007AFF (blue)| Selected code field border color|

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

## Keyboard

* To programmatically keyboard up:
```swift
insertCodeView.setBecomeFirstResponder()
```

* To programmatically keyboard down:
```swift
insertCodeView.setResignFirstResponder()
```
