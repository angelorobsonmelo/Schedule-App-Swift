import UIKit
import UIColor_Hex_Swift

extension UITextField {
    
    func setPaddingLeft(width: CGFloat = 20) {
        let paddingView   = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView     = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorder(color: UIColor = UIColor.silver, width: Double = 1) {
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowOffset  = CGSize(width: 0.0, height: width)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius  = 0.0
    }
    
    func setBorderRoundInCorners(width: Int = 5, height: Int = 5, positionLeft: UIRectCorner, positionRigth: UIRectCorner,
                                 color: CGColor = UIColor.blue.cgColor) {
        let rectShape          = CAShapeLayer()
        rectShape.bounds       = self.frame
        rectShape.position     = self.center
        rectShape.path         = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [positionLeft, positionRigth], cornerRadii:
            CGSize(width: width, height: height)).cgPath
        self.layer.borderColor = color
        
        self.layer.mask        = rectShape
    }
    
    func setPlaceHolder(placeHolderText: String, color: UIColor = UIColor.slateTwo) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                                      attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setBorderError() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
    }
    
}
