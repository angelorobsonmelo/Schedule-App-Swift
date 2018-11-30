import Foundation

class SaveSession {
    
    private weak var localDataSource: SessionLocalDataSource?
    
    init(localDataSource: SessionLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func saveSession(user: User) {
        localDataSource?.save(user: user)
    }
    
}
