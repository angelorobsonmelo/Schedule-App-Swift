import UIKit

extension UIButton {
    
    func setRoundCorners(cornerRadius: CGFloat = 5) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
}
