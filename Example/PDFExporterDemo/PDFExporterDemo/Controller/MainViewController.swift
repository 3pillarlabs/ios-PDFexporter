//
//  MainViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import PDFExporter

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!

    private let pdfRenderer: PDFPrintPageRenderer = PDFPrintPageRenderer()

    var currentViewController: UIViewController?

    lazy var graphsVC: UIViewController? = {
        let graphsVC =
            UIStoryboard.main.instantiateViewController(withIdentifier: "GraphsViewController") as? GraphsViewController
        return graphsVC
    }()

    lazy var tableVC: UIViewController? = {
        let tableVC =
            UIStoryboard.main.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
        return tableVC
    }()

    lazy var elementsVC: UIViewController? = {
        let elementsVC =
            UIStoryboard.main.instantiateViewController(withIdentifier: "UIElementsViewController")
                as? UIElementsViewController
        return elementsVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        displayCurrentTab(0)

        pdfRenderer.contentView = contentView
        pdfRenderer.headerView = HeaderView.instanceFromNib()
        pdfRenderer.footerView = FooterView.instanceFromNib()
        pdfRenderer.pagingMask = .footer
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
        updateFooterWidth()
        updateHeaderWidth()
        let previewPdfVC = PreviewPDFViewController(pdfData: generatePDFData())
        present(previewPdfVC, animated: true)
    }

    @IBAction func tabSwitched(_ sender: UISegmentedControl) {
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParentViewController()

        displayCurrentTab(sender.selectedSegmentIndex)
    }


    // MARK: - Private

    private func generatePDFData() -> Data {
        let pdfData = pdfRenderer.drawPagesToPDFData()
        if let pdfURL = Utils.getPdfFileUrl() {
            do {
                try pdfData.write(to: pdfURL)
            } catch {}
        }
        return pdfData
    }

    private func displayCurrentTab(_ tabIndex: Int) {
        if let viewController = viewControllerForSelectedSegmentIndex(tabIndex) {
            addChild(viewController: viewController, within: contentView)
            currentViewController = viewController
            pdfRenderer.contentView = viewController.view
            pdfRenderer.shouldSliceViews = currentViewController is GraphsViewController
        }
    }

    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        switch index {
        case 0:
            return graphsVC
        case 1:
            return tableVC
        case 2:
            return elementsVC
        default:
            return nil
        }
    }

    private func updateFooterWidth() {
        guard var frame = pdfRenderer.footerView?.frame else { return }

        frame.size.width = pdfRenderer.footerRect.width
        pdfRenderer.footerView?.frame = frame
    }

    private func updateHeaderWidth() {
        guard var frame = pdfRenderer.headerView?.frame else { return }

        frame.size.width = pdfRenderer.headerRect.width
        pdfRenderer.headerView?.frame = frame
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

