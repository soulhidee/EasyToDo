import UIKit

final class RegistrationViewController: UIViewController {
    private let profileImageView = UIImageView()
    private let helloLabel = UILabel()
    private let greetingLabel = UILabel()
    private let nameTextField = UITextField()
    private let startButton = UIButton()
    private let settingsHintLabel = UILabel()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.applyGradient(from: "YPGradientStart", to: "YPGradientEnd")
    }
    
    private func setupViews() {
        configureStackView()
        configureProfileImageView()
        configureHelloLabel()
        configureGreetingLabel()
        configureNameTextField()
        configureStartButton()
        configureSettingsHintLabel()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 172),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -179)
        ])
    }
    
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
        nameTextField.layer.masksToBounds = true
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStartButton() {
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(named: "YPGreen") ?? .green
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSettingsHintLabel() {
        settingsHintLabel.text = "Позже можно изменить в разделе Настройки."
        settingsHintLabel.font = .systemFont(ofSize: 13, weight: .medium)
        settingsHintLabel.textColor = UIColor(named: "YPTextGray")
        settingsHintLabel.numberOfLines = .zero
        settingsHintLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(helloLabel)
        stackView.addArrangedSubview(greetingLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(settingsHintLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    
    
    @objc func startButtonTapped() {
        print("Кнопка нажата")
    }
    
    
    
    
    
    
    
    
    
}



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
