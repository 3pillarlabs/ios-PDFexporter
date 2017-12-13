//
//  TextEditViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 13/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit

class TextEditViewController: UIViewController, PDFControllerProtocol {
    var contentView: UIView {
        return textView
    }

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let keyboardFrameValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        textView.contentInset = contentInsets
        textView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide() {
        textView.contentInset = UIEdgeInsets.zero
    }
}
