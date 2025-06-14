import UIKit

final class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"
    
    private var taskLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(named: "YPBlack") ?? .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "YPWhite") ?? .white
            view.layer.cornerRadius = 8
            view.applyCustomShadow()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
}
