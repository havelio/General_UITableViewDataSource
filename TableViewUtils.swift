//
//  TableViewUtils.swift
//  General_UITableViewDataSource
//
//  Created by Havelio Henar on 09/07/20.
//  Copyright © 2020 Havelio Henar. All rights reserved.
//

import UIKit

/**
 TableViewDataSource is a class for handling general dataSource of UITableView,
 So we don't need exten UITableViewDataSource to each controller
 how to use:
 
 class UserCell: BaseTableViewCell<User> {
     override var item: User! {
         didSet {
            // hanlde your data here
        }
     }
 }

 // define the generic model type:
 var dataSource: TableViewDataSource<UserCell, User>!

 let users = [User]()
 dataSource = .make(items: users, tableView: tableView)

 // for reload table:
 dataSource.reload(data: users)

 // for custom configuration:
 dataSource = .make(items: users, tableView: tableView) { [weak self] cell, indexPath  in
    // handle your custom code here
 }
*/

class TableViewDataSource<Cell: BaseTableViewCell<Model>, Model>: NSObject, UITableViewDataSource {
    typealias PrepareCell = (Cell, IndexPath) -> Void

    private var prepareCell: PrepareCell? = nil
    private var tableView: UITableView? = nil

    var items: [Model]! {
        didSet { tableView?.reloadData() }
    }

    static func make(items: [Model], tableView: UITableView,
                     prepareCell: PrepareCell? = nil) -> TableViewDataSource {

        let tableViewDataSource = TableViewDataSource()
        tableViewDataSource.tableView = tableView
        tableViewDataSource.items = items
        tableViewDataSource.prepareCell = prepareCell

        tableView.dataSource = tableViewDataSource
        return tableViewDataSource
    }

    func reloa(data: [Model]) {
        self.items = data
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as! Cell
        cell.item = items[indexPath.row]
        prepareCell?(cell, indexPath)
        return cell
    }
}

class BaseTableViewCell<Model>: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    var item: Model!
}
