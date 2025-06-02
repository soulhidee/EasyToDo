import UIKit

class TaskListViewController: UIViewController {

    private let profileImageView = ProfileImage.makeImageView()
    private let helloLabel = UILabel()
    private let userNameLabel = UILabel()
    private let settingsButton = UIButton()
    private let headerTextStackView = UIStackView()
    private let headerStackView = UIStackView()

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
        configureUserNameLabel()
        configureSettingsButton()
        configureHeaderTextStackView()
        configureHeaderStackView()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainStackViewLeading),
            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.mainStackViewTrailing),
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

    private func configureHeaderTextStackView() {
        headerTextStackView.axis = .vertical
        headerTextStackView.alignment = .fill
        headerTextStackView.distribution = .fill
        headerTextStackView.spacing = .zero
        headerTextStackView.translatesAutoresizingMaskIntoConstraints = false
        
        headerTextStackView.addArrangedSubview(helloLabel)
        headerTextStackView.addArrangedSubview(userNameLabel)
    }
    
    private func configureHeaderStackView() {
        headerStackView.axis = .horizontal
        headerStackView.alignment = .fill
        headerStackView.distribution = .fill
        headerStackView.spacing = 19
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        headerStackView.addArrangedSubview(profileImageView)
        headerStackView.addArrangedSubview(headerTextStackView)
        headerStackView.addArrangedSubview(settingsButton)
        
        view.addSubview(headerStackView)
    }
    
    
    
    
    
    @objc private func settingsButtonTapped() {
        print("Нажал")
    }
    
    
    
    
}

