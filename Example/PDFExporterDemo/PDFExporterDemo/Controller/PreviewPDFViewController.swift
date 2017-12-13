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

    @IBOutlet weak var webView: WKWebView!

    private weak var pdfRenderer: PDFPrintPageRenderer!
    private var pdfData: Data?

    init(pdfRenderer: PDFPrintPageRenderer, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.pdfRenderer = pdfRenderer
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.pdfData = self?.generatePDFData()
            DispatchQueue.main.async {
                if let url = NSURL().absoluteURL, let pdfData = self?.pdfData {
                    self?.webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "UTF-8",
                                       baseURL: url)
                }
            }
        }
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

    private func generatePDFData() -> Data {
        let pdfData = pdfRenderer.drawPagesToPDFData()
        if let pdfURL = Utils.getPdfFileUrl() {
            do {
                try pdfData.write(to: pdfURL)
            } catch {}
        }
        return pdfData
    }
}