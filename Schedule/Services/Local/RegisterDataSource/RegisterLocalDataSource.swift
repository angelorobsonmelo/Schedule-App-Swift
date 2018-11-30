import Foundation
import CoreData

public protocol RegisterLocalDataSource: class {
    
    func register(user: User, password: String, _ apiAuthCallback: @escaping (BaseCallback<User>) -> Void)
}
