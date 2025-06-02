import UIKit

class TaskListViewController: UIViewController {
    //MARK: - Header UI Elements
    private let profileImageView = ProfileImage.makeImageView()
    private let helloLabel = UILabel()
    private let userNameLabel = UILabel()
    private let settingsButton = UIButton()
    private let headerTextStackView = UIStackView()
    private let headerStackView = UIStackView()
    
    //MARK: - TabBar UI Elements
    private let tabBarStackView = UIStackView()
    private let allTaskButton = UIButton()
    private let activeTaskButton = UIButton()
    private let completedTaskButton = UIButton()
    
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
        configureProfileImageView()
        configureHelloLabel()
        configureUserNameLabel()
        configureSettingsButton()
        configureHeaderTextStackView()
        configureHeaderStackView()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            
                    
            settingsButton.widthAnchor.constraint(equalToConstant: 44),
            settingsButton.heightAnchor.constraint(equalToConstant: 44),
            
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            headerStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureProfileImageView() {
        profileImageView.layer.cornerRadius = 30
    }
    
    private func configureHelloLabel() {
        helloLabel.text = "Привет,"
        helloLabel.font = .systemFont(ofSize: 17, weight: .regular)
        helloLabel.textColor = UIColor(named: "YPTextGray")
        helloLabel.numberOfLines = 0
        helloLabel.textAlignment = .left
    }
    
    private func configureUserNameLabel() {
        userNameLabel.text = "Daniil Isakov"
        userNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        userNameLabel.textColor = UIColor(named: "YPBlack")
        userNameLabel.numberOfLines = 0
        userNameLabel.textAlignment = .left
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
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.widthAnchor.constraint(equalToConstant: 19).isActive = true
        
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.distribution = .fill
        headerStackView.spacing = .zero
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.addArrangedSubview(profileImageView)
        headerStackView.addArrangedSubview(spacer)
        headerStackView.addArrangedSubview(headerTextStackView)
        headerStackView.addArrangedSubview(settingsButton)
        
        view.addSubview(headerStackView)
    }
    
 
    
    
    
    
    
    @objc private func settingsButtonTapped() {
        print("Нажал")
    }
    
    
    
    
}

