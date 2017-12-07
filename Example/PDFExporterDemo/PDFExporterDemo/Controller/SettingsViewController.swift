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

    private var paperTypes: [PaperType] = Utils.allPaperTypes()

    @IBOutlet weak var paperTypePickerView: UIPickerView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupTextFieldValues()
        setupPickerView()
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
        contentPaperInsets = edgeInsets
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
        return paperTypes[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < paperTypes.count else { return }
        delegate?.settingsViewController(settingsVC: self, didChange: paperTypes[row].size)
    }

    // MARK: - Private

    private func setupTextFieldValues() {
        topTextField.text = String(format: "%.2f", contentPaperInsets?.top ?? 0.0)
        bottomTextField.text = String(format: "%.2f", contentPaperInsets?.bottom ?? 0.0)
        leftTextField.text = String(format: "%.2f", contentPaperInsets?.left ?? 0.0)
        rightTextField.text = String(format: "%.2f", contentPaperInsets?.right ?? 0.0)
    }

    private func setupPickerView() {
        // set picker to current row
        paperTypePickerView.delegate = self
        paperTypePickerView.dataSource = self

        if let paperSize = paperSize,
            let currentPaperTypeIndex = paperTypes.index(where: {$0.size.equalTo(paperSize)}) {
            paperTypePickerView.selectRow(currentPaperTypeIndex, inComponent: 0, animated: false)
        }
    }
}
