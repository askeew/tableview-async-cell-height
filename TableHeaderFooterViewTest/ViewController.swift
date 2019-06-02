
import UIKit
import WebKit
class ViewController: UITableViewController {
    let modelData = [URL(string: "https://www.apple.com/")!,
//                     URL(string: "https://www.kivra.com/")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    override func viewDidLayoutSubviews() {
        print("contentSize: \(tableView.contentSize) \(tableView.subviews.filter({$0 is Cell}))")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        cell.update(with: Cell.ViewModel(url: modelData[indexPath.row], callback: {
            print("callback called: \((cell.subviews.filter({$0 is WKWebView}).first as! WKWebView).scrollView)")
            cell.layoutIfNeeded()
            tableView.beginUpdates()
            tableView.endUpdates()

        }))
        return cell
    }
}

public extension UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
