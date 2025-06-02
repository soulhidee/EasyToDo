import UIKit

class TaskListViewController: UIViewController {

    private let profileImageView = ProfileImage.makeImageView()
    private let helloLabel = UILabel()
    private let userNameLabel = UILabel()
    private let settingsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradient = GradientHelper.makeGradientLayer(frame: view.bounds)
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func setupViews() {
        configureHelloLabel()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        ])
    }

    private func configureHelloLabel() {
        helloLabel.text = "Привет,"
        helloLabel.font = .systemFont(ofSize: 17, weight: .regular)
        helloLabel.textColor = UIColor(named: "YPTextGray")
        helloLabel.numberOfLines = 0
        helloLabel.textAlignment = .left
    }
    
    private func configureUserNameLabel() {
        helloLabel.text = "Daniil Isakov"
        helloLabel.font = .systemFont(ofSize: 22, weight: .bold)
        helloLabel.textColor = UIColor(named: "YPBlack")
        helloLabel.numberOfLines = 0
        helloLabel.textAlignment = .left
    }
    
    private func configureSettingsButton() {
        settingsButton.setTitle("", for: .normal)
        settingsButton.setImage(UIImage(named: "Settings"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
            
        settingsButton.applyCustomShadow()
        }

    @objc private func settingsButtonTapped() {
        print("Нажал")
    }
}
