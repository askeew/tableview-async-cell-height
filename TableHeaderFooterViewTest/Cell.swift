
import Foundation
import UIKit

class Cell: UITableViewCell {

    private lazy var myImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
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
        myImage.image = vm.logo
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: topAnchor),
            myImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupViews() {
        addSubview(myImage)
        backgroundColor = .white
        selectionStyle = .none
    }

    struct ViewModel {
        let logo: UIImage?
    }

    enum Logo {
        case inApp(from: UIImage?)
        case needsFetching(from: URL, fallback: UIImage?)
    }
}
