//
//  PreviewPDFViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import WebKit
import PDFExporter

class PreviewPDFViewController: UIViewController {

    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private weak var pdfRenderer: PDFPrintPageRenderer!
    private var webView: WKWebView!

    init(pdfRenderer: PDFPrintPageRenderer, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.pdfRenderer = pdfRenderer
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: webViewContainer.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webViewContainer.addSubview(webView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        let pdfData = generatePDFData()
        if let url = pdfData.1 {
            webView.loadFileURL(url, allowingReadAccessTo: url)
            print(url)
        }
        activityIndicator.stopAnimating()
    }

    // MARK: - Actions

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        if let fileURL = Utils.getPdfFileUrl() {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }

    private func generatePDFData() -> (Data, URL?) {
        let pdfData = pdfRenderer.drawPagesToPDFData()
        if let pdfURL = Utils.getPdfFileUrl() {
            do {
                try pdfData.write(to: pdfURL)
                return (pdfData, pdfURL)
            } catch {}
        }
        return (pdfData, nil)
    }
}
