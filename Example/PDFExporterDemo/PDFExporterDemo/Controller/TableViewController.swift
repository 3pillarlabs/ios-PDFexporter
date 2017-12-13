//
//  TableViewController.swift
//  PDFExporterDemo
//
//  Created by Ciprian Antal on 08/12/2017.
//  Copyright © 2017 3PG. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, PDFControllerProtocol {
    var contentView: UIView {
        return tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellIdentifier = "ReportTableViewCell"
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableViewCell", for: indexPath)

        return cell
    }
}
