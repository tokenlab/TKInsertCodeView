# TKInsertCodeView
[![CI Status](http://img.shields.io/travis/tokenlab/TKInsertCodeView.svg?style=flat)](https://travis-ci.org/tokenlab/TKInsertCodeView)
![](https://camo.githubusercontent.com/f0604df64b4db3dad5b2a23439b9c253abedeae3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d332e302d6f72616e67652e737667)
[![Version](https://img.shields.io/cocoapods/v/SwiftToast.svg?style=flat)](http://cocoapods.org/pods/SwiftToast)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TKInsertCodeView is a practical and customizable code insert UIView.

## Customization

## IBInspectables
|Var|Type|Default value|Description|
|---|---|---|---|
|`secretCode`| `Bool`|false| Hide/show inserted code|
|`numberOfFields`|`Int`| 4| Number of code fields|
|`spacing`| `CGFloat`|10| Space between code fields|
|`borderWidth`| `CGFloat`|10| Code field border width|
|`borderColor`| `UIColor`|.lightGray| Code field border color|
|`selectedBorderColor`| `CGFloat`|blue| Selected code field border color|
|`cornerRadius`| `CGFloat`|7.0| Code field border|

### Custom Code Field View

If you wan to, you can implement `TKCodeFieldViewProtocol` and use your own `UIView` for code fields.

```swift
protocol TKCodeFieldViewProtocol: class {
    var code: String? {get set}
    func setSelected(_ selected: Bool)
}
```

### To keyboard up

```swift
inserCodeView.setFirstResponder()
```
