
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-Compatible-4BC51D.svg?style=flat)](https://github.com/CocoaPods/CocoaPods) 
[![Swift 4.0](https://img.shields.io/badge/Swift-Compatible-orange.svg)](https://swift.org)

## Demo App Installation

In order to successfully build the application please follow the next steps:

- open Terminal
- navigate to Demo project folder (Example/PDFExporterDemo)
- run ``` carthage update ```



## PDFExporter 2

What's New:

- Paging for footer or header;
- Ability to choose between scaled content or the one which is provided;
- Ability to choose to slice views or not;
- More options to customize drawing, layout to not slice views or preserve state of views;
- Support for UITableView;
- Bug fixes
- New Demo app implemented in Swift 4 ([demo branch](https://github.com/3pillarlabs/ios-PDFexporter/tree/feature/PDFExporter-Swift-Demo-v2.0))

## Description

The framework aims to provide an **easy way** to render a custom UIView into pdf format **without the need to be aware** of the original view's implementation.

With the ability to **easily scale** the size of the view to be rendered and **adjust the font size proportionally** if configured so, the framework will provide an "**on the shelf**" solution to **generate** .pdf file directly from the device at **high quality** level. If you preview the .pdf file and zoom in, the text, backgrounds, borders and (vectorial) images have the same quality as the actual size.

PDFExporter is available in iOS 9.0 and later.

![Swipe animation](https://media.giphy.com/media/xT0xeGCfGMpouK2dGg/giphy.gif)

## Table of contents

- [Usage](https://github.com/3pillarlabs/ios-PDFexporter#usage)
- [Installation](https://github.com/3pillarlabs/ios-PDFexporter#Installation)
	- [CocoaPods](https://github.com/3pillarlabs/ios-PDFexporter#CocoaPods)
	- [Carthage](https://github.com/3pillarlabs/ios-PDFexporter#Carthage)
- [Important Notes](https://github.com/3pillarlabs/ios-PDFexporter#Important-Notes)
- [License](https://github.com/3pillarlabs/ios-PDFexporter#License)
- [About](https://github.com/3pillarlabs/ios-PDFexporter#About-this-project)

## Usage

Basic usage is to configure renderer and ask him to perform the drawing.

**Objective-C**

```objective-c
@import PDFExporter; // import the library

PDFPrintPageRenderer *PDFRenderer = [PDFPrintPageRenderer new]; // create an instance
PDFRenderer.paperInsets = UIEdgeInsetsMake(30.f, 30.f, 30.f, 30.f); // modify content margins if you want to
PDFRenderer.paperSize = PDFPaperSizeUSLetter; // modify paper size if you want to
PDFRenderer.contentView = [UIView new]; // add the view to be drawn as content
PDFRenderer.footerView = [UIView new]; // optionally set a footer view
PDFRenderer.headerView = [UIView new]; // optionally set a header view
PDFRenderer.scaleContent = YES; // set it YES if you want to scale content view to fit the width of page
PDFRenderer.sliceViews = YES; // set it YES if you want you want to slice content view's subviews

NSData *PDFData = [self.PDFRenderer drawPagesToPDFData]; // let the framework to  create the PDF data
```

**Swift**

```swift
import PDFExporter
let PDFRenderer: PDFPrintPageRenderer = PDFPrintPageRenderer() // create an instance
PDFRenderer.paperInsets = UIEdgeInsetsMake(30.f, 30.f, 30.f, 30.f) // modify content margins if you want to
PDFRenderer.paperSize = PDFPaperSizeUSLetter // modify paper size if you want to
PDFRenderer.contentView = UIView() // add the view to be drawn as content
PDFRenderer.footerView = UIView() // optionally set a footer view
PDFRenderer.headerView = UIView() // optionally set a header view
PDFRenderer.scaleContent = true // set it 'true' if you want to scale content view to fit the width of page
PDFRenderer.sliceViews = true // set it 'true' if you want you want to slice content view's subviews

let PDFData: NSData = PDFRenderer.drawPagesToPDFData() // let the framework to  create the PDF data
```

For more paper sizes , see [PDFPaperSize header](PDFExporter/PDFRender/PDFPaperSizes.h). 

## Installation


Available in iOS 9.0 and later. 

### CocoaPods

- Run Terminal

- Navigate to project folder

- Use command:

```
pod init
```

- Add code to podfile

```
platform :ios, '9.0'

target 'YourProjectName' do
  use_frameworks!
    pod 'PDFExporter'
end
```

- Run command:

```
pod install
```

Remember to open project using workspace

### Carthage

- Run Terminal

- Navigate to project folder

- Use command in terminal:
```
touch cartfile
```

- Add code to Cartfile:

```
github "3pillarlabs/ios-PDFexporter.git"

```

- Run carthage by using command:

```
carthage update
```
- In order to link your app with the framework, you have to add the PDFExporter in 'Embedded Binaries' list from 'General' section on application's target from Carthage/Build/iOS in project folder.


## Important notes

- Images need to be used in Asset Catalog as vector .pdf files (Apple provides support for vectorial images starting with Xcode 6 and iOS 7)
- Regular images are drawn at their actual size. At a high zoom level, the images look pixelated.
- Drawing is supported only on main thread.

Also if you feel the need for a small demo please check the [demo project](https://github.com/3pillarlabs/ios-PDFexporter/tree/feature/PDFExporter-Swift-Demo-v2.0) branch.


## License

PDFExporter is released under MIT license. See [LICENSE](LICENSE) for details.  

## About this project

[![3Pillar Global](https://www.3pillarglobal.com/wp-content/themes/base/library/images/logo_3pg.png)](http://www.3pillarglobal.com/)

**PDFExporter** is developed and maintained by [3Pillar Global](http://www.3pillarglobal.com/).
