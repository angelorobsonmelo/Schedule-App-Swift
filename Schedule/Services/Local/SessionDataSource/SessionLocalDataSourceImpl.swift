import CoreData
import SwiftKeychainWrapper

public class SessionLocalDataSourceImpl: SessionLocalDataSource {
    
    public static let shared = SessionLocalDataSourceImpl()

    public func save(user: User) {
        setUserToKeyChain(DefaultValues.defaultIfNil(user, defaultValue: User()))
    }
    
    fileprivate func setUserToKeyChain(_ user: User) {
        KeychainWrapper.standard.set(user.name!, forKey: Session.NAME)
        KeychainWrapper.standard.set(user.email!, forKey: Session.EMAIL)
        KeychainWrapper.standard.set(true, forKey: Session.LOGGED)
    }
    
    public func isLogged() -> Bool {
        return KeychainWrapper.standard.bool(forKey: Session.LOGGED) ?? false
    }
    
    public func getUser(context: NSManagedObjectContext) -> User {
       let name  = KeychainWrapper.standard.string(forKey: Session.NAME)
       let email = KeychainWrapper.standard.string(forKey: Session.EMAIL)
        
       let user = User(context: context)
       user.name = name
       user.email = email
        
       return user
    }

    public func destroySession() -> Bool {
      let removeName: Bool = KeychainWrapper.standard.removeObject(forKey: Session.NAME)
      let removeEmail: Bool = KeychainWrapper.standard.removeObject(forKey: Session.EMAIL)
      let removeLogged: Bool = KeychainWrapper.standard.removeObject(forKey: Session.LOGGED)
      
      return removeName && removeEmail && removeLogged
    }
    
}
