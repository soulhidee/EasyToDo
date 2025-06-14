import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements
    private let profileImageView = ProfileImage.makeImageView()
    private let helloLabel = UILabel()
    private let greetingLabel = UILabel()
    private let nameTextField = UITextField()
    private let startButton = UIButton()
    private let settingsHintLabel = UILabel()
    private let mainStackView = UIStackView()
    private let helloStackView = UIStackView()
    
    //MARK: - Private Property
    private var profileImagePicker = ProfileImagePicker()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureNameTextFieldActions()
        nameTextField.delegate = self
        setupDismissKeyboardGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Удаляем старый, если есть, чтобы не накапливать слои
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = GradientHelper.makeGradientLayer(frame: view.bounds)
        view.layer.insertSublayer(gradient, at: 0)
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
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            
            mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.mainStackViewLeading),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.mainStackViewTrailing),
            
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            nameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            startButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            startButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Constants.startButtonLeading),
            startButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: Constants.startButtonTrailing)
        ])
    }
    
    // MARK: - Configure UI Elements
    private func configureProfileImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
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
            ]
        )
        nameTextField.textAlignment = .left
        
        nameTextField.layer.borderColor = UIColor(named: "YPGreen")?.cgColor ?? UIColor.green.cgColor
        nameTextField.textColor = UIColor(named: "YPTextGray")
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.masksToBounds = true
        
        let paddingViewLeft = makeTextFieldPaddingView()
        nameTextField.leftView = paddingViewLeft
        nameTextField.leftViewMode = .always
        
        let paddingViewRight = makeTextFieldPaddingView()
        nameTextField.rightView = paddingViewRight
        nameTextField.rightViewMode = .always
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStartButton() {
        startButton.setTitle("Начать", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(named: "YPGreen") ?? .green
        startButton.layer.cornerRadius = Constants.buttonCornerRadius
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        startButton.applyCustomShadow()
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
        mainStackView.spacing = Constants.mainStackSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(helloStackView)
        mainStackView.addArrangedSubview(nameTextField)
        mainStackView.addArrangedSubview(startButton)
        mainStackView.addArrangedSubview(settingsHintLabel)
        
        view.addSubview(mainStackView)
    }
    
    private func configureHelloStackView() {
        helloStackView.axis = .vertical
        helloStackView.alignment = .fill
        helloStackView.distribution = .fill
        helloStackView.spacing = Constants.helloStackSpacing
        helloStackView.translatesAutoresizingMaskIntoConstraints = false
        
        helloStackView.addArrangedSubview(helloLabel)
        helloStackView.addArrangedSubview(greetingLabel)
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
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func makeTextFieldPaddingView() -> UIView {
        UIView(frame: CGRect(x: 0, y: 0, width: Constants.textFieldInsetWidth, height: Constants.textFieldHeight))
    }
    
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func startButtonTapped() {
    }
    
    @objc private func imageTapped() {
        profileImagePicker.showImagePicker(in: self) { image in
            self.profileImageView.image = image
        }
    }
    
    // MARK: - Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= Constants.maxNameLength
    }
    
    
}
