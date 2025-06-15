import UIKit

struct ProfileImage {
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = Constants.profileImagecornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

