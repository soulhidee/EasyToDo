import UIKit

final class RegistrationViewController: UIViewController {
    private let profileImageView = UIImageView()
    private let helloLabel = UILabel()
    private let greetingLabel = UILabel()
    private let nameTextField = UITextField()
    private let startButton = UIButton()
    private let settingsHintLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient(from: "YPGradientStart", to: "YPGradientEnd")
    }
    
    private func setupViews() {
        
    }
    
    
    private func setupConstraints() {
        
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
