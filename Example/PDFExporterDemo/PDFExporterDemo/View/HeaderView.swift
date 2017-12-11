//
//  HeaderView.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit
import PDFExporter

class HeaderView: UIView, PDFHeaderFooterPaging {
    class func instanceFromNib() -> HeaderView? {
        guard let headerView =  UINib(nibName: "HeaderView",
                                      bundle: nil).instantiate(withOwner: nil, options: nil).first as? HeaderView
            else { return nil }
        return headerView
    }

    func updatePageNumber(_ pageNumber: UInt, totalPages: UInt) {}
}
