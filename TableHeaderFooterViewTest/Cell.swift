
import Foundation
import UIKit
import Accelerate

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
        let resizedImage = resize(image: vm.logo, newWidth: frame.width)
        myImage.image = resizedImage
        vm.callback(self)
    }

    private func resize(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let imageRatio = image.size.height / image.size.width
        let newHeight = imageRatio * newWidth
        let newSize = CGSize(width: newWidth, height: newHeight)
        return image.resizeImageUsingVImage(size: newSize)
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
        let logo: UIImage
        let callback: (UITableViewCell) -> Void
    }

    enum Logo {
        case needsFetching(from: URL, fallback: UIImage)
    }
}

extension UIImage {

    func resizeImageUsingVImage(size: CGSize) -> UIImage? {
        let cgImage = self.cgImage!
        var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue), version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
        var sourceBuffer = vImage_Buffer()
        defer {
            free(sourceBuffer.data)
        }
        var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
        guard error == kvImageNoError else { return nil }
        // create a destination buffer
        let scale = self.scale
        let destWidth = Int(size.width)
        let destHeight = Int(size.height)
        let bytesPerPixel = self.cgImage!.bitsPerPixel/8
        let destBytesPerRow = destWidth * bytesPerPixel
        let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
        defer {
            destData.deallocate()//(capacity: destHeight * destBytesPerRow)
        }
        var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
        // scale the image
        error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
        guard error == kvImageNoError else { return nil }
        // create a CGImage from vImage_Buffer
        var destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
        guard error == kvImageNoError else { return nil }
        // create a UIImage
        let resizedImage = destCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: self.imageOrientation) }
        destCGImage = nil
        return resizedImage
    }
}
