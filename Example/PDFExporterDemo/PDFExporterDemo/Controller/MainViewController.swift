//
//  MainViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import PDFExporter

class MainViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!

    private let pdfRenderer: PDFPrintPageRenderer = PDFPrintPageRenderer()

    override func viewDidLoad() {
        super.viewDidLoad()

        pdfRenderer.contentView = contentView
//        pdfRenderer.headerView = HeaderView.instanceFromNib()
//        pdfRenderer.footerView = FooterView.instanceFromNib()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let settingsController = navigationController.viewControllers.first as? SettingsViewController
            else { return }
        settingsController.contentPaperInsets = pdfRenderer.paperInset
        settingsController.paperSize = pdfRenderer.paperSize
        settingsController.delegate = self
    }

    @IBAction func previewButtonPressed(_ sender: UIButton) {
        let previewPdfVC = PreviewPDFViewController(pdfData: generatePDFData())
        present(previewPdfVC, animated: true)
    }

    // MARK: - Private

    private func generatePDFData() -> Data {
        let pdfData = pdfRenderer.drawPagesToPDFData()
        if let pdfURL = Utils.getDocumentsDirectory()?.appendingPathComponent(Constants.pdfDefaultName) {
            do {
                try pdfData.write(to: pdfURL)
            } catch {}
        }
        return pdfData
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func settingsViewController(settingsVC: SettingsViewController, didChange paperSize: CGSize?) {
        guard let paperSize = paperSize else { return }

        pdfRenderer.paperSize = paperSize
    }

    func settingsViewController(settingsVC: SettingsViewController, didChange paperInsets: UIEdgeInsets?) {
        guard let paperInsets = paperInsets else { return }

        pdfRenderer.paperInset = paperInsets
    }
}

