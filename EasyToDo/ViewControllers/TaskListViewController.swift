import UIKit

class TaskListViewController: UIViewController {
    
    // MARK: - Constants
    private enum TaskListConstants {
        // Sizes
        static let profileImageSize: CGFloat = 60
        static let profileImageCornerRadius: CGFloat = profileImageSize / 2
        
        static let settingsButtonSize: CGFloat = 44
        
        static let headerStackViewHeight: CGFloat = 60
        
        static let segmentedControlHeight: CGFloat = 44
        
        static let addButtonSize: CGFloat = 64
        
        static let tableViewRowHeight: CGFloat = 64 + 32
        
        // Margins
        static let topMargin: CGFloat = 16
        static let sideMargin: CGFloat = 16
        static let segmentTopMargin: CGFloat = 32
        static let tableViewTopMargin: CGFloat = 32
        static let tableViewBottomToAddButton: CGFloat = 16
        static let addButtonBottomMargin: CGFloat = 32
        static let spacerWidth: CGFloat = 19
        
        // Texts
        static let helloText = "Привет,"
        static let userNameText = "Daniil Isakov"
        static let alertTitle = "Новая задача"
        static let alertMessage = "Пожалуйста добавьте задачу"
        static let alertSaveTitle = "Сохранить"
        static let alertCancelTitle = "Закрыть"
        
        // Segments
        static let segmentItems = ["Все задачи", "В процессе", "Выполнено"]
        static let segmentedSelectedIndex = 1
        static let segmentedControlBorderWidth: CGFloat = 1
        static let segmentedControlCornerRadius: CGFloat = 10
        
        // Fonts
        static let helloLabelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let userNameLabelFont = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let segmentedControlFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    //MARK: - Header UI Elements
    private let profileImageView = ProfileImage.makeImageView()
    private let helloLabel = UILabel()
    private let userNameLabel = UILabel()
    private let settingsButton = UIButton()
    private let headerTextStackView = UIStackView()
    private let headerStackView = UIStackView()
    
    //MARK: - Table UI Elements
    lazy var tableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private let addButton = UIButton()
    
    // MARK: - Property
    var tasks: [String] = []
    
    //MARK: - TabBar UI Elements
    private var segmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = GradientHelper.makeGradientLayer(frame: view.bounds)
        view.layer.insertSublayer(gradient, at: .zero)
    }
    
    private func setupViews() {
        configureProfileImageView()
        configureHelloLabel()
        configureUserNameLabel()
        configureSettingsButton()
        configureHeaderTextStackView()
        configureHeaderStackView()
        configureSegmentedControl()
        configureTableView()
        configureAddButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: TaskListConstants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: TaskListConstants.profileImageSize),
            
            settingsButton.widthAnchor.constraint(equalToConstant: TaskListConstants.settingsButtonSize),
            settingsButton.heightAnchor.constraint(equalToConstant: TaskListConstants.settingsButtonSize),
            
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: TaskListConstants.topMargin),
            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: TaskListConstants.sideMargin),
            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -TaskListConstants.sideMargin),
            headerStackView.heightAnchor.constraint(equalToConstant: TaskListConstants.headerStackViewHeight),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: TaskListConstants.sideMargin),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -TaskListConstants.sideMargin),
            segmentedControl.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: TaskListConstants.segmentTopMargin),
            segmentedControl.heightAnchor.constraint(equalToConstant: TaskListConstants.segmentedControlHeight),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: TaskListConstants.tableViewTopMargin),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: TaskListConstants.sideMargin),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -TaskListConstants.sideMargin),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -TaskListConstants.tableViewBottomToAddButton),
            
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -TaskListConstants.sideMargin),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -TaskListConstants.addButtonBottomMargin),
            addButton.widthAnchor.constraint(equalToConstant: TaskListConstants.addButtonSize),
            addButton.heightAnchor.constraint(equalToConstant: TaskListConstants.addButtonSize)
        ])
    }
    
    private func configureProfileImageView() {
        profileImageView.layer.cornerRadius = TaskListConstants.profileImageCornerRadius
    }
    
    private func configureHelloLabel() {
        helloLabel.text = TaskListConstants.helloText
        helloLabel.font = TaskListConstants.helloLabelFont
        helloLabel.textColor = UIColor.ypTextGray
        helloLabel.numberOfLines = .zero
        helloLabel.textAlignment = .left
    }

    
    private func configureUserNameLabel() {
        userNameLabel.text = TaskListConstants.userNameText
        userNameLabel.font = TaskListConstants.userNameLabelFont
        userNameLabel.textColor = UIColor.ypBlack
        userNameLabel.numberOfLines = .zero
        userNameLabel.textAlignment = .left
    }

    
    private func configureSettingsButton() {
        settingsButton.setTitle("", for: .normal)
        settingsButton.setImage(UIImage.settings, for: .normal)
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
        spacer.widthAnchor.constraint(equalToConstant: TaskListConstants.spacerWidth).isActive = true
        
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
    
    private func configureSegmentedControl() {
        for (index, item) in TaskListConstants.segmentItems.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
        }
        
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.ypGray,
            .font: TaskListConstants.segmentedControlFont
        ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.ypBlack,
            .font: TaskListConstants.segmentedControlFont
        ], for: .selected)
        
        let greenBackground = UIImage(color: UIColor.ypGreen)
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        segmentedControl.setBackgroundImage(greenBackground, for: .selected, barMetrics: .default)
        
        segmentedControl.layer.borderColor = UIColor.ypGreen.cgColor
        segmentedControl.layer.borderWidth = TaskListConstants.segmentedControlBorderWidth
        segmentedControl.layer.cornerRadius = TaskListConstants.segmentedControlCornerRadius
        segmentedControl.clipsToBounds = true
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segmentedControl.selectedSegmentIndex = TaskListConstants.segmentedSelectedIndex
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
    }
    
    
    @objc private func settingsButtonTapped() {
        print("Нажал")
    }
    
    @objc private func addButtonTapped() {
        let alert = UIAlertController(title: TaskListConstants.alertTitle, message: TaskListConstants.alertMessage, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: TaskListConstants.alertSaveTitle, style: .default) { action in
            let textField = alert.textFields?.first
            if let newTask = textField?.text {
                self.tasks.append(newTask)
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField{ _ in }
        
        let cancelAction = UIAlertAction(title: TaskListConstants.alertCancelTitle, style: .default) { _ in }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        print("Добавить нажал")
        
    }
    
    //MARK: - TableView
    private func configureTableView() {
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAddButton() {
        addButton.setTitle("", for: .normal)
        addButton.setImage(UIImage(named: "AddButton"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        addButton.applyCustomShadow()
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(with: tasks[indexPath.row], isChecked: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TaskListConstants.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
    }
}
