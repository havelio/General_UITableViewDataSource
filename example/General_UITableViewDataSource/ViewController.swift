//
//  ViewController.swift
//  General_UITableViewDataSource
//
//  Created by Havelio Henar on 09/07/20.
//  Copyright © 2020 Havelio Henar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]

    var dataSource: TableViewDataSource<BasicCell, String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = .make(items: data, tableView: tableView)
    }
}

class BasicCell: BaseTableViewCell<String> {

    override var item: String! {
        didSet {
            self.textLabel?.text = item
        }
    }
}
