//
//  HeaderView.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 07/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    class func instanceFromNib() -> UIView? {
        guard let headerView =  UINib(nibName: "HeaderView",
                                      bundle: nil).instantiate(withOwner: nil, options: nil).first as? HeaderView
            else { return nil }
        return headerView
    }
}
