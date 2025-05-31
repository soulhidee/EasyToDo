import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
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
        configureNameTextFieldActions()
        nameTextField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31),
            
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            nameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
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
        helloLabel.textAlignment = .center
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
        settingsHintLabel.font = .systemFont(ofSize: 16, weight: .regular)
        settingsHintLabel.textColor = UIColor(named: "YPGray")
        settingsHintLabel.textAlignment = .center
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
        helloStackView.alignment = .fill
        helloStackView.distribution = .fill
        helloStackView.spacing = 8
        helloStackView.addArrangedSubview(helloLabel)
        helloStackView.addArrangedSubview(greetingLabel)
        helloStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNameTextFieldActions() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        startButton.alpha = 0.5
        startButton.isEnabled = false
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let trimmedText = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        startButton.isEnabled = trimmedText.count >= 2
        startButton.alpha = startButton.isEnabled ? 1 : 0.5
    }
    
    // MARK: - Actions
    @objc private func startButtonTapped() {
        print("Нажал")
    }
    
    // MARK: - Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
    
    
}

// MARK: - Extension
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

