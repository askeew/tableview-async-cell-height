
import UIKit

class ViewController: UITableViewController {
    let modelData = [
        Cell.Logo.inApp(from: UIImage(named: "penguin")),
        Cell.Logo.needsFetching(from: URL(string: "https://www.avanza.se/avanzabank/hem/start/ski-badges.png")!,
                                fallback: UIImage(named: "penguin")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        switch modelData[indexPath.row] {
        case .inApp(let image):
            cell.update(with: Cell.ViewModel(logo: image))
            return cell
        case .needsFetching(let contentIconUrl, let placeholderImage):
            NetworkManager().loadData(from: URLRequest(url: contentIconUrl)) { data in
                DispatchQueue.main.async {
                    if let data = data {
                        let downloadedImage = UIImage(data: data)
                        tableView.beginUpdates()
                        cell.update(with: Cell.ViewModel(logo: downloadedImage))
                        tableView.endUpdates()
                    } else {
                        cell.update(with: Cell.ViewModel(logo: placeholderImage))
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
