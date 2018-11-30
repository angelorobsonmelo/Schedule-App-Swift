import Foundation
import SwiftKeychainWrapper
import CoreData

class LoginPresenter: LoginPresenterContract {
    
    private let view: LoginViewContract
    private let getUserSession: GetUserSession
    private let saveSession: SaveSession
    private let context: NSManagedObjectContext

    init(view: LoginViewContract, getUserSession: GetUserSession, saveSession: SaveSession, context: NSManagedObjectContext) {
        self.view           = view
        self.getUserSession = getUserSession
        self.saveSession    = saveSession
        self.context        = context
    }
    
    func login(email: String, password: String) {
       let passwordReturned = KeychainWrapper.standard.string(forKey: email)
        if passwordReturned == password {
            self.view.didLoginSuccess()
            let user = getUser(email: email)
            self.saveSession.saveSession(user: user)
        } else {
            self.view.didLoginError(message: "E-mail or password incorrect")
        }
    }
    
    fileprivate func getUser(email: String) -> User {
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "email = %@", email)
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        
        do {
            let users = try context.fetch(userFetch)
            let user: User = users.first as? User ?? User()
            return user
        } catch {
            print(error.localizedDescription)
        }
        
        return User()
    }
    
}
