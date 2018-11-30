import CoreData

class GetUserSession {
    
    private weak var localDataSource: SessionLocalDataSource?
    
    init(localDataSource: SessionLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getUserSession(context: NSManagedObjectContext) -> User {
        return DefaultValues.defaultIfNil(localDataSource?.getUser(context: context), defaultValue: User())
    }
    
}
