import Foundation
import SwiftKeychainWrapper
import CoreData

public class RegisterLocalDataSourceImpl: RegisterLocalDataSource {
    
    public static let shared = RegisterLocalDataSourceImpl()

    public func register(user: User, password: String, _ apiAuthCallback: @escaping (BaseCallback<User>) -> Void) {        
        do {
            if userAlreadyExists(email: user.email!) {
                let callbackFailed = BaseCallback<User>.failed(error: "User Already Register")
                apiAuthCallback(callbackFailed)
                return
            }
            
            try user.managedObjectContext?.save()
            savePassword(email: user.email!, password: password)
            let callbackSuccess = BaseCallback.success(user)
            apiAuthCallback(callbackSuccess)
        } catch {
           print(error.localizedDescription)
           let callbackFailed = BaseCallback<User>.failed(error: error.localizedDescription)
           apiAuthCallback(callbackFailed)
        }
        
    }
    
    fileprivate func savePassword(email: String, password: String) {
        KeychainWrapper.standard.set(password, forKey: email)
    }
    
    fileprivate func userAlreadyExists(email: String) -> Bool {
        let emailReturned: String? = KeychainWrapper.standard.string(forKey: email)
        if emailReturned != nil {
            return true
        }
        
        return false
    }
    
}
