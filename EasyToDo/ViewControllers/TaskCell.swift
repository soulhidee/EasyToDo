import UIKit

final class TaskCell: UITableViewCell {
    // MARK: - Static Properties
    static let reuseIdentifier = "TaskCell"
    
    // MARK: - Constants
    private enum TaskCellConstants {
        static let fontSize: CGFloat = 18
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let backgroundAlpha: CGFloat = 0.3
        static let checkboxSize: CGFloat = 28
        static let taskLabelLeading: CGFloat = 16
        static let taskLabelTopBottom: CGFloat = 21
        static let checkButtonTrailing: CGFloat = -16
        static let checkButtonTopBottom: CGFloat = 18
        static let spacingBetweenLabelAndButton: CGFloat = -12
        static let taskLabelNumberOfLines = 1
    }
    
    // MARK: - UI Elements
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: TaskCellConstants.fontSize, weight: .medium)
        label.textColor = UIColor.ypBlack
        label.numberOfLines = TaskCellConstants.taskLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "YPWhite")?.withAlphaComponent(TaskCellConstants.backgroundAlpha) ?? UIColor.white.withAlphaComponent(TaskCellConstants.backgroundAlpha)
        view.layer.cornerRadius = TaskCellConstants.cornerRadius
        view.layer.borderWidth = TaskCellConstants.borderWidth
        view.layer.borderColor = UIColor.ypGreen.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        return view
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.checkboxOff, for: .normal)
        button.setImage(UIImage.checkboxOn, for: .selected)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views & Constraints
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(taskLabel)
        containerView.addSubview(checkButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: TaskCellConstants.taskLabelLeading),
            taskLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: TaskCellConstants.taskLabelTopBottom),
            taskLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -TaskCellConstants.taskLabelTopBottom),
            
            checkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: TaskCellConstants.checkButtonTrailing),
            checkButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: TaskCellConstants.checkButtonTopBottom),
            checkButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -TaskCellConstants.checkButtonTopBottom),
            checkButton.widthAnchor.constraint(equalToConstant: TaskCellConstants.checkboxSize),
            checkButton.heightAnchor.constraint(equalToConstant: TaskCellConstants.checkboxSize),
            
            taskLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: TaskCellConstants.spacingBetweenLabelAndButton),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    func configure(with task: String, isChecked: Bool) {
        taskLabel.text = task
        checkButton.isSelected = isChecked
    }
    
    // MARK: - Actions
    @objc private func checkButtonTapped() {
        checkButton.isSelected.toggle()
        // Можно уведомить контроллер, если надо (через delegate или callback)
    }
}
