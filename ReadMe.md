# PDFExporter

The framework aims to provide an **easy way** to render a custom UIView into pdf format **without the need to be aware** of the original view's implementation.

With the ability to **easily scale** the size of the view to be rendered and **adjust the font size proportionally** if configured so, the framework will provide "**on the shelf**" solution to **generate** .pdf file directly from the device at **high quality** level. If you preview the .pdf file and zoom in, the text, backgrounds, borders and (vectorial) images have the same quality as the actual size.

PDFExporter is supported for iOS 8.0 and later.

## Installation

Link your application against the framework. Add the framework to the list of 'Embedded Binaries' from the project's General tab.

## Usage

Basic usage is to configure renderer and ask him to perform the drawing. Once the renderer has d

**Objective-C**

```objective-c
@import PDFExporter; // import the library

PDFPrintPageRenderer *PDFRenderer = [PDFPrintPageRenderer new]; // create an instance
PDFRenderer.paperInsets = UIEdgeInsetsMake(30.f, 30.f, 30.f, 30.f); // modify content margins if you want to
PDFRenderer.paperSize = PDFPaperSizeUSLetter; // modify paper size if you want to
PDFRenderer.contentView = [UIView new]; // add the view to be drawn as content
PDFRenderer.footerView = [UIView new]; // optionally set a footer view
PDFRenderer.headerView = [UIView new]; // optionally set a header view

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
let PDFData: NSData = PDFRenderer.drawPagesToPDFData() // let the framework to  create the PDF data
```

For more paper sizes , see [PDFPaperSize header](Framework/PDFExporter/PDFExporter/PDFRender/PDFPaperSizes.h). 

## Important notes

Images need to be used in Asset Catalog as vector .pdf files. Apple provides support for vectorial images starting with Xcode 6 and iOS 7. Regular images are drawn at their actual size. At a high zoom level, the images look pixelated.

## License

PDFExporter is released under MIT license. See [LICENSE](LICENSE) for details.  

## About this project

![3Pillar Global] (http://www.3pillarglobal.com/wp-content/themes/base/library/images/logo_3pg.png)

**PDFExporter** is developed and maintained by [3Pillar Global](http://www.3pillarglobal.com/).

