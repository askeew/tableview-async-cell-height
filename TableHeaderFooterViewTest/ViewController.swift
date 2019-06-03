import UIKit
import PDFKit

class ViewController: UITableViewController {
    let modelData = [
        URL(string: "http://doc.morningstar.com/document/973bc7fd1a6665ea50925ae266973185.msdoc/?clientid=avanza&key=3728b8f503435715")!,
        URL(string: "http://doc.morningstar.com/document/f5446dafe9d2be780e7dabb65f0f3f74.msdoc/?clientid=avanza&key=3728b8f503435715")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.separatorStyle = .none
    }

    override func viewDidLayoutSubviews() {
//        tableView.subviews.filter({$0 is UITableViewCell}).forEach({print("viewDidLayoutSubviews.celler: \($0.frame.size)")})
//        print("viewDidLayoutSubviews.contentSize: \(tableView.contentSize.height)")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        if cell.pdfView.document == nil {
            NetworkManager().loadData(from: URLRequest(url: modelData[indexPath.row])) { data in
                DispatchQueue.main.async {
                    if let data = data {
                        tableView.beginUpdates()
                        cell.update(with: Cell.ViewModel(data: data, pdf: nil))
                        tableView.endUpdates()
                    }
                }
            }
        }
        return cell
    }
}

public extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
