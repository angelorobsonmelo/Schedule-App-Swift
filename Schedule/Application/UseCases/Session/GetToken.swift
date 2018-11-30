import Foundation

class GetToken {
    
    private weak var localDataSource: SessionLocalDataSource?
    
    init(localDataSource: SessionLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
}
