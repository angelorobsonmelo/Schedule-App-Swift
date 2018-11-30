import CoreData

public protocol SessionLocalDataSource: class {
    
    func save(user: User) 
    func getUser(context: NSManagedObjectContext) -> User
    func isLogged() -> Bool
    func destroySession() -> Bool 
}
