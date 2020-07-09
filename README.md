# General_UITableViewDataSource
Very simple code UITableViewDataSource using General for many UITableView you have


### Before using General

Usually every time you add a UITableView in your controller, you must also add UITableViewDataSource to the controller
```swift
extension viewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! BaseCell

        cell.textLabel?.text = item.title
        return cell
    }
}

class BaseCell: UITableViewCell {}
```

in programming we know 1 quote `"never repeat yourself"`
therefore swift provides `General` features for which we can use it to never again add `UITableviewDataSource` on each controller

what we do is separate the datasource from the tableview controller by creating a special class
to manage dataSource so that we can reuse that class for other controllers

### After using General
```swift
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    var dataSource: TableViewDataSource<BasicCell, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = .make(items: items, tableView: tableView)
    }
}

class BasicCell: BaseTableViewCell<String> {
    override var item: String! {
        didSet {
            self.textLabel?.text = item
        }
    }
}
```
You can get the class that manages the datasource in `TableViewUtils.swift`

### Good luck!
