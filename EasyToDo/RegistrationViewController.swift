import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - UI Elements
    private let profileImageView = UIImageView()
    private let helloLabel = UILabel()
    private let greetingLabel = UILabel()
    private let nameTextField = UITextField()
    private let startButton = UIButton()
    private let settingsHintLabel = UILabel()
    private let mainStackView = UIStackView()
    private let helloStackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.applyGradient(from: "YPGradientStart", to: "YPGradientEnd")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        configureMainStackView()
        configureHelloStackView()
        configureProfileImageView()
        configureHelloLabel()
        configureGreetingLabel()
        configureNameTextField()
        configureStartButton()
        configureSettingsHintLabel()
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 172),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -179),
            
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            nameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            helloStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            startButton.heightAnchor.constraint(equalToConstant: 55),
            startButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 92),
            startButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -92)
        ])
    }
    
    // MARK: - Configure UI Elements
    private func configureProfileImageView() {
        profileImageView.image = UIImage(named: "ProfileImage")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureHelloLabel() {
        helloLabel.text = "Здравствуйте!"
        helloLabel.font = .systemFont(ofSize: 28, weight: .bold)
        helloLabel.textColor = UIColor(named: "YPTextGray")
        helloLabel.numberOfLines = .zero
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureGreetingLabel() {
        greetingLabel.text = "Давайте познакомимся с вами поближе"
        greetingLabel.font = .systemFont(ofSize: 17, weight: .regular)
        greetingLabel.textColor = UIColor(named: "YPTextGray")
        greetingLabel.numberOfLines = .zero
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNameTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите ваше имя",
            attributes: [
                .foregroundColor: UIColor(named: "YPPlaceholder") ?? .green,
                .font: UIFont.systemFont(ofSize: 14)
            ])
        nameTextField.textAlignment = .left
        nameTextField.layer.borderColor = UIColor(named: "YPGreen")?.cgColor ?? UIColor.green.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 44))
        nameTextField.leftView = paddingViewLeft
        nameTextField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 44))
        nameTextField.rightView = paddingViewRight
        nameTextField.rightViewMode = .always
        
        nameTextField.layer.masksToBounds = true
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStartButton() {
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(named: "YPGreen") ?? .green
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.layer.cornerRadius = 16
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSettingsHintLabel() {
        settingsHintLabel.text = "Позже можно изменить в разделе Настройки."
        settingsHintLabel.font = .systemFont(ofSize: 13, weight: .medium)
        settingsHintLabel.textColor = UIColor(named: "YPTextGray")
        settingsHintLabel.numberOfLines = .zero
        settingsHintLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 32
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(helloStackView)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(startButton)
        mainStackView.addArrangedSubview(settingsHintLabel)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
    }
    
    private func configureHelloStackView() {
        helloStackView.axis = .vertical
        helloStackView.alignment = .center
        helloStackView.distribution = .fill
        helloStackView.spacing = 8
        helloStackView.addArrangedSubview(helloLabel)
        helloStackView.addArrangedSubview(greetingLabel)
        helloStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Actions
    @objc func startButtonTapped() {
        print("Кнопка нажата")
    }
}

// MARK: - UIView Extension
extension UIView {
    func applyGradient(from startColorName: String, to endColorName: String) {
        guard
            let startColor = UIColor(named: startColorName)?.cgColor,
            let endColor = UIColor(named: endColorName)?.cgColor
        else {
            print("❌ Ошибка: цвета не найдены в ассетах")
            return
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.layer.sublayers?
            .filter { $0 is CAGradientLayer }
            .forEach { $0.removeFromSuperlayer() }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
