
import UIKit

class ViewController: UITableViewController {

    private var cache = [Int: UITableViewCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cache[indexPath.row] {
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { return UITableViewCell() }
        switch modelData[indexPath.row] {
        case .needsFetching(let contentIconUrl, let placeholderImage):
            URLSession.shared.dataTask(with: URLRequest(url: contentIconUrl), completionHandler: { data, response, error in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.update(with: Cell.ViewModel(logo: image) { [weak self] cell in
                            tableView.beginUpdates()
                            self?.cache[indexPath.row] = cell
                            tableView.endUpdates()
                        })
                    }
                } else {
                    cell.update(with: Cell.ViewModel(logo: placeholderImage) { [weak self] cell in
                        tableView.beginUpdates()
                        self?.cache[indexPath.row] = cell
                        tableView.endUpdates()
                    })
                }
            }).resume()
        }
        return cell
    }
}

public extension UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


fileprivate let modelData = [
    Cell.Logo.needsFetching(from: URL(string: "https://www.avanza.se/avanzabank/hem/start/ski-badges.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1400/1*o3BjyF7t1eiKZMtOkDmOew.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1400/1*hgBtloFd9ZNeKwOEvfcpig.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/2560/1*Gi5a_89ZLUp7OgztQanWmg.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/800/1*rWN6HdC61ChO2dNs8W8wEQ.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1200/1*t80R44pKEagfOfiHn9_fUg.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/800/1*WikGy-T9gltDtJkJloupMw.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/fit/t/800/240/1*UY2kT6mGFTpYuZU5we2cbg.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://www.avanza.se/avanzabank/hem/start/ski-badges.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1400/1*o3BjyF7t1eiKZMtOkDmOew.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1400/1*hgBtloFd9ZNeKwOEvfcpig.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/2560/1*Gi5a_89ZLUp7OgztQanWmg.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/800/1*rWN6HdC61ChO2dNs8W8wEQ.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/1200/1*t80R44pKEagfOfiHn9_fUg.png")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/max/800/1*WikGy-T9gltDtJkJloupMw.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
    Cell.Logo.needsFetching(from: URL(string: "https://cdn-images-1.medium.com/fit/t/800/240/1*UY2kT6mGFTpYuZU5we2cbg.jpeg")!,
                            fallback: UIImage(named: "penguin")!),
]
