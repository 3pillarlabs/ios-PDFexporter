//
//  GraphsViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 08/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import PDFExporter

class GraphScrollView: UIScrollView {
    override func canDrawSubview(_ subview: UIView, intersection: CGRect) -> Bool {
        return CGFloatIsEqual(subview.frame.height, intersection.height)
    }
}

class GraphsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
