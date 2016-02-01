# PDFExporter

The framework aims to provide an **easy way** to render a custom UIView into pdf format **without the need to be aware** of the original view's implementation.

With the ability to **easily scale** the size of the view to be rendered and **adjust the font size proportionally** if configured so, the framework will provide an "**on the shelf**" solution to **generate** .pdf file directly from the device at **high quality** level. If you preview the .pdf file and zoom in, the text, backgrounds, borders and (vectorial) images have the same quality as the actual size.

PDFExporter is available in iOS 8.0 and later.

## Installation

Add framework as a subproject in your working project. Link your application against the framework. Add the framework to the list of 'Embedded Binaries' from the project's General tab.

## PDFExporter 2

What's New:

- Paging for footer or header;
- Ability to choose between scaled content or the one which is provided;
- Ability to choose to slice views or not;
- More options to customize drawing, layout to not slice views or preserve state of views;
- Support for UITableView;

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

For more paper sizes , see [PDFPaperSize header](Framework/PDFExporter/PDFExporter/PDFRender/PDFPaperSizes.h). 

## Important notes

Images need to be used in Asset Catalog as vector .pdf files. Apple provides support for vectorial images starting with Xcode 6 and iOS 7. Regular images are drawn at their actual size. At a high zoom level, the images look pixelated.

## License

PDFExporter is released under MIT license. See [LICENSE](LICENSE) for details.  

## About this project

![3Pillar Global] (http://www.3pillarglobal.com/wp-content/themes/base/library/images/logo_3pg.png)

**PDFExporter** is developed and maintained by [3Pillar Global](http://www.3pillarglobal.com/).

