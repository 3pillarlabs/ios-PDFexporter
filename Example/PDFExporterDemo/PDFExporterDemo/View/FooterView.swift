//
//  FooterView.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import PDFExporter

class FooterView: UIView, PDFHeaderFooterPaging {
    @IBOutlet weak var pageLabel: UILabel!

    class func instanceFromNib() -> FooterView? {
        guard let footerView =  UINib(nibName: "FooterView",
                                      bundle: nil).instantiate(withOwner: nil, options: nil).first as? FooterView
            else { return nil }
        return footerView
    }

    func updatePageNumber(_ pageNumber: UInt, totalPages: UInt) {
         pageLabel.text = "\(pageNumber)/\(totalPages)"
    }
}
