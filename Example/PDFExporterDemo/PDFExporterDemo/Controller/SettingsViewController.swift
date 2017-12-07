//
//  SettingsViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewController(settingsVC: SettingsViewController, didChange paperSize: CGSize?)
    func settingsViewController(settingsVC: SettingsViewController, didChange paperInsets: UIEdgeInsets?)
}

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: SettingsViewControllerDelegate?

    var contentPaperInsets: UIEdgeInsets?
    var paperSize: CGSize?

    private var paperTypes = [String]()

    @IBOutlet weak var paperTypePickerView: UIPickerView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - UITextFieldDelegate

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        var edgeInsets = contentPaperInsets
        if textField == topTextField {
            edgeInsets?.top = CGFloat(Float(text) ?? 0.0)
        } else if textField == bottomTextField {
            edgeInsets?.bottom = CGFloat(Float(text) ?? 0.0)
        } else if textField == leftTextField {
            edgeInsets?.left = CGFloat(Float(text) ?? 0.0)
        } else if textField == rightTextField {
            edgeInsets?.right = CGFloat(Float(text) ?? 0.0)
        }
        delegate?.settingsViewController(settingsVC: self, didChange: contentPaperInsets)
    }

    // MARK: - Actions

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paperTypes.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paperTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < paperTypes.count else { return }
        delegate?.settingsViewController(settingsVC: self, didChange: CGSize.zero)
    }
}
