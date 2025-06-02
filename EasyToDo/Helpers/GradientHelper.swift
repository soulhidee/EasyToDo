import UIKit

struct GradientColors {
    static let start = UIColor(named: "YPGradientStart") ?? UIColor.black
    static let end = UIColor(named: "YPGradientEnd") ?? UIColor.white
}

struct GradientHelper {
    static func makeGradientLayer(frame: CGRect,
                                  startColor: UIColor = GradientColors.start,
                                  endColor: UIColor = GradientColors.end,
                                  startPoint: CGPoint = CGPoint(x: 0, y: 0),
                                  endPoint: CGPoint = CGPoint(x: 1, y: 1)) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        return gradientLayer
    }
}
