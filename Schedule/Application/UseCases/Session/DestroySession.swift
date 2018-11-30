import CoreData

class DestroySession {
    
    private weak var localDataSource: SessionLocalDataSource?
    
    init(localDataSource: SessionLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func destroySession() -> Bool {
        return (localDataSource?.destroySession())!
    }
    
}
