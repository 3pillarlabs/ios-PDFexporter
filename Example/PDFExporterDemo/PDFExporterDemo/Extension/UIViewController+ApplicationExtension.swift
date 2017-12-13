//
//  UIViewController+ApplicationExtension.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 08/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit

protocol PDFControllerProtocol {
    var contentView: UIView { get }
}

extension UIViewController {
    func addChild(viewController: UIViewController, within subview: UIView? = nil) {
        let container: UIView = subview ?? view
        addChildViewController(viewController)
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }

    func removeAsChild() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
