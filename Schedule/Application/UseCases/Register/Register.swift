import Foundation

class Register {
    
        private weak var localDataSource: RegisterLocalDataSource?
    
        init(localDataSource: RegisterLocalDataSource) {
            self.localDataSource = localDataSource
        }
    
    func register(user: User, password: String, _ authCallBack: @escaping (BaseCallback<User>) -> Void) {
        localDataSource?.register(user: user, password: password, { (callback) in
            callback.onSuccess({ (user) in
                let callbackSuccess = BaseCallback.success(user)
                 authCallBack(callbackSuccess)
            })
            
            callback.onFailed({ (error) in
                let callbackFailed = BaseCallback<User>.failed(error: error)
                authCallBack(callbackFailed)
            })
        })

    }
    
}
