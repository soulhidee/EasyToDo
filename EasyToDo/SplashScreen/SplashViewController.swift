import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Constants
    enum SplashViewConstants {
        static let animationDelay: TimeInterval = 1.5
    }
    
    // MARK: - UI Elements
    private let launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.launchScreen
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(launchImageView)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthorization()
    }
    
    // MARK: - Constraint
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            launchImageView.topAnchor.constraint(equalTo: view.topAnchor),
            launchImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            launchImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Authorization Flow
    private func checkAuthorization() {
        let isAuthorized = UserDataManager.shared.isUserAuthorized()

        DispatchQueue.main.asyncAfter(deadline: .now() + SplashViewConstants.animationDelay) {
            if isAuthorized {
                self.showMainScreen()
            } else {
                self.showRegistration()
            }
        }
    }

    private func showMainScreen() {
        let mainVC = TaskListViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }

    private func showRegistration() {
        let registrationVC = RegistrationViewController()
        registrationVC.modalPresentationStyle = .fullScreen
        self.present(registrationVC, animated: true)
    }
}
