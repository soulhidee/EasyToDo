import UIKit

class TaskListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradient = GradientHelper.makeGradientLayer(frame: view.bounds)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
