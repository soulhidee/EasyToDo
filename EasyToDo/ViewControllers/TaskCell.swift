import UIKit

final class TaskCell: UITableViewCell {
    // MARK: - Static Properties
    static let reuseIdentifier = "TaskCell"
    
    // MARK: - UI Elements
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "YPBlack") ?? .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "YPWhite") ?? .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        return view
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkbox_off"), for: .normal)
        button.setImage(UIImage(named: "checkbox_on"), for: .selected)
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
            taskLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            taskLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            taskLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -21),
            
            checkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            checkButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            checkButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18),
            
            checkButton.widthAnchor.constraint(equalToConstant: 28),
            checkButton.heightAnchor.constraint(equalToConstant: 28),
            
            taskLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -12),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
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
