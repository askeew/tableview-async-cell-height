
import Foundation
import UIKit
import WebKit

class Cell: UITableViewCell {

    private var callback: ((UITableViewCell) -> Void)?

    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        view.scrollView.isScrollEnabled = false
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
        webView.loadHTMLString(normalize + vm.htmlString, baseURL: nil)
        callback = vm.callback
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }

    private func setupViews() {
        addSubview(webView)
        backgroundColor = .white
        selectionStyle = .none
    }

    struct ViewModel {
        let htmlString: String
        let callback: (UITableViewCell) -> Void
    }
}

extension Cell: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        //NOTE: we're note completley finished loading...
        webView.evaluateJavaScript("document.readyState") { [weak self] _, _ in
            guard let self = self else { return }
            let constraint = webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height)
            constraint.priority = .defaultHigh
            constraint.isActive = true
            webView.setNeedsUpdateConstraints()
            self.callback?(self)
        }
    }
}

extension Cell {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
//            print("progress \(webView.url!.absoluteString) \(Int(webView.estimatedProgress * 100)) %")
        }
    }
}

fileprivate let normalize = """
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='format-detection' content='telephone=no'>
<meta name='viewport' content='width=device-width, initial-scale=1.0' shrink-to-fit=no'>
    <style>
        body {
            box-sizing: border-box;
            position: absolute;
            overflow: hidden;
            width: 100%;
            margin:0;
        }
    </style>
</head>
"""
