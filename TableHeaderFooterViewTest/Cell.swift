
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
        }
        if let document = vm.pdf {
            pdfView.document = document
        }
        layoutIfNeeded()
    }

    private func setupConstraints() {
        pdfView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
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
