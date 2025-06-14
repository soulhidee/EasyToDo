import UIKit

final class SplashViewController: UIViewController {
    
    private let launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.launchScreen
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        print("Опа опа сплэш скрин")
        super.viewDidLoad()
        view.addSubview(launchImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            launchImageView.topAnchor.constraint(equalTo: view.topAnchor),
            launchImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            launchImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
