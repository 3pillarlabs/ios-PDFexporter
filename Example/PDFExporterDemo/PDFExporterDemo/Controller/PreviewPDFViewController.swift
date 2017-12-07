//
//  PreviewPDFViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import WebKit

class PreviewPDFViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    private var pdfData: Data!

    init(pdfData: Data, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.pdfData = pdfData
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = NSURL().absoluteURL {
            webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "UTF-8", baseURL: url)
        }
    }
}
