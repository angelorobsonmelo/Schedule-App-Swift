import Foundation

class ViewUtils {
    
    static func loadNibNamed<T>(_ nibName: String, owner: Any?) -> T? {
        return Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?[0] as? T
    }
}
