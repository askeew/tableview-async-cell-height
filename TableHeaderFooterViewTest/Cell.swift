
import Foundation
import UIKit
import WebKit

class Cell: UITableViewCell {

    private var callback: (() -> Void)?

    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with vm: ViewModel) {
        webView.load(URLRequest(url: vm.url))
        callback = vm.callback
        print("update")
        print("webView: \(webView.scrollView.contentSize)")
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.heightAnchor.constraint(equalTo: heightAnchor),
            webView.widthAnchor.constraint(equalTo: widthAnchor),
            ])
    }

    private func setupViews() {
        addSubview(webView)
        backgroundColor = .white
        selectionStyle = .none
    }

    struct ViewModel {
        let url: URL
        let callback: () -> Void
    }
}

extension Cell: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.sizeToFit()
        print("didFinish")
        print("webView: \(webView.scrollView.contentSize)")
        callback?()
    }
}

extension Cell {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print("progress \(webView.url?.absoluteString) \(Int(webView.estimatedProgress * 100)) %")
        }
    }
}
