import UIKit

final class RegistrationViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Constants
    private enum RegistrationConstants {
        static let profileImageSize: CGFloat = 150
        static let buttonCornerRadius: CGFloat = 16
        
        static let mainStackViewLeading: CGFloat = 31
        static let mainStackViewTrailing: CGFloat = -31
        static let mainStackSpacing: CGFloat = 32
        static let helloStackSpacing: CGFloat = 8
        
        static let startButtonDisabledAlpha: CGFloat = 0.5
        static let startButtonEnabledAlpha: CGFloat = 1.0
        static let nameMinLength: Int = 2
        
        static let textFieldHeight: CGFloat = 44
        static let textFieldInsetWidth: CGFloat = 14
        static let maxNameLength: Int = 20
        static let nameTextFieldBorderWidth: CGFloat = 1
        static let nameTextFieldCornerRadius: CGFloat = 10
        
        static let buttonHeight: CGFloat = 55
        static let startButtonLeading: CGFloat = 92
        static let startButtonTrailing: CGFloat = -92
        
        static let helloText = "Здравствуйте!"
        static let greetingText = "Давайте познакомимся с вами поближе"
        static let namePlaceholder = "Введите ваше имя"
        static let startButtonTitle = "Начать"
        static let settingsHintText = "Позже можно изменить в разделе Настройки."
        
        
        static let helloFontSize: CGFloat = 28
        static let helloFontWeight: UIFont.Weight = .bold

        static let greetingFontSize: CGFloat = 17
        static let greetingFontWeight: UIFont.Weight = .regular

        static let placeholderFontSize: CGFloat = 14

        static let startButtonFontSize: CGFloat = 18
        static let startButtonFontWeight: UIFont.Weight = .medium

        static let settingsHintFontSize: CGFloat = 16
        static let settingsHintFontWeight: UIFont.Weight = .regular
    }
    
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
        
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = GradientHelper.makeGradientLayer(frame: view.bounds)
        view.layer.insertSublayer(gradient, at: .zero)
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
            profileImageView.widthAnchor.constraint(equalToConstant: RegistrationConstants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: RegistrationConstants.profileImageSize),
            
            mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: RegistrationConstants.mainStackViewLeading),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: RegistrationConstants.mainStackViewTrailing),
            
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: RegistrationConstants.textFieldHeight),
            nameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            
            startButton.heightAnchor.constraint(equalToConstant: RegistrationConstants.buttonHeight),
            startButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: RegistrationConstants.startButtonLeading),
            startButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: RegistrationConstants.startButtonTrailing)
        ])
    }
    
    // MARK: - Configure UI Elements
    private func configureProfileImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    private func configureHelloLabel() {
        helloLabel.text = RegistrationConstants.helloText
        helloLabel.font = .systemFont(ofSize: RegistrationConstants.helloFontSize, weight: RegistrationConstants.helloFontWeight)
        helloLabel.textColor = UIColor.ypTextGray
        helloLabel.numberOfLines = .zero
        helloLabel.textAlignment = .center
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureGreetingLabel() {
        greetingLabel.text = RegistrationConstants.greetingText
        greetingLabel.font = .systemFont(ofSize: RegistrationConstants.greetingFontSize, weight: RegistrationConstants.greetingFontWeight)
        greetingLabel.textColor = UIColor.ypTextGray
        greetingLabel.numberOfLines = .zero
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNameTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: RegistrationConstants.namePlaceholder,
            attributes: [
                .foregroundColor: UIColor.ypPlaceholder,
                .font: UIFont.systemFont(ofSize: RegistrationConstants.placeholderFontSize)
            ]
        )
        nameTextField.textAlignment = .left
        
        nameTextField.layer.borderColor = UIColor.ypGreen.cgColor
        nameTextField.textColor = UIColor.ypGreen
        nameTextField.layer.borderWidth = RegistrationConstants.nameTextFieldBorderWidth
        nameTextField.layer.cornerRadius = RegistrationConstants.nameTextFieldCornerRadius
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
        startButton.setTitle(RegistrationConstants.startButtonTitle, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: RegistrationConstants.startButtonFontSize, weight: RegistrationConstants.startButtonFontWeight)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.ypGreen
        startButton.layer.cornerRadius = RegistrationConstants.buttonCornerRadius
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        startButton.applyCustomShadow()
    }
    
    private func configureSettingsHintLabel() {
        settingsHintLabel.text = RegistrationConstants.settingsHintText
        settingsHintLabel.font = .systemFont(ofSize: RegistrationConstants.settingsHintFontSize, weight: RegistrationConstants.settingsHintFontWeight)
        settingsHintLabel.textColor = UIColor.ypGray
        settingsHintLabel.textAlignment = .center
        settingsHintLabel.numberOfLines = .zero
        settingsHintLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = RegistrationConstants.mainStackSpacing
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
        helloStackView.spacing = RegistrationConstants.helloStackSpacing
        helloStackView.translatesAutoresizingMaskIntoConstraints = false
        
        helloStackView.addArrangedSubview(helloLabel)
        helloStackView.addArrangedSubview(greetingLabel)
    }
    
    private func configureNameTextFieldActions() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        startButton.alpha = RegistrationConstants.startButtonDisabledAlpha
        startButton.isEnabled = false
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let trimmedText = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        startButton.isEnabled = trimmedText.count >= RegistrationConstants.nameMinLength
        startButton.alpha = startButton.isEnabled ? RegistrationConstants.startButtonEnabledAlpha : RegistrationConstants.startButtonDisabledAlpha
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
        UIView(frame: CGRect(x: .zero, y: .zero, width: RegistrationConstants.textFieldInsetWidth, height: RegistrationConstants.textFieldHeight))
    }
    
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func startButtonTapped() {
        guard let name = nameTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        UserDataManager.shared.saveUserName(name)
        if let image = profileImageView.image {
            UserDataManager.shared.saveProfileImage(image)
        }
        UserDataManager.shared.setUserAuthorized(true)
        let mainVC = TaskListViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
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
        return updatedText.count <= RegistrationConstants.maxNameLength
    }
    
    
}
