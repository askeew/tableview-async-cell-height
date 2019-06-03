
import Foundation
import UIKit
import PDFKit

class Cell: UITableViewCell {

    lazy var pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        return pdfView
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
        if let data = vm.data {
            pdfView.document = PDFDocument(data: data)
//            print("new frame: \(String(describing: pdfView.documentView?.frame.size))")
            pdfView.heightAnchor.constraint(equalToConstant: pdfView.documentView?.frame.size.height ?? 20).isActive = true
        }
        if let document = vm.pdf {
            pdfView.document = document
        }
    }

    private func setupConstraints() {
        pdfView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        let heightConstraint = pdfView.heightAnchor.constraint(equalTo: heightAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }

    private func setupViews() {
        addSubview(pdfView)
        backgroundColor = .white
        selectionStyle = .none
    }

    struct ViewModel {
        let data: Data?
        let pdf: PDFDocument?
    }
}
